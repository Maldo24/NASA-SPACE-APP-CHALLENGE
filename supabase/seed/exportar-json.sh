#!/usr/bin/env bash
# Regenera la semilla JSON de respaldo (src/data/*.json) a partir del seed SQL.
# El SQL es la fuente de verdad; los JSON son una copia generada que lib/data.ts usa
# cuando no hay credenciales de Supabase. NO edites los JSON a mano: edita el SQL y corre esto.
#
# Requiere podman o docker. Uso: bash supabase/seed/exportar-json.sh
set -euo pipefail
cd "$(dirname "$0")/../.."

RUN=$(command -v podman || command -v docker)
NAME=analogos-export-$$
$RUN run -d --rm --name "$NAME" -e POSTGRES_PASSWORD=x docker.io/library/postgres:16 >/dev/null
trap '$RUN stop "$NAME" >/dev/null' EXIT
until $RUN exec "$NAME" pg_isready -U postgres -h 127.0.0.1 >/dev/null 2>&1; do sleep 1; done

PSQL="$RUN exec -i $NAME psql -U postgres -v ON_ERROR_STOP=1 -q -t -A"
echo "create role anon nologin; create role authenticated nologin;" | $PSQL
cat supabase/migrations/*.sql supabase/seed/*.sql | $PSQL

zones_json() {
  $PSQL -c "select jsonb_pretty(jsonb_build_object('type','FeatureCollection','features', coalesce(jsonb_agg(
    jsonb_build_object('type','Feature',
      'properties', jsonb_build_object('id',z.id,'name',z.name,'zoneType',z.zone_type,'description',z.description,
        'geology',z.geology,'environment',z.environment,'exploration',z.exploration,
        'importance',z.importance,'sources',to_jsonb(z.sources),
        'analogIds', (select coalesce(jsonb_agg(za.analog_id order by za.analog_id),'[]') from zone_analogs za where za.zone_id=z.id)),
      'geometry', z.geometry) order by z.id),'[]')))
    from zones z where z.body_id='$1';"
}
zones_json moon > src/data/zones-moon.json
zones_json mars > src/data/zones-mars.json
$PSQL -c "select jsonb_pretty(jsonb_agg(jsonb_build_object('id',a.id,'name',a.name,'category',a.category,'lat',a.lat,'lon',a.lon,
  'why',a.why,'image',a.image,'source',a.source,
  'secondary_categories',a.secondary_categories,'breaking_point',a.breaking_point,
  'aspects', (select coalesce(jsonb_agg(jsonb_build_object('category',s.category,'covers',s.covers,'breaks',s.breaks,'source',s.source)
      order by array_position(array['geomorphological','mineralogical','environmental','operational'], s.category)),'[]')
    from analog_aspects s where s.analog_id=a.id),
  'trainings', (select coalesce(jsonb_agg(jsonb_build_object('audience',t.audience,'activity',t.activity,'measures',t.measures,
      'restrictions',t.restrictions,'source',t.source) order by t.position),'[]')
    from analog_trainings t where t.analog_id=a.id)
  ) order by a.id)) from analogs a;" > src/data/analogs.json

# ---------------------------------------------------------------------
# Revisiones de coherencia (avisan, no detienen la exportación)
# ---------------------------------------------------------------------
warn() { [ -n "$2" ] && printf '\n⚠  %s\n%s\n' "$1" "$2" >&2 || true; }
warn "Límites (06/09) en una categoría que el análogo no tiene como principal ni 'en parte' (05):" \
  "$($PSQL -c "select '   '||s.analog_id||' -> '||s.category from analog_aspects s join analogs a on a.id=s.analog_id
     where s.category <> a.category and not (s.category = any(a.secondary_categories)) order by 1;")"
warn "Análogos que no están en ninguna zona:" \
  "$($PSQL -c "select '   '||id from analogs a where not exists (select 1 from zone_analogs z where z.analog_id=a.id) order by 1;")"
warn "Zonas sin análogos:" \
  "$($PSQL -c "select '   '||id from zones z where not exists (select 1 from zone_analogs za where za.zone_id=z.id) order by 1;")"

# Avance del reparto (docs/REPARTO.md)
$PSQL -c "select 'Avance: límites '||(select count(distinct analog_id) from analog_aspects)||'/'||(select count(*) from analogs)||' análogos'
  ||' | fichas de zona '||(select count(*) from zones where geology is not null)||'/'||(select count(*) from zones)
  ||' | entrenamientos '||(select count(distinct analog_id) from analog_trainings)||'/'||(select count(*) from analogs)||' análogos';"
echo "Listo: src/data/zones-moon.json, zones-mars.json, analogs.json"

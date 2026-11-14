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
        'analogIds', (select coalesce(jsonb_agg(za.analog_id order by za.analog_id),'[]') from zone_analogs za where za.zone_id=z.id)),
      'geometry', z.geometry) order by z.id),'[]')))
    from zones z where z.body_id='$1';"
}
zones_json moon > src/data/zones-moon.json
zones_json mars > src/data/zones-mars.json
$PSQL -c "select jsonb_pretty(jsonb_agg(jsonb_build_object('id',id,'name',name,'category',category,'lat',lat,'lon',lon,
  'why',why,'image',image,'source',source) order by id)) from analogs;" > src/data/analogs.json
echo "Listo: src/data/zones-moon.json, zones-mars.json, analogs.json"

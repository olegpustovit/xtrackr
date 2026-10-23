#!/bin/sh
set -eu
base=${1:-http://127.0.0.1:3000}
printf 'XTrackr prototype: actual local HTTP responses\n\n'
printf 'GET /health\n'
curl -fsS "$base/health"
printf '\n\nPOST /track with a sample payload\n'
curl -fsS -X POST "$base/track" -H 'Content-Type: application/json' -d '{"event_type":"page_view","path":"/demo"}'
printf '\n\nPOST /consent with a sample payload\n'
curl -fsS -X POST "$base/consent" -H 'Content-Type: application/json' -d '{"consent_given":true}'
printf '\n\nThe last two replies are fixed strings, not confirmation of database writes.\n'

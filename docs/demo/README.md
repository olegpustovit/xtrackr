# Local HTTP capture

Captured on 2026-10-23 from source revision
`b22edd5c5e41e6a4959149dd8eeb6a3fb4704fad`.

The locked source build ran on Linux with a local libpq library and an isolated
PostgreSQL 13 container. Startup connected to that database and completed the
embedded migrations. `sh docs/demo/requests.sh http://127.0.0.1:3196` produced
`responses.txt`. A subsequent `select count(*) from events` returned zero.

`responses.png` is a browser-rendered transcript of those actual HTTP responses,
not an analytics dashboard. The track and consent responses are fixed strings
from handlers that do not read their inputs or write to the database.

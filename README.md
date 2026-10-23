# XTrackr

An unfinished Rust HTTP service with a PostgreSQL schema for web analytics.
It starts a connection pool, runs migrations and exposes three routes.

![Actual health and placeholder endpoint responses from a local run](docs/demo/responses.png)

The capture shows the current behavior, including placeholder replies. It does
not demonstrate working analytics. See [capture details](docs/demo/README.md).

## What works and what does not

| Route | Current behavior |
| --- | --- |
| `GET /health` | Return `OK` |
| `POST /track` | Return `Event tracked` without reading or storing the event |
| `POST /consent` | Return `Consent updated` without reading or storing consent |

There is no `/session` route. The privacy settings are loaded but not applied.
IP anonymization, retention, consent management and deletion are not implemented.


## Run locally

You need Rust, PostgreSQL and its `libpq` development library for Diesel. The
recorded run used the locked dependencies and PostgreSQL 13 in a temporary local
container. Use an empty development database; startup runs the migrations.

```sh
git clone https://github.com/olegpustovit/xtrackr.git
cd xtrackr
cargo build --locked
```

Export the nested settings with **double underscores** between their parts:

```sh
export DATABASE__URL='postgres://your-user:your-password@127.0.0.1:5432/xtrackr'
export DATABASE__MAX_CONNECTIONS=2
export SERVER__ADDRESS='127.0.0.1:3000'
export PRIVACY__DATA_RETENTION_DAYS=90
export PRIVACY__ANONYMIZE_IP=true
export PRIVACY__COOKIE_LIFETIME_DAYS=365
cargo run --locked
```

The privacy values are required configuration fields, not enforced policies.
Use credentials for your own local development database, not the literal example.

In another terminal:

```sh
sh docs/demo/requests.sh
```

The service embeds its migrations, so this quick start does not require the
Diesel CLI. The existing Dockerfile and Compose file are legacy setup material;
they have not been qualified and use an old toolchain and different environment
variable names. Use the direct-source instructions above.

## Implementation

The handlers are in [src/main.rs](src/main.rs), configuration in
[src/config.rs](src/config.rs), and database tables in [migrations](migrations).
The database connection does not make the placeholder handlers persist data.
This prototype is not ready to collect real visitor information.

## License

[MIT](LICENSE).

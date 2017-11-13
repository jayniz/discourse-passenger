# Discourse in passenger with docker

This is a little docker image that helps play around with discourse in an
environment where you don't want to use the custom baked docker image with
everything inside, but use other instances of postgres and redis. 

It's not meant to just be used to production, there are a bunch of
limitations to this docker image (no plugins and advanced configuration)
so you should make sure to read [this discussion](https://meta.discourse.org/t/can-discourse-ship-frequent-docker-images-that-do-not-need-to-be-bootstrapped/33205)


## How to use

1. Make sure you set the environment variables to configure discourse (see below)
2. Prepare postgres
  1. create a user
  2. run `postgres -c "psql MY_DATABASE -c 'CREATE EXTENSION hstore;'"`
  3. run `postgres -c "psql MY_DATABASE -c 'CREATE EXTENSION pr_trgm;'"`
3. Run `rake db:migrate` in the discourse container
4. Run `rake admin:create` in the discourse container
5. Configure discourse to store uploads on something like S3


## Docker compose

Here's an example docker-compose to get you up and running:

```yaml
version: '2.1'
services:
  postgres:
    environment:
      - POSTGRES_USER=discourse
      - POSTGRES_DB=discourse
    image: postgres:9
  redis:
    image: redis:4
  discourse:
    environment:
      - DISCOURSE_DB_HOST=postgres
      - DISCOURSE_REDIS_HOST=redis
      - DISCOURSE_RELATIVE_URL_ROOT=/forum
    depends_on:
      postgres:
        condition: service_started
      redis:
        condition: service_started
    image: jannis/discourse-passenger
    ports:
      - 12345:80
```


## Configuration

You can configure a lot of discourse through the `DISCOURSE_*` environment
variables. The following are passed through to the application by passenger
(you can add your own via `nginx/discourse-env.conf`):


- `DISCOURSE_BACKUP_HOSTNAME`
- `DISCOURSE_CDN_URL`
- `DISCOURSE_CONNECTION_REAPER_AGE`
- `DISCOURSE_CONNECTION_REAPER_INTERVAL`
- `DISCOURSE_CORS_ORIGIN`
- `DISCOURSE_DB_HOST`
- `DISCOURSE_DB_NAME`
- `DISCOURSE_DB_PASSWORD`
- `DISCOURSE_DB_POOL`
- `DISCOURSE_DB_PORT`
- `DISCOURSE_DB_PREPARED_STATEMENTS`
- `DISCOURSE_DB_SOCKET`
- `DISCOURSE_DB_TIMEOUT`
- `DISCOURSE_DB_USERNAME`
- `DISCOURSE_DEVELOPER_EMAILS`
- `DISCOURSE_ENABLE_CORS`
- `DISCOURSE_HOSTNAME`
- `DISCOURSE_LOAD_MINI_PROFILER`
- `DISCOURSE_NEW_VERSION_EMAILS`
- `DISCOURSE_REDIS_DB`
- `DISCOURSE_REDIS_HOST`
- `DISCOURSE_REDIS_PASSWORD`
- `DISCOURSE_REDIS_PORT`
- `DISCOURSE_REDIS_SENTINELS`
- `DISCOURSE_RELATIVE_URL_ROOT`
- `DISCOURSE_RTL_CSS`
- `DISCOURSE_SERVE_STATIC_ASSETS`
- `DISCOURSE_SIDEKIQ_WORKERS`
- `DISCOURSE_SMTP_ADDRESS`
- `DISCOURSE_SMTP_AUTHENTICATION`
- `DISCOURSE_SMTP_DOMAIN`
- `DISCOURSE_SMTP_ENABLE_START_TLS`
- `DISCOURSE_SMTP_OPENSSL_VERIFY_MODE`
- `DISCOURSE_SMTP_PASSWORD`
- `DISCOURSE_SMTP_PORT`
- `DISCOURSE_SMTP_USER_NAME`
- `PATH`
- `RAILS_ENV`

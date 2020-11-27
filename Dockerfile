FROM elixir:1.11.2-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base nodejs npm git python3

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
  mix local.rebar --force

# set build ENV
ENV MIX_ENV=prod

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

# build assets
COPY assets/package.json assets/package-lock.json ./assets/
RUN npm --prefix ./assets ci --progress=false --no-audit --loglevel=error

COPY priv priv
COPY assets assets
COPY lib lib

RUN npm run --prefix ./assets deploy
RUN mix phx.digest

# compile and build release
# uncomment COPY if rel/ exists
# COPY rel rel
RUN mix do compile, release

# prepare release image
FROM alpine:3.12.1 AS app

RUN apk add --no-cache bash openssl ncurses-libs

WORKDIR /app

COPY --from=build --chown=nobody:nobody /app/_build/prod/rel/tweeter ./
COPY entrypoint.sh .

RUN chown -R nobody:nobody /app

USER nobody:nobody

ENV HOME=/app
ENV MIX_ENV=prod
ENV PORT=4000

EXPOSE 4000

CMD ["bash", "/app/entrypoint.sh"]

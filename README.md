# README

## build image

```
docker build -t homie:1.1 -t homie .
```

## run image

```
docker run --name homie \
            -e DATABASE_HOST=localhost \
            -e DATABASE_PORT=5432 \
            -e DATABASE_NAME=homie_production \
            -e DATABASE_USERNAME=postgres \
            -e DATABASE_PASSWORD=postgres \
            -e RAILS_LOG_TO_STDOUT=true \
            -e RAILS_SERVE_STATIC_FILES=true \
            -p 80:3000 homie:latest
```

## run speed test

bin/rake internet_speed:run

### with docker compose

docker-compose run web rake internet_speed:run

## import old speedtest log

bin/rake internet_speed:import["~/Downloads/speedtest.log"]


### with docker compose

docker-compose run web rake internet_speed:import["~/Downloads/speedtest.log"]

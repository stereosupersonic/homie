# README

## build image

### docker
```
docker build -t homie:1.1 -t homie .
```

### docker compose

```
docker-compose build
```

## run image 

### docker
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
### docker compose

```
docker-compose run
```

## run speed test

bin/rake internet_speed:run

### with docker compose

docker-compose run web rake internet_speed:run

## import old speedtest log

bin/rake internet_speed:import["~/Downloads/speedtest.log"]


### with docker compose

docker-compose run web rake internet_speed:import["~/Downloads/speedtest.log"]

# production

## build

```
docker-compose -f docker-compose.production.yml build
```

## run

```
docker-compose -f docker-compose.production.yml up -d
```


# database

## backup from a container

```
docker exec -t postgresdb pg_dump -c -U postgres homie_production > dump_homie_`date +%d-%m-%Y"_"%H_%M_%S`.sql
```

## import dump to a contaier db

```
cat dump_09-04-2020_09_34_28.sql | docker exec -i homie_database_1 psql -U postgres homie_development
```

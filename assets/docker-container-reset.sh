#!/bin/bash

cd $(dirname "$0")

docker-compose down
docker-compose stop
docker-compose rm -y

docker network prune -y
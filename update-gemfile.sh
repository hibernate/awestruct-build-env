#!/bin/bash

docker-compose build
docker-compose run awestruct-build-env bundle update "${@}"

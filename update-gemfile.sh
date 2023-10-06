#!/bin/bash -e

COMPOSE=docker-compose
if ! which "$COMPOSE" 2>&1 1>/dev/null
then
	COMPOSE=podman-compose
fi

$COMPOSE build
$COMPOSE run -u "$UID:$GID" awestruct-build-env bundle update "${@}"

#!/bin/bash -e

COMPOSE=podman-compose
if ! which "$COMPOSE" 2>&1 1>/dev/null
then
	COMPOSE="docker compose"
fi

$COMPOSE build
$COMPOSE run -u "$UID:$GID" awestruct-build-env bundle update "${@}"

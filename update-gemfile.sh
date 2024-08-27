#!/bin/bash -e

if which "podman-compose" 2>&1 1>/dev/null
then
	COMPOSE="podman-compose"
	COMPOSE_ARGS_FOR_RUN="--in-pod False"
else
	COMPOSE="docker compose"
fi

$COMPOSE build
$COMPOSE $COMPOSE_ARGS_FOR_RUN run -u "$UID:$GID" awestruct-build-env bundle update "${@}"

# Awestruct build environment for Hibernate websites

[![Docker Repository on Quay](https://quay.io/repository/hibernate/awestruct-build-env/status "Docker Repository on Quay")](https://quay.io/repository/hibernate/awestruct-build-env)

## Building and running Awestruct-based websites in Docker

The following instructions allow you to build/run Awestruct-based websites
such as hibernate.org or in.relation.to within a docker container
while still being able to edit your sources locally.

This is not a Docker introduction.
At least you will need a running Docker daemon.
If you want an intro to Docker, [start here](https://docs.docker.com/)

First, go to your local clone of the website:

```
cd <your locally cloned website>
```

Then run the container:

```
docker run --pull always --rm -t -i -u $UID:$GID -p 4242:4242 -v $(pwd):/home/dev/website:rw,Z quay.io/hibernate/awestruct-build-env:latest
```

Note that, on Linux, you might need to use _sudo_ to execute docker commands.
If you want to avoid that have a look [here](https://docs.docker.com/install/linux/linux-postinstall/#manage-docker-as-a-non-root-user).

Alternatively, with [Podman](https://podman.io/):

```
podman run --pull always --rm -t -i --userns=keep-id -u $UID:$GID -p 4242:4242 -v $(pwd):/home/dev/website:rw,Z quay.io/hibernate/awestruct-build-env:latest
```

This will launch a shell from which you can build/run the website.

For example, to serve the website locally:

```
rake setup
rake clean preview
```

The website should be accessible at <http://localhost:4242>.

You can also use this one-liner to run arbitrary commands non-interactively:

```
docker run --rm=true -t -i -p 4242:4242 --security-opt label:disable -v $(pwd):/home/dev/website quay.io/hibernate/awestruct-build-env:latest "rake setup && rake clean gen[staging]"
```

## Contributing

See CONTRIBUTING.md

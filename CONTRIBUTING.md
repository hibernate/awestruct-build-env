# Awestruct build environment for Hibernate websites

## Legal

You should check the relevant license under which all contributions will be licensed for the specific project you are contributing to.

All contributions are subject to the [Developer Certificate of Origin (DCO)](https://developercertificate.org/).

The DCO text is available verbatim in the [dco.txt](dco.txt) file.

## Guidelines

See https://hibernate.org/community/contribute/.

## Building this image

Just run `docker build .` to build the image locally.

Pushing a tag to the git repository will trigger a build
on [our repository on quay.io](https://quay.io/repository/hibernate/awestruct-build-env).

## Updating dependencies

This build environment is shared by the following websites:

* [hibernate.org](https://github.com/hibernate/hibernate.org)
* [in.relation.to](https://github.com/hibernate/in.relation.to)
* [beanvalidation.org](https://github.com/beanvalidation/beanvalidation.org)

When updating dependencies, update this repository first,
then update each website repository so that Gemfiles stay aligned.

### 1. Update awestruct-build-env

* If needed, update the `Gemfile` (e.g. to add/remove gems or adjust version constraints)
* Run `./update-gemfile.sh` (this will update `Gemfile.lock` in particular)
* Optionally, build the image locally with `docker build .`
* Commit the changes and tag them as necessary

### 2. Update each website

For each website repository listed above:

```
cd <your locally cloned website>
docker run --pull always --rm -u $UID:$GID -v $(pwd):/home/dev/website:rw,Z quay.io/hibernate/awestruct-build-env:latest "bundle update"
```

Or with [Podman](https://podman.io/):

```
podman run --pull always --rm --userns=keep-id -u $UID:$GID -v $(pwd):/home/dev/website:rw,Z quay.io/hibernate/awestruct-build-env:latest "bundle update"
```

After updating, build the website to verify everything still works:

```
rake clean preview
```

Point your browser to http://localhost:4242 and check the site renders correctly.
Commit the updated `Gemfile.lock` once the build succeeds.

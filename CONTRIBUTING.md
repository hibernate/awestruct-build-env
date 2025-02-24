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

If you need to update dependencies:

* update the `Gemfile`
* run `./update-gemfile.sh` (this will update `Gemfile.lock` in particular)
* optionally:
  * build the image with the Gemfiles updated using `docker build .`
  * test the image
* commit the changes and tag them as necessary

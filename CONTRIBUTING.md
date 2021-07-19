# Awestruct build environment for Hibernate websites

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

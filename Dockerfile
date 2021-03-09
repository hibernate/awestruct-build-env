FROM       quay.io/fedora/fedora:33-x86_64

# Install the required dependencies to compile native extensions
RUN        dnf -y update && dnf -y install gcc-c++ make ruby-devel libxml2-devel libxslt-devel findutils git ruby tar redhat-rpm-config which python2 patchutils && dnf clean all

RUN        groupadd -r dev && useradd  -g dev -u 1000 dev
RUN        mkdir -p /home/dev/
RUN        chown dev:dev /home/dev

# From here we run everything as dev user
USER       dev

# Setup all the env variables needed for ruby
ENV        HOME /home/dev
ENV        GEM_HOME $HOME/.gem/ruby
ENV        GEM_PATH $GEM_HOME
ENV        PATH $HOME/bin:$GEM_HOME/bin:$PATH

RUN        mkdir $HOME/.gems

# Set umask to 000 next time bash is started
COPY       profile .profile

# Pre-install a few gems
# Applications may end up using different versions,
# but hopefully at least *some* of the pre-installed gems will be useful
RUN        mkdir -p /home/dev/template
WORKDIR    /home/dev/template
COPY       Gemfile Gemfile
COPY       Gemfile.lock Gemfile.lock
RUN        gem install -N rake
RUN        gem install -N bundler -v '2.1.4'
RUN        bundle install

EXPOSE     4242
VOLUME     $HOME/website
WORKDIR    $HOME/website

# Use bash --login so that the locale defaults to C.UTF-8, not POSIX (= ASCII).
# This is important for the templating engine, tilt, in particular.
# Make sure to install (update) rake and bundler when starting the container.
ENTRYPOINT ["/bin/bash", "--login", "-c", "eval ${@}", "awestruct-build-env"]
# When rake and bundler, by default, run bash
# This can be overridden in the "docker run" command to run rake directly
CMD ["bash"]


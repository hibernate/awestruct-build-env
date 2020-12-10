FROM       fedora:33

# Install the required dependencies to complile native extensions
RUN        dnf makecache
RUN        dnf -y install gcc-c++ make ruby-devel libxml2-devel libxslt-devel findutils git ruby tar redhat-rpm-config

RUN        groupadd -r dev && useradd  -g dev -u 1000 dev
RUN        mkdir -p /home/dev
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

EXPOSE     4242
VOLUME     $HOME/website
WORKDIR    $HOME/website

# Pre-install rake, bundler, awestruct
ARG        awestruct_version
RUN        gem install -N awestruct -v ${awestruct_version}
RUN        gem install -N rake bundler

# Use bash --login so that the locale defaults to C.UTF-8, not POSIX (= ASCII).
# This is important for the templating engine, tilt, in particular.
# Make sure to install (update) rake and bundler when starting the container.
ENTRYPOINT ["/bin/bash", "--login", "-c", "eval ${@}", "awestruct-build-env", "gem install -N rake bundler &&"]
# When rake and bundler, by default, run bash
# This can be overridden in the "docker run" command to run rake directly
CMD ["bash"]


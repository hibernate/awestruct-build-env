FROM       fedora:31

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
ENV        LANG en_US.UTF-8
ENV        LC_ALL en_US.UTF-8

RUN        mkdir $HOME/.gems

EXPOSE     4242
VOLUME     $HOME/website
WORKDIR    $HOME/website

# Pre-install rake so that the command is already available when
# "eval" intrprets the entrypoint command below.
# Without this, we would get an error about rake being an unknown command.
RUN        gem install -N rake bundler

# Make sure to install all the necessary gems when starting the container
ENTRYPOINT ["/bin/sh", "-c", "eval ${@}", "gem install -N rake bundler &&", "rake setup &&"]
# When gems are installed, by default, run bash
# This can be overridden in the "docker run" command to run rake directly
CMD ["bash"]


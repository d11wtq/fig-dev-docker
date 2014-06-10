# Docker container for developing fig

This is a docker container that I use for developing
[fig](https://github.com/orchardup/fig). It's probably the most complicated
docker container that I use, since it actually requires running docker itself.

## Components

The container provides the things needed to develop fig. In essence, that means
Python 2.x (2.7) and Docker. Also included are setuptools and pip.

## Usage

Run bash and share fig using a volume.

    docker run -ti -v /path/to/fig:/fig d11wtq/fig-dev bash

When the container starts, docker should be running (try `docker info`) and you
should be in bash. I don't include fig in the image itself, so that needs
mounting as a volume. This is simply because I want to edit the source and
manage git on the host itself.

You should be able to run the tests:

    cd /fig
    python setup.py test

## How it works

The work is based on [dind](https://github.com/jpetazzo/dind) by @jpetazzo,
though it has been modified to use a system init script to manage the docker
daemon, which is triggered on login through the ~/.bashrc. It is *very*
important that docker is stopped before the container exits too, otherwise
eventually the host will run out of loopback devices that cannot be easily
reclaimed. This is also managed through an exit trap in ~/.bashrc.

Rather than use aufs (which would be faster), this container uses devicemapper
so that there is no need to mount a volume to /var/lib/docker, which uses disk
space on the host machine even after the container has exited. Devicemapper
depends on the ability to create loopback devices mounted to /var/lib/docker in
the container, however, so we have to do some additional work to ensure these
devices are unmounted when the container exits.

The init script also prepares the necessary cgroup mounts if they do not yet
exist.

See [etc/init.d/docker](etc/init.d/docker) and [.bashrc](.bashrc) if you're
interested in the code.

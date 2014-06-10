# Dockerfile to build a container for developing on github.com/orchardup/fig
#
# Effectively provides Python 2.x and Docker (requires --privileged)

FROM       d11wtq/python:2.7.7
MAINTAINER Chris Corbyn <chris@w3style.co.uk>

RUN sudo groupadd docker
RUN sudo usermod default -aG docker

RUN sudo apt-get update -qq -y
RUN sudo apt-get install -qq -y iptables ca-certificates

ADD https://get.docker.io/builds/Linux/x86_64/docker-0.11.1 /usr/local/bin/docker
ADD etc/init.d/docker /etc/init.d/docker
ADD .bashrc           /home/default/.bashrc

RUN sudo chmod 0755 /usr/local/bin/docker /etc/init.d/docker

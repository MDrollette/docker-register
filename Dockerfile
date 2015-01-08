FROM ubuntu:14.04
MAINTAINER Jason Wilder jwilder@litl.com

RUN apt-get update
RUN apt-get install -y wget python python-pip python-dev libssl-dev libffi-dev bash

RUN mkdir /app
WORKDIR /app

ADD docker-gen-linux-amd64 /usr/local/bin/docker-gen

RUN pip install python-etcd

ADD . /app

ENV DOCKER_HOST unix:///var/run/docker.sock

CMD docker-gen -interval 5 -watch -notify "python /tmp/register.py" vulcand.tmpl /tmp/register.py

FROM ubuntu:trusty
MAINTAINER Åsmund Grammeltvedt <asmundg@snap.tv>

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    apt-transport-https \
    git \
    openssh-server \
    openjdk-7-jre-headless
RUN echo 'deb https://get.docker.com/ubuntu docker main' >> /etc/apt/sources.list
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 36A1D7869245C8950F966E92D8576A8BA88D21E9
RUN apt-get update
RUN apt-get install -y --no-install-recommends lxc-docker

RUN echo "root:root" | chpasswd
RUN sed -i "s/PermitRootLogin .*/PermitRootLogin yes/" /etc/ssh/sshd_config
RUN mkdir -p /var/run/sshd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]

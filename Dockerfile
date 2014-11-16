FROM jpetazzo/dind
MAINTAINER Aasmund Grammeltvedt <asmundg@snap.tv>

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    git \
    openssh-server \
    openjdk-7-jre-headless

RUN echo "root:root" | chpasswd
RUN sed -i "s/PermitRootLogin .*/PermitRootLogin yes/" /etc/ssh/sshd_config
RUN mkdir -p /var/run/sshd

EXPOSE 22
VOLUME ["/var/lib/docker"]
CMD ["/usr/sbin/sshd", "-D"]

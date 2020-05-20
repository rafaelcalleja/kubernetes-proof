FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive;

RUN apt-get -qq -y update --allow-releaseinfo-change && \
    apt-get -qq -y upgrade && \
    apt-get -qq -y install python3 \
    python3-pip \
    python3-apt \
    curl \
    apt-transport-https \
    ca-certificates \
    gnupg-agent \
    software-properties-common && \
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    pip3 install ansible && \
    pip3 install openshift && \
    apt-get update -y && \
    apt-get install -y docker-ce docker-ce-cli containerd.io  && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/aptp-get/lists/*

RUN ansible-galaxy install geerlingguy.jenkins && \
    ansible-galaxy install geerlingguy.docker && \
    ansible-galaxy install geerlingguy.java

COPY playbook.yaml /

ARG JENKINS_HOSTNAME
ARG JENKINS_PORT
ARG JENKINS_ADMIN_USERNAME
ARG JENKINS_ADMIN_PASSWORD

RUN mkdir -p -- ~/lib && \
    cp /lib/x86_64-linux-gnu/libnss_files.so.2 ~/lib && \
    sed -i 's:/etc/hosts:/tmp/hosts:g' ~/lib/libnss_files.so.2 && \
    cp /etc/hosts /tmp/hosts && \
    sed -i "s/$(hostname)/$(hostname) ${JENKINS_HOSTNAME}/g" /tmp/hosts

ENV LD_LIBRARY_PATH=/root/lib

RUN ansible-playbook -e "JENKINS_HOSTNAME=${JENKINS_HOSTNAME} JENKINS_PORT=${JENKINS_PORT} JENKINS_ADMIN_USERNAME=${JENKINS_ADMIN_USERNAME} JENKINS_ADMIN_PASSWORD=${JENKINS_ADMIN_PASSWORD}" /playbook.yaml

ENV DEBIAN_FRONTEND=
ENV LD_LIBRARY_PATH=
RUN rm ~/lib -rf

CMD service jenkins start && tail -f /dev/null
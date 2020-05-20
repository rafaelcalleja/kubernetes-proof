FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive;

RUN apt-get -qq -y update --allow-releaseinfo-change && \
    apt-get -qq -y upgrade && \
    apt-get -qq -y install  ppython3 && \
    pip3 install ansible && \
    pip3 install openshift && \
    apt-get -y autoclean && \
    apt-get -y autoremove && \
    rm -rf /var/lib/aptp-get/lists/*
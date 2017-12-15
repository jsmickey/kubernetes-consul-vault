FROM ubuntu:xenial-20171114
MAINTAINER John Mickey
USER root
RUN apt update && apt -y upgrade
RUN apt update && apt -y install curl jq vim wget zip
RUN wget https://releases.hashicorp.com/vault/0.9.0/vault_0.9.0_linux_amd64.zip
RUN unzip vault_0.9.0_linux_amd64.zip
RUN mv vault /usr/local/bin/

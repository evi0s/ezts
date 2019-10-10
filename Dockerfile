FROM node:latest

MAINTAINER evi0s

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /app

ADD . /app

RUN apt-get update -y && \
    apt-get install vim net-tools wget \
    curl lsb-release gnupg telnet psmisc \
    software-properties-common dirmngr -y && \
    apt-key adv --recv-keys --keyserver \
    keyserver.ubuntu.com 0xF1656F24C74CD1D8 && \
    add-apt-repository \
    'deb [arch=amd64,i386,ppc64el] http://mirrors.tuna.tsinghua.edu.cn/mariadb/repo/10.4/debian stretch main'

RUN apt-get update && \
    apt-get install mariadb-server -y

RUN useradd -d /app www && \
    chown -R www.www /app

RUN chmod 0700 /app/entrypoint.sh

EXPOSE 3000

ENTRYPOINT /app/entrypoint.sh

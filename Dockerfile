FROM ubuntu:18.04
RUN apt-get update && apt-get install -y \
    apt-transport-https \
    apt-utils \
    bash \
    curl \
    git \
    gnupg \
    less \
    lsof \
    net-tools \
    unzip \
    wget \
    xz-utils \
    openjdk-8-jre \
    && mkdir /works \
    && sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -' \
    && sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list' \
    && apt-get update && apt-get install dart \
    && wget https://storage.googleapis.com/flutter_infra/releases/stable/linux/flutter_linux_v1.9.1+hotfix.6-stable.tar.xz \
    && wget https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip \
    && mkdir /works/development

ENV PATH="${PATH}:/usr/lib/dart/bin/"
ENV PATH="${PATH}:/root/.pub-cache/bin"
ENV PATH="${PATH}:/works/development/flutter/bin"
ENV PATH="${PATH}:/works/development/tools/bin"

RUN pub global activate webdev && pub global activate stagehand
WORKDIR /works/development
RUN tar xf /flutter_linux_v1.9.1+hotfix.6-stable.tar.xz\
    && unzip /sdk-tools-linux-4333796.zip\
    && flutter precache
    
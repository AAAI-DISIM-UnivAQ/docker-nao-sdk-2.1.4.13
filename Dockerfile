FROM --platform=linux/386 ubuntu:14.04
ARG ARCH=i386
LABEL maintainer="jodeg@giodegas.it"

RUN apt update -y && apt upgrade && apt install wget -y

WORKDIR /tmp/download
RUN wget https://community-static.aldebaran.com/resources/2.1.4.13/sdk-python/pynaoqi-python2.7-2.1.4.13-linux32.tar.gz
RUN wget https://community-static.aldebaran.com/resources/2.1.4.13/choregraphe/choregraphe-suite-2.1.4.13-linux32.tar.gz
RUN wget https://community-static.aldebaran.com/resources/2.1.4.13/sdk-c%2B%2B/naoqi-sdk-2.1.4.13-linux32.tar.gz

WORKDIR /tmp/naodev
RUN tar zxvf /tmp/download/pynaoqi-python2.7-2.1.4.13-linux32.tar.gz
RUN tar zxvf /tmp/download/choregraphe-suite-2.1.4.13-linux32.tar.gz
RUN tar zxvf /tmp/download/naoqi-sdk-2.1.4.13-linux32.tar.gz


# to build:
#   docker build --squash . -t nao-sdk-v5
# to run:
#   docker run -it --name=naosdk nao-sdk-v5

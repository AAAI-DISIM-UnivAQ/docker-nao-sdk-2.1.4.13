FROM --platform=linux/386 dorowu/ubuntu-desktop-lxde-vnc:bionic
ARG ARCH=i386
LABEL maintainer="jodeg@giodegas.it"

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openbox tint2 xdg-utils lxterminal hsetroot tigervnc-standalone-server supervisor && \
    rm -rf /var/lib/apt/lists

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends vim openssh-client wget curl rsync ca-certificates apulse libpulse0 firefox htop tar xzip gzip bzip2 zip unzip && \
    rm -rf /var/lib/apt/lists

WORKDIR /tmp/download
RUN wget https://community-static.aldebaran.com/resources/2.1.4.13/sdk-python/pynaoqi-python2.7-2.1.4.13-linux32.tar.gz
RUN wget https://community-static.aldebaran.com/resources/2.1.4.13/choregraphe/choregraphe-suite-2.1.4.13-linux32.tar.gz
RUN wget https://community-static.aldebaran.com/resources/2.1.4.13/sdk-c%2B%2B/naoqi-sdk-2.1.4.13-linux32.tar.gz

WORKDIR /tmp/naodev
RUN tar zxvf /tmp/download/pynaoqi-python2.7-2.1.4.13-linux32.tar.gz
RUN tar zxvf /tmp/download/choregraphe-suite-2.1.4.13-linux32.tar.gz
RUN tar zxvf /tmp/download/naoqi-sdk-2.1.4.13-linux32.tar.gz

EXPOSE 6079

# to build:
#   docker build . -t nao-sdk-v5
# to run:
#   docker run -it -p 6079:6079 --name=naosdk nao-sdk-v5

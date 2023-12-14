FROM golang:bullseye AS easy-novnc-build
WORKDIR /src
RUN go mod init build && \
    go get github.com/geek1011/easy-novnc@v1.1.0 && \
    go build -o /bin/easy-novnc github.com/geek1011/easy-novnc

FROM ubuntu:bionic
ARG ARCH=i386
ENV DEBIAN_FRONTEND=noninteractive 

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends openbox tint2 xdg-utils lxterminal hsetroot tigervnc-standalone-server supervisor && \
    rm -rf /var/lib/apt/lists

RUN apt-get update -y && \
    apt-get install -y --no-install-recommends vim openssh-client wget curl rsync ca-certificates apulse libpulse0 firefox htop tar xzip gzip bzip2 zip unzip && \
    rm -rf /var/lib/apt/lists

COPY --from=easy-novnc-build /bin/easy-novnc /usr/local/bin/
COPY supervisord.conf /etc/
COPY menu.xml /etc/xdg/openbox/
RUN echo 'hsetroot -solid "#123456" &' >> /etc/xdg/openbox/autostart

RUN mkdir -p /etc/firefox
RUN echo 'pref("browser.tabs.remote.autostart", false);' >> /etc/firefox/syspref.js

RUN mkdir -p /root/.config/tint2
COPY tint2rc /root/.config/tint2/

WORKDIR /tmp/download
RUN wget https://community-static.aldebaran.com/resources/2.1.4.13/sdk-python/pynaoqi-python2.7-2.1.4.13-linux64.tar.gz
RUN wget https://community-static.aldebaran.com/resources/2.1.4.13/choregraphe/choregraphe-suite-2.1.4.13-linux64.tar.gz
RUN wget https://community-static.aldebaran.com/resources/2.1.4.13/sdk-c%2B%2B/naoqi-sdk-2.1.4.13-linux64.tar.gz

WORKDIR /tmp/naodev
RUN tar zxvf /tmp/download/pynaoqi-python2.7-2.1.4.13-linux64.tar.gz
RUN tar zxvf /tmp/download/choregraphe-suite-2.1.4.13-linux64.tar.gz
RUN tar zxvf /tmp/download/naoqi-sdk-2.1.4.13-linux64.tar.gz

EXPOSE 8080
ENTRYPOINT ["/bin/bash", "-c", "/usr/bin/supervisord"]

# to build:
#   docker build . -t nao-sdk-v5
# to run:
#   docker run -it -p 6080:6080 -p 5900:5900 --name=naosdk nao-sdk-v5

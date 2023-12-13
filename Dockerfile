FROM keyz182/ubuntu-lxde-novnc
LABEL org.opencontainers.image.authors="jodeg@giodegas.it"

RUN apt update -y
RUN apt remove --purge libreoffice* -y
RUN apt upgrade -y
RUN apt install wget -y

WORKDIR /tmp/download
RUN wget https://community-static.aldebaran.com/resources/2.1.4.13/sdk-python/pynaoqi-python2.7-2.1.4.13-linux64.tar.gz
RUN wget https://community-static.aldebaran.com/resources/2.1.4.13/choregraphe/choregraphe-suite-2.1.4.13-linux64.tar.gz
RUN wget https://community-static.aldebaran.com/resources/2.1.4.13/sdk-c%2B%2B/naoqi-sdk-2.1.4.13-linux64.tar.gz

WORKDIR /tmp/naodev
RUN tar zxvf /tmp/download/pynaoqi-python2.7-2.1.4.13-linux64.tar.gz
RUN tar zxvf /tmp/download/choregraphe-suite-2.1.4.13-linux64.tar.gz
RUN tar zxvf /tmp/download/naoqi-sdk-2.1.4.13-linux64.tar.gz
#RUN echo "export PYTHONPATH=${PYTHONPATH}:/tmp/naodev/pynaoqi-python2.7-2.1.4.13-linux64" >> /home/ubuntu/.bashrc

WORKDIR /miniconda3
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O miniconda.sh
RUN bash /miniconda3/miniconda.sh -b -u -p /miniconda3
RUN rm -rf /miniconda3/miniconda.sh

WORKDIR /tmp/naodev
COPY testnao.py .
COPY init.sh .
COPY bashrc .

EXPOSE 5900
EXPOSE 6080

# to build:
#   docker build . -t nao-sdk-v5
# to run:
#   docker run -it -p 6080:6080 -p 5900:5900 --name=naosdk nao-sdk-v5

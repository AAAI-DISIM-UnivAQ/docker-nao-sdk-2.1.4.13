# docker-nao-sdk-2.1.4.13
Ubuntu 14.04 with a complete Python 2.7.18 and C++ NAOqi SDK 2.1.4.13

# Install

    git clone https://github.com/AAAI-DISIM-UnivAQ/docker-nao-sdk-2.1.4.13.git
    cd docker-nao-sdk-2.1.4.13
    docker build . -t nao-sdk-v5

# Create container 

    docker run -it -p 6080:6080 -p 5900:5900 --name=naosdk nao-sdk-v5

finalize the install inside the container shell (copy the shown password):

    # login ubuntu
    Password:...
    cd /tmp/naodev
    bash init.sh
    exit
    
then open a NOVNC graphical session in the brower with the URL: 

    http://localhost:6080

open a LXTerminal and start to develop for the NAO robot

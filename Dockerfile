FROM ubuntu:25.04

# Update package list
RUN apt update

# Install base system tools
RUN apt install -y openssh-server
RUN apt install -y sudo
RUN apt install -y curl
RUN apt install -y wget
RUN apt install -y ca-certificates
RUN apt install -y gnupg
RUN apt install -y lsb-release
RUN apt install -y apt-transport-https
RUN apt install -y software-properties-common

# Install text editors
RUN apt install -y vim
RUN apt install -y nano

# Install basic utilities
RUN apt install -y git
RUN apt install -y tree
RUN apt install -y unzip
RUN apt install -y zip
RUN apt install -y htop
RUN apt install -y telnet

# Install build tools
RUN apt install -y build-essential

# Install Node.js and npm
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt-get install -y nodejs

# Install Python and pip
RUN apt install -y python3
RUN apt install -y python3-pip
RUN apt install -y python3-venv

# Install Docker CLI
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt update
RUN apt install -y docker-ce-cli

# Install Go
RUN wget -O go.tar.gz https://go.dev/dl/go1.21.6.linux-amd64.tar.gz
RUN tar -C /usr/local -xzf go.tar.gz
RUN rm go.tar.gz
ENV PATH=$PATH:/usr/local/go/bin

# Install modern CLI tools - JSON processing
RUN apt install -y jq

# Install modern CLI tools - Search and find
RUN apt install -y ripgrep
RUN apt install -y fd-find

# Install modern CLI tools - File viewing
RUN apt install -y bat

# Install modern CLI tools - Fuzzy finder
RUN apt install -y fzf

# Install terminal multiplexer
RUN apt install -y tmux
RUN apt install -y screen

# Install system info tools
RUN apt install -y neofetch
RUN apt install -y ncdu
RUN apt install -y ranger

# Install network tools
RUN apt install -y nmap
RUN apt install -y netcat-openbsd
RUN apt install -y tcpdump
RUN apt install -y dnsutils
RUN apt install -y net-tools
RUN apt install -y iperf3

# Install file transfer tools
RUN apt install -y rsync

# Install debugging and tracing tools
RUN apt install -y strace
RUN apt install -y ltrace
RUN apt install -y lsof

# Install system monitoring tools
RUN apt install -y iotop
RUN apt install -y iftop

# Install development and debugging tools
RUN apt install -y gdb
RUN apt install -y valgrind
RUN apt install -y perf-tools-unstable
RUN apt install -y binutils
RUN apt install -y xxd

# Install database clients
RUN apt install -y sqlite3
RUN apt install -y redis-tools
RUN apt install -y postgresql-client
RUN apt install -y mysql-client

# Install web and load testing tools
RUN apt install -y apache2-utils

# Install stress testing tools
RUN apt install -y stress
RUN apt install -y stress-ng

# Install system statistics tools
RUN apt install -y sysstat

# Install some useful aliases and configurations
RUN echo 'alias ll="ls -alF"' >> /etc/bash.bashrc && \
    echo 'alias la="ls -A"' >> /etc/bash.bashrc && \
    echo 'alias l="ls -CF"' >> /etc/bash.bashrc && \
    echo 'alias grep="grep --color=auto"' >> /etc/bash.bashrc && \
    echo 'alias fgrep="fgrep --color=auto"' >> /etc/bash.bashrc && \
    echo 'alias egrep="egrep --color=auto"' >> /etc/bash.bashrc && \
    echo 'alias cat="batcat"' >> /etc/bash.bashrc && \
    echo 'alias find="fdfind"' >> /etc/bash.bashrc

RUN service ssh start

EXPOSE 22

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

CMD ["/entrypoint.sh"]

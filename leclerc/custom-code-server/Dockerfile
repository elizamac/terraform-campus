FROM linuxserver/code-server:4.22.0
### Install packages
RUN apt-get update && \
    apt-get install -y openjdk-19-jdk vim build-essential && \
    apt-get clean && \
    rm -rf \
        /config/* \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*
### Install rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
#RUN chmod -R 700 /config/.ssh/{github,gitlab}
### Install go
RUN curl -OL https://go.dev/dl/go1.21.8.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.22.8.linux-amd64.tar.gz

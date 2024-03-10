FROM linuxserver/code-server:4.22.0
RUN apt-get update && \
    apt-get install -y openjdk-19-jdk vim && \
    apt-get clean && \
    curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    rm -rf \
        /config/* \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*
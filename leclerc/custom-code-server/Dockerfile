FROM linuxserver/code-server:4.22.0
RUN apt-get update && \
    apt-get install -y openjdk-19-jdk vim build-essential && \
    apt-get clean && \
    cd /config && curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    source config/.cargo/env && \
    rm -rf \
        /config/* \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/* && \
    chmod -R 700 /config/.ssh/{github,gitlab}

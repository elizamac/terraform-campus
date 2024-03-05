FROM linuxserver/code-server:4.22.0
RUN apt-get update && \
    apt-get install -y openjdk-19-jdk vim && \
    apt-get clean && \
    rm -rf \
        /config/* \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*
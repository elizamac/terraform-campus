FROM linuxserver/code-server:4.22.0
RUN apt-get update && \
    apt-get install -y openjdk-19-jdk vim build-essential && \
    apt-get clean && \
    rm -rf \
        /config/* \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
#RUN chmod -R 700 /config/.ssh/{github,gitlab}

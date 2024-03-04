FROM linuxserver/code-server:4.22.0
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list && \
    apt-get update && \
    apt-get install -y openjdk-19-jdk terraform && \
    apt-get clean && \
    rm -rf \
        /config/* \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*
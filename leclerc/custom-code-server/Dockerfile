FROM linuxserver/code-server:4.22.0
### Update repos
RUN apt-get update
### Install JDK and VIM
RUN apt-get install -y openjdk-19-jdk vim wget
### Install Rust dependencies
RUN apt-get install -y build-essential
### Install Rust tools
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
#RUN chmod -R 700 /config/.ssh/{github,gitlab}
### Install Go
RUN wget https://go.dev/dl/go1.22.1.linux-amd64.tar.gz && \
    tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz
### Install Python
RUN apt-get install -y python3.10
### Add Terraform repo
RUN wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/hashicorp.list
### Install Terraform
RUN apt-get update && apt-get install -y terraform
### Cleanup apt caches
RUN apt-get clean && \
    rm -rf \
        /config/* \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*
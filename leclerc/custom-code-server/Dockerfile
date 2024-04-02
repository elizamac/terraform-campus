FROM linuxserver/code-server:4.22.0
### Update repos
RUN apt-get update
### Install JDK and VIM
RUN apt-get install -y openjdk-19-jdk vim
### Install Rust dependencies
RUN apt-get install -y build-essential
### Install Rust tools
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y && \
    echo 'source $HOME/.cargo/env' >> $HOME/.bashrc
#RUN chmod -R 700 /config/.ssh/{github,gitlab}
### Install Go
#RUN curl -OL https://go.dev/dl/go1.22.1.linux-amd64.tar.gz && \
#    rm -rf /usr/local/go && \
#    tar -C /usr/local -xzf go1.22.1.linux-amd64.tar.gz
### Install Terraform dependencies
RUN apt-get install -y wget unzip
### Install Terraform
RUN wget https://releases.hashicorp.com/terraform/1.7.5/terraform_1.7.5_linux_amd64.zip && \
    unzip terraform_1.7.5_linux_amd64.zip && \
    mv terraform_* /usr/bin/
### Install Python
RUN apt-get install -y python3.10
### Cleanup apt caches
RUN apt-get clean && \
    rm -rf \
        /config/* \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*
ARG BASE_IMAGE=ubuntu:latest

FROM ${BASE_IMAGE}

ARG DNSCONTROL_VERSION=4.15.5

RUN apt-get update && apt-get install -y traceroute dnsutils ca-certificates wget curl make git zsh unzip sudo python3-pip vim build-essential python3-kubernetes
RUN apt update && apt install software-properties-common -y && add-apt-repository --yes --update ppa:ansible/ansible && apt install ansible -y
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata
RUN apt install -y graphviz
RUN pip install diagrams --break-system-packages

RUN wget https://github.com/StackExchange/dnscontrol/releases/download/v${DNSCONTROL_VERSION}/dnscontrol-${DNSCONTROL_VERSION}.arm64.deb && dpkg -i dnscontrol-${DNSCONTROL_VERSION}.arm64.deb

RUN wget --secure-protocol=TLSv1_2 --https-only https://get.opentofu.org/install-opentofu.sh -O install-opentofu.sh
RUN chmod +x install-opentofu.sh && ./install-opentofu.sh --install-method standalone --skip-verify && rm install-opentofu.sh

RUN useradd -m -s /bin/zsh lab
RUN usermod -aG sudo lab
USER lab

RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/home/lab/.cargo/bin:${PATH}"

RUN cargo install just git-cliff
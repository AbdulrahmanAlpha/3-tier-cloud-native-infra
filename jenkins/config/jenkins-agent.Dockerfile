FROM jenkins/inbound-agent:latest

USER root
RUN apt-get update && apt-get install -y \
    awscli \
    docker.io \
    kubectl \
    curl \
    jq \
    git \
    && curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash \
    && rm -rf /var/lib/apt/lists/*

USER jenkins

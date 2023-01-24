FROM debian:stable-20221004-slim

LABEL maintainer="rameshcreations"

RUN apt-get update && apt-get install -y unzip curl git jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# awscli
RUN curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o aws_cli.zip \
    && unzip aws_cli.zip \
    && ./aws/install

# Packer
ARG PACKER_VERSION=1.8.2
RUN curl -s https://releases.hashicorp.com/packer/${PACKER_VERSION}/packer_${PACKER_VERSION}_linux_amd64.zip -o packer.zip \
    && unzip packer.zip \
    && chmod 0755 packer \
    && mv packer /usr/local/bin

# Terraform
ARG TERRAFORM_VERSION=1.2.4
RUN curl -s https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && chmod 0755 terraform \
    && mv terraform /usr/local/bin

# Terragrunt
ARG TERRAGRUNT_VERSION=0.38.4
RUN curl -sL https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -o terragrunt \
    && chmod 0755 terragrunt \
    && mv terragrunt /usr/local/bin

# aws-vault
ARG AWS_VAULT_VERSION=6.6.0
RUN curl -sL https://github.com/99designs/aws-vault/releases/download/v${AWS_VAULT_VERSION}/aws-vault-linux-amd64 -o aws-vault \
    && chmod 0755 aws-vault \
    && mv aws-vault /usr/local/bin

# driftctl
ARG DRIFTCTL_VERSION=0.37.0
RUN curl -sL https://github.com/snyk/driftctl/releases/download/v${DRIFTCTL_VERSION}/driftctl_linux_amd64 -o driftctl \
    && chmod 0755 driftctl \
    && mv driftctl /usr/local/bin

# tfsec
ARG TFSEC_VERSION=1.27.5
RUN curl -sL https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64 -o tfsec \
    && chmod 0755 tfsec \
    && mv tfsec /usr/local/bin

# tflint
ARG TFLINT_VERSION=0.39.3
RUN curl -sL https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip -o tflint.zip \
    && unzip tflint.zip \
    && chmod 0755 tflint \
    && mv tflint /usr/local/bin

# infracost
ARG INFRACOST_VERSION=0.10.11
RUN curl -sL https://github.com/infracost/infracost/releases/download/v${INFRACOST_VERSION}/infracost-linux-amd64.tar.gz -o infracost.tar.gz \
    && tar -xf infracost.tar.gz \
    && chmod 0755 infracost-linux-amd64 \
    && mv infracost-linux-amd64 /usr/local/bin/infracost

# kubectl
ARG KUBECTL_VERSION=1.24.2
RUN curl -sLO https://dl.k8s.io/release/v${KUBECTL_VERSION}/bin/linux/amd64/kubectl \ 
    && install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# helm
ARG HELM_VERSION=3.9.4
RUN curl -sL https://get.helm.sh/helm-v${HELM_VERSION}-linux-amd64.tar.gz -o helm.tar.gz \
    && tar -xf helm.tar.gz \
    && chmod 0755 linux-amd64/helm \
    && mv linux-amd64/helm /usr/local/bin/helm

# task
ARG TASK_VERSION=3.16.0
RUN curl -s -L https://github.com/go-task/task/releases/download/v${TASK_VERSION}/task_linux_amd64.tar.gz -o task.tar.gz \
    && tar -xf task.tar.gz \
    && chmod 0755 task \
    && mv task /usr/local/bin/task

# Golang
ARG GOLANG_VERSION=1.18.3
ARG GOPATH='/root/go'
RUN curl -sL https://golang.org/dl/go${GOLANG_VERSION}.linux-amd64.tar.gz -o go.tar.gz \
    && rm -rf /usr/local/go \
    && tar -C /usr/local -xzf go.tar.gz
RUN echo "export PATH=$PATH:/usr/local/go/bin" >> /root/.profile \
    && echo "export GOPATH=/root/go" >> /root/.profile
ENV PATH="/usr/local/go/bin:${PATH}"
ENV GOPATH=/root/go

# cleanup
RUN rm -f README.md LICENSE aws_cli.zip go.tar.gz packer.zip terraform.zip tflint.zip infracost.tar.gz helm.tar.gz task.tar.gz kubectl starship.sh nvm.sh \
    && rm -rf linux-amd64 completion

# workdir
WORKDIR /code

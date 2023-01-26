FROM debian:stable-20221004-slim

LABEL maintainer="rameshcreations"
# Arguments
ARG TERRAFORM_VERSION=1.3.7
ARG TERRAGRUNT_VERSION=0.38.4
ARG DRIFTCTL_VERSION=0.37.0
ARG TFSEC_VERSION=1.28.1
ARG TFLINT_VERSION=0.44.1
ARG INFRACOST_VERSION=0.10.16

RUN apt-get update && apt-get install -y unzip curl git jq \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# awscli
RUN curl -s https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip -o aws_cli.zip \
    && unzip aws_cli.zip \
    && ./aws/install

# Terraform
RUN curl -s https://releases.hashicorp.com/terraform/${TERRAFORM_VERSION}/terraform_${TERRAFORM_VERSION}_linux_amd64.zip -o terraform.zip \
    && unzip terraform.zip \
    && chmod 0755 terraform \
    && mv terraform /usr/local/bin

# Terragrunt
RUN curl -sL https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_linux_amd64 -o terragrunt \
    && chmod 0755 terragrunt \
    && mv terragrunt /usr/local/bin

# driftctl
RUN curl -sL https://github.com/snyk/driftctl/releases/download/v${DRIFTCTL_VERSION}/driftctl_linux_amd64 -o driftctl \
    && chmod 0755 driftctl \
    && mv driftctl /usr/local/bin

# tfsec
RUN curl -sL https://github.com/aquasecurity/tfsec/releases/download/v${TFSEC_VERSION}/tfsec-linux-amd64 -o tfsec \
    && chmod 0755 tfsec \
    && mv tfsec /usr/local/bin

# tflint
RUN curl -sL https://github.com/terraform-linters/tflint/releases/download/v${TFLINT_VERSION}/tflint_linux_amd64.zip -o tflint.zip \
    && unzip tflint.zip \
    && chmod 0755 tflint \
    && mv tflint /usr/local/bin

# infracost
RUN curl -sL https://github.com/infracost/infracost/releases/download/v${INFRACOST_VERSION}/infracost-linux-amd64.tar.gz -o infracost.tar.gz \
    && tar -xf infracost.tar.gz \
    && chmod 0755 infracost-linux-amd64 \
    && mv infracost-linux-amd64 /usr/local/bin/infracost


# cleanup
RUN rm -f README.md aws_cli.zip terraform.zip tflint.zip infracost.tar.gz  \
    && rm -rf linux-amd64 completion

# workdir
WORKDIR /code

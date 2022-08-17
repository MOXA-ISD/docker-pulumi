FROM public.ecr.aws/pulumi/pulumi:3.38.0

LABEL maintainer ThingsPro Cloud Team <thingspro-cloud-dev@moxa.com>

ENV PULUMI_PLUGIN_AWS_VERSION v5.10.0
ENV PULUMI_PLUGIN_EKS_VERSION v0.41.2
ENV PULUMI_PLUGIN_K8S_VERSION v3.20.5
ENV KUBECTL_VERSION v1.24.2
ARG GITHUB_TOKEN

RUN apt-get update -y && apt-get install -y --no-install-recommends \
    awscli \
    bash \
    gettext-base \
    jq && \
    rm -rf /var/lib/apt/lists/*

RUN \
    pulumi plugin install resource aws ${PULUMI_PLUGIN_AWS_VERSION} && \
    pulumi plugin install resource eks ${PULUMI_PLUGIN_EKS_VERSION} && \
    pulumi plugin install resource kubernetes v3.20.1 && \
    pulumi plugin install resource kubernetes ${PULUMI_PLUGIN_K8S_VERSION}

# Install kubectl
RUN wget -qO /usr/bin/kubectl \
    "https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" && \
    chmod u+x /usr/bin/kubectl

# Install yq
RUN wget -qO /usr/bin/yq \
    $(curl -H "Authorization: token ${GITHUB_TOKEN}" https://api.github.com/repos/mikefarah/yq/releases/latest | jq -r '.assets[] | select(.name == "yq_linux_amd64") | .browser_download_url') && \
    chmod u+x /usr/bin/yq

# Install python Jinja2 cli tool
RUN pip install j2cli

ENTRYPOINT [""]

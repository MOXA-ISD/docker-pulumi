# Docker pulumi with awscli, kubectl and jq

A docker image built on official pulumi image with awscli and kubectl installed.

- Available from Docker Hub as [thingsprocloud/pulumi](https://hub.docker.com/r/thingsprocloud/pulumi-awscli-kubectl/)

- Source [https://github.com/MOXA-ISD/docker-pulumi-awscli-kubectl](https://github.com/MOXA-ISD/docker-pulumi-awscli-kubectl)

# Installed tools

- awscli v2.7.24
- bash v5.1.4
- jq v1.6
- kubectl v1.24.2
- pulumi v3.39.1
- yq v4.26.1

## Usage

    # Get image from Docker Hub
    docker pull thingsprocloud/pulumi-awscli-kubectl

    # Get image from AWS ECR
    docker pull 233704588990.dkr.ecr.ap-northeast-1.amazonaws.com/moxa-cloud-platform-library/pulumi-awscli-kubectl

## Development

### Clone

```bash
git clone git@github.com:MOXA-ISD/docker-pulumi-awscli-kubectl.git
```

### Prepare and modify config

```bash
cp configs/example.env .env
```

You can modify configs in .env before build image

### Instruction

```bash
# build image
make build

# run and attach image for test
make run

# publish image
make publish
```

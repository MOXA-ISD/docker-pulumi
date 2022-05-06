# Docker pulumi with awscli, kubectl and jq

A docker image built on official pulumi image with awscli and kubectl installed.

- Available from dockerhub as [thingsprocloud/pulumi](https://hub.docker.com/r/thingsprocloud/pulumi-aws-kubernetes/)

- Source Code [Github](https://github.com/MOXA-ISD/docker-pulumi-aws-kubernetes)

## Usage

    docker run -it --rm thingsprocloud/pulumi bash

## Development

### Clone

```bash
git clone git@github.com:MOXA-ISD/docker-pulumi-aws-kubernetes.git
```

### Modify config

You can modify dockerhub repository in configs/dockerhub.env before build image

### Instruction

```bash
# build image
make build

# run and attach image for test
make run

# publish image
make publish
```

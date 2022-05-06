
# HELP
.PHONY: help

DOCKERHUB_CONFIG ?= configs/dockerhub.env
include $(DOCKERHUB_CONFIG)
export $(shell sed 's/=.*//' $(DOCKERHUB_CONFIG))

# alias
b: build
r: run
p: push
c: clean

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

build: ## Build image, alias: b
	@docker build -f Dockerfile . -t $(ORGANIZATION)/$(REPOSITORY):latest
	@docker tag $(ORGANIZATION)/$(REPOSITORY):latest $(ORGANIZATION)/$(REPOSITORY):$(TAG)

run: ## Run image, alias r
	@docker run -it $(ORGANIZATION)/$(REPOSITORY):latest bash

push: ## Push image, alias: p
	@docker push $(ORGANIZATION)/$(REPOSITORY):latest
	@docker push $(ORGANIZATION)/$(REPOSITORY):$(TAG)

clean: ## Delete local image, alias: c
	@docker rmi $(ORGANIZATION)/$(REPOSITORY):latest
	@docker rmi $(ORGANIZATION)/$(REPOSITORY):$(TAG)

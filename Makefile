.PHONY: help
.DEFAULT_GOAL := help

DOT_ENV ?= .env
ifneq ("$(wildcard $(DOT_ENV))","")
	include $(DOT_ENV)
	export $(shell sed 's/=.*//' $(DOT_ENV))
endif

# alias
b: build
r: run
p: push
c: clean

help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


build: ## Build image, alias: b
	@docker build --build-arg GITHUB_TOKEN=$(GITHUB_TOKEN) -f Dockerfile . -t $(ORGANIZATION)/$(REPOSITORY):latest
	@docker tag $(ORGANIZATION)/$(REPOSITORY):latest $(ORGANIZATION)/$(REPOSITORY):$(TAG)

run: ## Run image, alias r
	@docker run -it $(ORGANIZATION)/$(REPOSITORY):latest bash

push: push-docker-repo push-priv-repo ## Push image, alias: p

clean: ## Delete local image, alias: c
	@docker rmi $(ORGANIZATION)/$(REPOSITORY):latest
	@docker rmi $(ORGANIZATION)/$(REPOSITORY):$(TAG)

push-docker-repo:
	@docker push $(ORGANIZATION)/$(REPOSITORY):latest
	@docker push $(ORGANIZATION)/$(REPOSITORY):$(TAG)

push-priv-repo:
	@docker tag $(ORGANIZATION)/$(REPOSITORY):latest $(AWS_ECR_HOST)/$(AWS_ECR_ORGANIZATION)/$(REPOSITORY):$(TAG)
	@docker push $(AWS_ECR_HOST)/$(AWS_ECR_ORGANIZATION)/$(REPOSITORY):$(TAG)

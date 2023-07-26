# grep the version from the mix file
IMAGE_NAME="vicuna-docker"
VERSION=$(shell docker image inspect $(IMAGE_NAME) --format "{{.ID}}")
PORT=5000
MOUNT="$(PWD)/models:/code/models"
CONTAINERS=$(shell docker ps -a --filter "ancestor=$(IMAGE_NAME)" --format "{{.ID}}")

# HELP
# This will output the help for each task
# thanks to https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
.PHONY: usage

help: usage version

usage: ## show usage.
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)


.DEFAULT_GOAL := help

# DOCKER TASKS
# Build the container
build: ## Build the container
	docker build -t $(IMAGE_NAME) .

build-nc: ## Build the container without caching
	docker build --no-cache -t $(IMAGE_NAME) .

run: ## Run container on port 
	docker run -i -t --rm -p=$(PORT):$(PORT) --name="$(IMAGE_NAME)" $(IMAGE_NAME)

run-cli: ## Run container on port 
	docker run -i -t --rm -p=$(PORT):$(PORT) -v=$(MOUNT) --name="$(IMAGE_NAME)" $(IMAGE_NAME) /bin/bash

up: build run ## Run container on port configured (Alias to run)

stop: ## Stop and remove a running container
	$(if $(strip $(CONTAINERS)), \
		docker stop $(CONTAINERS); docker rm $(CONTAINERS), \
		@echo no running containers found \
	)

release: build-nc publish ## Make a release by building and publishing the `{version}` ans `latest` tagged containers to ECR

# HELPERS

version: ## Output the current version
	@echo running from $(PWD)
	@echo version: $(VERSION)
	$(if $(strip $(CONTAINERS)), \
		@echo running containers $(CONTAINERS), \
		@echo no running containers found \
	) 
	
	

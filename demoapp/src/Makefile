VERSION=`git rev-parse HEAD`
BUILD=`date +%FT%T%z`
LDFLAGS=-ldflags "-X main.Version=${VERSION} -X main.Build=${BUILD}"

.PHONY: help
help: ## - Show help message
	@printf "\033[32m\xE2\x9c\x93 usage: make [target]\n\n\033[0m"
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

.PHONY: build
build:	
	@printf "\033[32m\xE2\x9c\x93 Build the smallest and secured golang docker image based on scratch\n\033[0m"
	@export DOCKER_CONTENT_TRUST=1 && docker build -f Dockerfile -t demoapp .

.PHONY: build-no-cache
build-no-cache:	
	@printf "\033[32m\xE2\x9c\x93 Build the smallest and secured golang docker image based on scratch\n\033[0m"
	@export DOCKER_CONTENT_TRUST=1 && docker build --no-cache -f Dockerfile -t demoapp .

.PHONY: run
run:	
	@printf "\033[32m\xE2\x9c\x93 Run the docker image based on scratch\n\033[0m"
	@docker run demoapp:latest

.PHONY: push-to-gcp
push-to-gcp:	
	@gcloud auth application-default login
	@gcloud auth configure-docker
	@docker push gcr.io/<PROJECTID>/demoapp:$(VERSION)
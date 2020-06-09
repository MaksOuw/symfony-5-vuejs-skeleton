USER_ID=$(shell id -u)
GROUP_ID=$(shell id -g)
HOST_SOURCE_PATH=$(shell pwd)

export USER_ID
export GROUP_ID

# Spread cli arguments
#ifneq (,$(filter $(firstword $(MAKECMDGOALS)),exec))
#    CLI_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
#    $(eval $(CLI_ARGS):;@:)
#endif

include makefiles/executables.mk
include makefiles/composer.mk
include makefiles/npm.mk
include makefiles/phpunit.mk

docker-compose = docker-compose -f docker/docker-compose.yml $1

.DEFAULT_GOAL := help

init: .env build

.env:
	cp .env.example .env

build:
	$(call docker-compose, build)

up: webpack-build
	$(call docker-compose, up -d)

down:
	$(call docker-compose, down --volumes)

reup: down up

HELP_TARGET_COLUMN_WIDTH=30
help:
	@echo "========================================"
	@echo "isaac-gamebreak-tracker"
	@echo "========================================"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-$(HELP_TARGET_COLUMN_WIDTH)s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST) | sort
	@echo "========================================"


.PHONY: init .env up down reup build help

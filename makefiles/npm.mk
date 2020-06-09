npm = $(DOCKER_RUN) --rm \
		-v ${HOST_SOURCE_PATH}/app:/var/www/app \
		-v ${HOME}/.npm:/.npm \
		-v ${HOME}/.config:/.config \
		-v ${HOME}/.gitconfig:/.gitconfig \
		-w /var/www/app \
		-u ${USER_ID}:${GROUP_ID} \
		node:12 \
		${2} \
		npm ${1}

ifneq (,$(filter npm-install npm-update, $(firstword $(MAKECMDGOALS))))
    NPM_CLI_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
    $(eval $(NPM_CLI_ARGS):;@:)
endif

npm-cache-dir:
	mkdir -p ~/.npm

npm-install: npm-cache-dir
	$(call npm, install $(NPM_CLI_ARGS))

npm-update: npm-cache-dir
	$(call npm, update $(NPM_CLI_ARGS))

npm-clean-cache: npm-cache-dir
	$(call npm, cache clean --force)

webpack-dev:
	$(call npm, run dev)

webpack:
	$(call npm, run build)

.PHONY: npm-cache-dir npm-install npm-update npm-clean-cache webpack

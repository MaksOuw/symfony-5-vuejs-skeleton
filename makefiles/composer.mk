#------------------------------------------------------------------------------
# Composer
#------------------------------------------------------------------------------

COMPOSER_VERSION?=latest

composer = ${DOCKER_RUN} --rm \
                -v ${HOST_SOURCE_PATH}:/var/www/app \
                -v ~/.cache/composer:/tmp/composer \
                -e COMPOSER_CACHE_DIR=/tmp/composer \
                -w /var/www/app \
                -u ${USER_ID}:${GROUP_ID} \
                composer:${COMPOSER_VERSION} $1 -d /var/www/app/app $2

# Spread cli arguments
ifneq (,$(filter $(firstword $(MAKECMDGOALS)),composer))
    COMPOSER_CLI_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
    $(eval $(COMPOSER_CLI_ARGS):;@:)
endif

# Add ignore platform reqs for composer install & update
COMPOSER_ARGS=
ifeq (composer, $(firstword $(MAKECMDGOALS)))
    ifneq (,$(filter install update require require-dev,$(COMPOSER_CLI_ARGS)))
        COMPOSER_ARGS=--ignore-platform-reqs
    endif
endif

#------------------------------------------------------------------------------

composer-init:
	@mkdir -p ~/.cache/composer

composer: composer-init ## Run composer
	$(call composer, $(COMPOSER_CLI_ARGS), $(COMPOSER_ARGS))

composer-install: composer-init
	@$(call composer, install, --ignore-platform-reqs)

composer-update: composer-init
	@$(call composer, update, --ignore-platform-reqs)

composer-dumpautoload: composer-init
	@$(call composer, dumpautoload)

#------------------------------------------------------------------------------

clean-composer:
	-rm -rf vendor

#------------------------------------------------------------------------------

.PHONY: composer-init composer composer-install composer-update composer-dumpautoload clean-composer

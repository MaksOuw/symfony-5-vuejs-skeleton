CONTAINER_SOURCE_PATH=/var/www/app

phpunit = $(DOCKER_RUN) --rm --name phpunit \
			-v ${HOST_SOURCE_PATH}:${CONTAINER_SOURCE_PATH} \
			-w ${CONTAINER_SOURCE_PATH} \
			-u ${USER_ID}:${GROUP_ID} \
			app/bin/phpunit ${1}

phpunit:
	@$(call phpunit, )

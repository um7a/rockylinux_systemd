IMAGE_NAME := local/rockylinux_systemd
TAG := 8.8
CONTAINER_NAME := $(shell echo test_run_${IMAGE_NAME}_${TAG} | sed -e s/\\//_/g)

ContainerExists = "$(shell docker ps | grep ${CONTAINER_NAME})"

.PHONY: help
help:
	@echo ""
	@echo "  TARGETS"
	@echo "    build ... Build docker image ${IMAGE_NAME}"
	@echo "    clean ... Clean docker image ${IMAGE_NAME}"
	@echo "    run   ... Run docker container using image ${IMAGE_NAME}"
	@echo "    stop  ... Stop docker container which was created by run target"
	@echo ""

.PHONY: build
build: Dockerfile
	docker build --rm -t ${IMAGE_NAME}:${TAG} .

.PHONY: clean
clean: stop
	docker rmi ${IMAGE_NAME}:${TAG}

.PHONY: run
run: stop
  # Create container
	docker run \
	-itd \
	--rm \
	--privileged \
	--volume /sys/fs/cgroup:/sys/fs/cgroup:ro \
	--name ${CONTAINER_NAME} \
  ${IMAGE_NAME}:${TAG}

  # Execute bash
	docker exec \
	-it \
  ${CONTAINER_NAME} \
	/bin/bash

.PHONY: stop
stop:
ifneq (${ContainerExists}, "")
		@echo "!!! Container exists. Delete. !!!"
		docker stop \
	  ${CONTAINER_NAME}
else
		@echo "Container does not exist."
endif

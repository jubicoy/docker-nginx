SHELL := /bin/bash

ifeq ($(TARGET),light)
	FLAVOR := light
else ifeq ($(TARGET),full)
	FLAVOR := full
else ifeq ($(TARGET),extras)
	FLAVOR := extras
endif

IMAGE_NAME := jubicoy/nginx

container:
	$(info $(TARGET) $(FLAVOR))
ifndef FLAVOR
	$(error TARGET not set or invalid)
endif
	pushd $(FLAVOR) \
		&& docker build -t $(IMAGE_NAME):$(FLAVOR) . \
		&& popd

push:
	docker push $(IMAGE_NAME):$(FLAVOR)

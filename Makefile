SHELL := /bin/bash

ifeq ($(TARGET),jessie)
	FLAVOR := jessie
endif

IMAGE_NAME := jubicoy/nginx

image:
	$(info $(TARGET) $(FLAVOR))
ifndef FLAVOR
	$(error TARGET not set or invalid)
endif
	pushd $(FLAVOR) \
		&& docker build -t $(IMAGE_NAME):$(FLAVOR) . \
		&& popd

push:
ifndef FLAVOR
	$(error TARGET not set or invalid)
endif
	docker push $(IMAGE_NAME):$(FLAVOR)

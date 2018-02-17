SHELL := /bin/bash

ifeq ($(TARGET),jessie)
	FLAVOR := jessie
else ifeq ($(TARGET),xenial)
	FLAVOR := xenial
endif

ifdef TAG
	TAG_SUFFIX := -$(TAG)
endif

IMAGE_NAME := jubicoy/nginx

image:
	$(info $(TARGET) $(FLAVOR))
ifndef FLAVOR
	$(error TARGET not set or invalid)
endif
	docker build -t $(IMAGE_NAME):$(FLAVOR)$(TAG_SUFFIX) -f $(FLAVOR)/Dockerfile . \

push:
ifndef FLAVOR
	$(error TARGET not set or invalid)
endif
	docker push $(IMAGE_NAME):$(FLAVOR)$(TAG_SUFFIX)

SHELL := /bin/bash

all: container

container:
	docker build -t jubicoy/nginx .

push:
	docker push jubicoy/nginx

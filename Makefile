
IMAGE_NAME=badugisoft/console.io
IMAGE_VERSION=0.2.7
NODE_VERSION=8.1.3-alpine

CONTAINER_NAME=consoleio
HOST_PORT=8082
CONTAINER_PORT=8082

all:

build:
	@docker build \
		-t $(IMAGE_NAME):$(IMAGE_VERSION) \
		-t $(IMAGE_NAME):latest \
		--build-arg CONSOLEIO_VERSION=$(IMAGE_VERSION) \
		--build-arg NODE_VERSION=$(NODE_VERSION) \
		.

stop:
	@docker stop $(CONTAINER_NAME)

remove:
	@docker stop $(CONTAINER_NAME) || true
	@docker rm $(CONTAINER_NAME)

run:
	@docker stop $(CONTAINER_NAME) || true
	@docker rm $(CONTAINER_NAME) || true
	@docker run -d --name $(CONTAINER_NAME) \
		-p $(HOST_PORT):$(CONTAINER_PORT) \
		$(IMAGE_NAME):$(IMAGE_VERSION)

push:
	@docker push $(IMAGE_NAME):$(IMAGE_VERSION)
	@docker push $(IMAGE_NAME):latest

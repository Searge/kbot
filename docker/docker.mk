DOCKER_BUILDX_PLATFORMS ?= linux/amd64,linux/arm64,darwin/amd64,darwin/arm64,windows/amd64
DOCKERFILE_TEMPLATE := docker/Dockerfile.template
DOCKERFILE := docker/Dockerfile

# Build the Docker image
docker-build:
	for platform in $(DOCKER_BUILDX_PLATFORMS); do \
		IFS="/" read -r -a parts <<< "$$platform"; \
		TARGET_OS=$${parts[0]}; \
		TARGET_ARCH=$${parts[1]}; \
		sed -e "s/\$${TARGET_OS}/$$TARGET_OS/g" -e "s/\$${TARGET_ARCH}/$$TARGET_ARCH/g" \
			$(DOCKERFILE_TEMPLATE) > $(DOCKERFILE); \
		docker buildx build \
			--platform $$platform \
			--build-arg TARGET_OS=$$TARGET_OS \
			--build-arg TARGET_ARCH=$$TARGET_ARCH \
			--tag $(APP):$(VERSION)-$$TARGET_OS-$$TARGET_ARCH \
			--push \
			-f $(DOCKERFILE) .; \
	done

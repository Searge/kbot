# Build directory
BUILD_DIR=build
# Registry to push the image to
REGISTRY=ghcr.io/searge
# Versioning
FLAG=github.com/Searge/kbot/cmd.appVersion
APP=$(shell basename $(shell git remote get-url origin) | sed 's/\.git//')
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)

# Build variables
CGO_ENABLED ?=0 # For windows builds change 0 to 1
TARGET_OS ?=linux
TARGET_ARCH ?=amd64

TARGET_OS_LIST := linux darwin windows
TARGET_ARCH_LIST := amd64 arm64

# Format the code
format:
	gofmt -w -s ./cmd

# Lint the code
lint:
	golint ./cmd

# Run tests
test:
	go test -v ./cmd

# Install dependencies
install:
	go get

# Build the binary
build: format
	CGO_ENABLED=$(CGO_ENABLED) GOOS=$(TARGET_OS) GOARCH=$(TARGET_ARCH) \
		go build -ldflags "-X=$(FLAG)=$(VERSION)" \
		-o ./$(APP) -v

# Build the docker image with the binary
docker-build:
	docker build . -t ${REGISTRY}/${APP}:${VERSION}-${TARGET_OS}-${TARGET_ARCH} \
		--build-arg TARGET_OS=${TARGET_OS} \
		--build-arg TARGET_ARCH=${TARGET_ARCH} \
		--build-arg CGO_ENABLED=${CGO_ENABLED}

# Push the docker image
docker-push:
	docker push ${REGISTRY}/${APP}:${VERSION}-${TARGET_OS}-${TARGET_ARCH}

# Clean the binary and docker image
clean:
	rm -f kbot
	docker rmi -f ${REGISTRY}/${APP}:${VERSION}-${TARGET_ARCH}

# Build the binary and docker image
all: install build docker-build

image: docker-build

linux: all

macos:
	make all CGO_ENABLED=0 GOOS=darwin GOARCH=arm64

windows:
	make all CGO_ENABLED=1 GOOS=windows GOARCH=amd64

# Builds the project for all target OSes and architectures
build-all:
	@for os in $(TARGET_OS_LIST); do \
		for arch in $(TARGET_ARCH_LIST); do \
			if [ "$$os" = "windows" ]; then \
				make build TARGET_OS=$$os TARGET_ARCH=$$arch CGO_ENABLED=1; \
			else \
				make build TARGET_OS=$$os TARGET_ARCH=$$arch; \
			fi; \
   			mkdir -p $(BUILD_DIR)/$${os}_$${arch} && mv kbot $(BUILD_DIR)/$${os}_$${arch}/; \
		done \
	done

# Creates images for all target OSes and architectures
docker-build-all:
	@for os in $(TARGET_OS_LIST); do \
		for arch in $(TARGET_ARCH_LIST); do \
			if [ "$$os" = "windows" ]; then \
				make docker-build TARGET_OS=$$os TARGET_ARCH=$$arch CGO_ENABLED=1; \
			else \
				make docker-build TARGET_OS=$$os TARGET_ARCH=$$arch; \
			fi; \
		done \
	done

docker-push-all:
	for TARGET_OS in $(TARGET_OS_LIST); do \
		for TARGET_ARCH in $(TARGET_ARCH_LIST); do \
			docker push ${REGISTRY}/${APP}:${VERSION}-$$TARGET_OS-$$TARGET_ARCH; \
		done \
	done

clean-all:
	rm -rf $(BUILD_DIR)
	for TARGET_OS in $(TARGET_OS_LIST); do \
		for TARGET_ARCH in $(TARGET_ARCH_LIST); do \
			docker rmi -f ${REGISTRY}/${APP}:${VERSION}-$$TARGET_OS-$$TARGET_ARCH; \
		done \
	done

# Make everything:
everything: install build-all docker-build-all docker-push-all

# Make tag:
make tag:
	bash scripts/bump

# List all targets
# (c) https://stackoverflow.com/a/26339924
list:
	@LC_ALL=C $(MAKE) -pRrq -f $(firstword $(MAKEFILE_LIST)) : 2>/dev/null |
	awk -v RS= -F: '/(^|\n)# Files(\n|$$)/,/(^|\n)# Finished Make data base/ {if ($$1 !~ "^[#.]") {print $$1}}' | sort | egrep -v -e '^[^[:alnum:]]' -e '^$@$$'

.PHONY: format lint test install build clean docker-build docker-push docker-build-all clean-all docker-push-all list all everything

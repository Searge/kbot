# Variables
APP=$(shell basename $(shell git remote get-url origin) | sed 's/\.git//')
VERSION=$(shell git describe --tags --abbrev=0)-$(shell git rev-parse --short HEAD)
REGISTRY=searge
TARGET_OS=linux
TARGET_ARCH=amd64

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
	CGO_ENABLED=0 GOOS=$(TARGET_OS) GOARCH=$(TARGET_ARCH) \
		go build -ldflags "-X=github.com/Searge/kbot/cmd.appVersion=$(VERSION)" \
		-o ./$(APP) -v

# Clean the binary
clean:
	rm -f bin/*

# Build the docker image
image:
	docker build . -t $(REGISTRY)/$(APP):$(VERSION)-$(TARGET_ARCH)

# Push the docker image
push:
	docker push $(REGISTRY)/$(APP):$(VERSION)-$(TARGET_ARCH)


.PHONY: format lint test install build clean image push

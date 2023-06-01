# KBot Telegram Bot

KBot Telegram Bot is a functional Telegram bot with a root command and settings. It is written in Golang and utilizes the github.com/spf13/cobra and gopkg.in/telebot.v3 frameworks.

[![golangci-lint](https://github.com/Searge/kbot/actions/workflows/golangci-lint.yml/badge.svg)](https://github.com/Searge/kbot/actions/workflows/golangci-lint.yml)

## Installation

To install and run the KBot Telegram Bot, follow the instructions below:

1. Install Golang and set up your development environment. (Codespaces already includes all necessary settings.)
2. Clone the repository to your local machine.
   1. `gh repo clone Searge/kbot kbot && cd $_`
3. Install the dependencies.
   1. `go install github.com/spf13/cobra-cli@latest`
   2. `go get`
4. Build the binary:
   1. `VERSION='<semver>' # e.g. v0.0.1`
   2. `go build -ldflags "-X=github.com/Searge/kbot/cmd.appVersion=${VERSION}" -o kbot`
5. Setup your Telegram Bot and get API Token. Then set the environment variable.
   1. `read -s TELE_TOKEN # Enter your API Token`
   2. `export TELE_TOKEN`
6. Run the binary.
   1. `./kbot start`
   2. Talk to your bot via Telegram.

## Usage

To use the KBot Telegram Bot, follow these steps:

1. Add the bot to your Telegram account: [@k8s_course_bot](https://t.me/k8s_course_bot)
2. Send a `/start` message to the bot to start interacting with it.

## Use the available commands to interact with the bot

Available Commands

- `/start` - Start the bot and display a welcome message.
  - `/start <message>` - Echo the provided message back to the user, if understand.
  - `/start hello` - Display a "Hello World" message.
  - `/start ping` - Display a "pong" message to indicate that the bot is online.

## Make docker image

Before you start, please make sure that you have created GitHub Personal Access Token with `read:packages` scope.

To do this:

1. Go to the [GitHub Personal Access Token](https://github.com/settings/tokens) page.
2. Click the `Generate new token (classic)` button.
3. Grant the `read:packages` scope.

[About Container registry](https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry#about-the-container-registry).

Then login to GitHub Packages Docker Registry:

```bash
❯ docker login ghcr.io
Username: searge
Password:
```

Then build and push docker image.

<!-- markdownlint-disable MD033 -->
<mark>:warning: Default platform is linux/amd64</mark>
<!-- markdownlint-enable MD033 -->

For install golang dependencies and build binary use:

```bash
make install && make build
```

Then build and push docker image:

```bash
make docker-build && make docker-push
```

### Custom platform

For build docker image for custom platform and push use:

```bash
# Example for windows/amd64
make all CGO_ENABLED=1 TARGET_OS=windows TARGET_ARCH=amd64 &&
  make docker-build CGO_ENABLED=1 TARGET_OS=windows TARGET_ARCH=amd64 &&
  make docker-push CGO_ENABLED=1 TARGET_OS=windows TARGET_ARCH=amd64
```

OR use `make platform`:

```bash
make linux
make windows
make macos
```

For build everything use:

```bash
make everything
```

## Credits

The KBot Telegram Bot was developed by @Searge for educational purposes in learning Golang and the Telegram Bot API.

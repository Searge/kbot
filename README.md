# KBot Telegram Bot

KBot Telegram Bot is a functional Telegram bot with a root command and settings. It is written in Golang and utilizes the github.com/spf13/cobra and gopkg.in/telebot.v3 frameworks.

[![golangci-lint](https://github.com/Searge/kbot/actions/workflows/golangci-lint.yml/badge.svg)](https://github.com/Searge/kbot/actions/workflows/golangci-lint.yml)

## [Documentation](docs/readme.md#documentation)

- [Local Development](docs/local-development.md#local-development)
  - [Installation](docs/local-development.md#installation)
  - [Make docker image](docs/local-development.md#make-docker-image)
  - [Run docker image](docs/local-development.md#run-docker-image)
  - [Custom platform](docs/local-development.md#custom-platform)
- [Deployment](docs/deployment.md#deployment)

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

## Credits

The KBot Telegram Bot was developed by @Searge for educational purposes in learning Golang and the Telegram Bot API.

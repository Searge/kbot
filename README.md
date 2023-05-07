# KBot Telegram Bot

KBot Telegram Bot is a functional Telegram bot with a root command and settings. It is written in Golang and utilizes the github.com/spf13/cobra and gopkg.in/telebot.v3 frameworks.

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

## Credits

The KBot Telegram Bot was developed by @Searge for educational purposes in learning Golang and the Telegram Bot API.

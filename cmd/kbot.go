/*
Copyright © 2023 @Searge
*/
package cmd

import (
	"fmt"
	"log"
	"os"
	"time"

	"github.com/spf13/cobra"
	telebot "gopkg.in/telebot.v3"
)

var (
	// TeleToken bot
	TeleToken string = os.Getenv("TELE_TOKEN")
)

// kbotCmd represents the kbot command
var kbotCmd = &cobra.Command{
	Use:     "kbot",
	Aliases: []string{"start"},
	Short:   "KBot is a bot for Telegram",
	Long: `KBot is a fully functional bot for Telegram.

Created for fun and learning purposes. The main goal is to learn Go and Telegram Bot API.
It's a work in progress, so expect some bugs and missing features.`,
	Run: func(cmd *cobra.Command, args []string) {
		fmt.Printf("kbot %s started\n", appVersion)
		kbot, err := telebot.NewBot(telebot.Settings{
			URL:    "",
			Token:  TeleToken,
			Poller: &telebot.LongPoller{Timeout: 10 * time.Second},
		})

		if err != nil {
			log.Fatalf("Please check your TELE_TOKEN env variable, %s", err)
		}

		kbot.Handle(telebot.OnText, func(m telebot.Context) error {
			log.Printf(m.Message().Payload, m.Text())
			payload := m.Message().Payload

			switch payload {
			case "hello":
				err = m.Send((fmt.Sprintf("Hello! I'm kbot %s", appVersion)))
			case "help":
				err = m.Send((fmt.Sprintf("I'm kbot %s, I can't help you yet", appVersion)))
			case "ping":
				err = m.Send(("pong"))
			default:
				err = m.Send(("Sorry, I don't understand"))

			}

			return err
		})
		kbot.Start()
	},
}



func init() {
	rootCmd.AddCommand(kbotCmd)

	// Here you will define your flags and configuration settings.

	// Cobra supports Persistent Flags which will work for this command
	// and all subcommands, e.g.:
	// kbotCmd.PersistentFlags().String("foo", "", "A help for foo")

	// Cobra supports local flags which will only run when this command
	// is called directly, e.g.:
	// kbotCmd.Flags().BoolP("toggle", "t", false, "Help message for toggle")
}

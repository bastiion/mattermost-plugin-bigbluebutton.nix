package cmd

import (
  "fmt"
  "log"
  "github.com/nokx5/golden-go/golden"
)

import "rsc.io/quote"

func Execute() {
    fmt.Println("Welcome to nokx golden go project!")
    fmt.Println(quote.Go())

    // Set properties of the predefined Logger, including
    // the log entry prefix and a flag to disable printing
    // the time, source file, and line number.
    log.SetPrefix("greetings: ")
    log.SetFlags(0)

    // Request a greeting message.
    message, err := golden.Hello("Guest")
    // If an error was returned, print it to the console and
    // exit the program.
    if err != nil {
        log.Fatal(err)
    }
    fmt.Println(message)
    
}

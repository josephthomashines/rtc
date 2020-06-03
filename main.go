package main

import (
	"flag"
	"fmt"
)

var demoMap = map[string]interface{}{
	"primitive": DemoPrimitive,
	"canvas":    DemoCanvas,
}

func main() {
	fmt.Println("Ray Tracer Challenge")

	demo := flag.String("demo", "", "Pick a demo to run")

	flag.Parse()

	if *demo != "" {
		if f, ok := demoMap[*demo]; ok {
			f.(func())()
			return
		}
	}

	fmt.Println("Nothing to do...")
}

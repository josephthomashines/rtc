package main

import (
	"flag"
	"fmt"
	"log"
	"os"
	"runtime"
	"runtime/pprof"
)

var demoMap = map[string]interface{}{
	"primitive": DemoPrimitive,
	"canvas":    DemoCanvas,
	"transform": DemoTransform,
}

func app() {
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

func main() {
	prof := false
	if prof {
		f, err := os.Create("cpu.prof")
		if err != nil {
			log.Fatal("could not create CPU profile: ", err)
		}
		defer f.Close()
		if err := pprof.StartCPUProfile(f); err != nil {
			log.Fatal("could not start CPU profile: ", err)
		}
		defer pprof.StopCPUProfile()
	}

	app()

	if prof {
		f, err := os.Create("mem.prof")
		if err != nil {
			log.Fatal("could not create memory profile: ", err)
		}
		defer f.Close()
		runtime.GC() // get up-to-date statistics
		if err := pprof.WriteHeapProfile(f); err != nil {
			log.Fatal("could not write memory profile: ", err)
		}
	}
}

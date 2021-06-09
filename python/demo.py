#!/usr/bin/env python
import argparse

# Import function
from tuples import demo_tuples

def main():
    parser = argparse.ArgumentParser(description='Ray Tracer Challenge Demos')
    subparsers = parser.add_subparsers(help='available demos', dest="demo")

    # Add parser
    tuples_parser = subparsers.add_parser('tuples', help='demonstrate using basic tuples')

    args = parser.parse_args()

    if args.demo is None:
        parser.print_help()
        exit(1)

    # Map parser name to function
    commands = {
        'tuples': demo_tuples,
    }

    commands[args.demo](args)

if __name__ == "__main__":
    main()


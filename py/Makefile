SHELL=/bin/bash

.PHONY: all clean main test

clean:
	-@rm -rf venv __pycache__

venv: install.sh
	bash install.sh

main: venv
	-@source ./venv/bin/activate && \
		python main.py

test: venv
	-@source ./venv/bin/activate && \
		python test.py

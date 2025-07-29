.POSIX:
.SUFFIXES:

GLEAM ?= gleam

.PHONY: all
all: run

.PHONY: run
run:
	$(GLEAM) run -m lustre/dev start

.PHONY: build
build:
	$(GLEAM) run -m lustre/dev build

.PHONY: release
release:
	$(GLEAM) run -m lustre/dev build --minify

.PHONY: format
format:
	$(GLEAM) format

.PHONY: clean
clean:
	$(GLEAM) clean

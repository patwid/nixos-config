.POSIX:
.SUFFIXES:

GO ?= go
GOFLAGS ?=

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

cmds := hello

.PHONY: all
all: $(cmds)

$(cmds):
	$(GO) build $(GOFLAGS) -o $@ cmd/$@

.PHONY: fmt
fmt:
	$(GO) fmt **/*.go

.PHONY: check
check:
	$(GO) test

.PHONY: clean
clean:
	rm $(cmds)

.PHONY: install
install:
	mkdir -p $(DESTDIR)$(BINDIR)
	install -m755 $(cmds) $(DESTDIR)$(BINDIR)

.PHONY: uninstall
uninstall:
	rm $(DESTDIR)$(BINDIR)/hello

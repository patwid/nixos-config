.POSIX:
.SUFFIXES:

HARE ?= hare
HAREFLAGS ?=

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

cmds := hello

.PHONY: all
all: $(cmds)

$(cmds):
	$(HARE) build $(HAREFLAGS) -o $@ cmd/$@

.PHONY: check
check:
	$(HARE) test

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

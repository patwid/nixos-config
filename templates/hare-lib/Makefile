.POSIX:
.SUFFIXES:

HARE ?= hare
HAREFLAGS ?=

PREFIX ?= /usr/local
SRCDIR ?= $(PREFIX)/src
HARESRCDIR ?= $(SRCDIR)/hare
THIRDPARTYDIR ?= $(HARESRCDIR)/third-party

.PHONY: all
all:

.PHONY: check
check:
	$(HARE) test

.PHONY: clean
clean:

.PHONY: install
install:
	mkdir -p $(DESTDIR)$(THIRDPARTYDIR)/lib
	install -m644 lib/*.ha $(DESTDIR)$(THIRDPARTYDIR)/lib

.PHONY: uninstall
uninstall:
	rm -r $(DESTDIR)$(THIRDPARTYDIR)/lib

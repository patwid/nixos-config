.POSIX:
.SUFFIXES:

CFLAGS ?= -g -std=c11 -Wall -Wextra -Werror -pedantic -Wno-unused-parameter

PREFIX ?= /usr/local
BINDIR ?= $(PREFIX)/bin

cmds := hello

.PHONY: all
all: $(cmds)

$(cmds):
	$(CC) $(CFLAGS) $(LIBS) -o $@ cmd/$@/main.c

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

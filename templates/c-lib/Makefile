.POSIX:
.SUFFIXES:

CFLAGS ?= -g -std=c11 -Wall -Wextra -Werror -pedantic -Wno-unused-parameter

PREFIX ?= /usr/local
LIBDIR ?= $(PREFIX)/lib
INCLUDEDIR ?= $(PREFIX)/include

libs := hello.so

.PHONY: all
all: $(libs)

hello.so: lib/hello.c
	$(CC) $(CFLAGS) $(LIBS) -shared -o $@ $^

.PHONY: clean
clean:
	rm $(libs)

.PHONY: install
install:
	mkdir -p $(DESTDIR)$(LIBDIR)
	mkdir -p $(DESTDIR)$(INCLUDEDIR)
	install -m755 $(libs) $(DESTDIR)$(LIBDIR)
	install -m755 lib/*.h $(DESTDIR)$(INCLUDEDIR)

.PHONY: uninstall
uninstall:
	rm $(DESTDIR)$(LIBDIR)/hello.so
	rm $(DESTDIR)$(INCLUDEDIR)/hello.h

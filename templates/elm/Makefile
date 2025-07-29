.POSIX:
.SUFFIXES:

ELM ?= elm make
ELM_FLAGS ?=

pubdir := public
srcdir := src

srcs := $(wildcard $(srcdir)/*.elm)

tasks := $(srcs:$(srcdir)/%.elm=$(pubdir)/%.html)

.PHONY: all
all: $(tasks)

$(pubdir)/%.html: $(srcdir)/%.elm
	$(ELM) $(ELM_FLAGS) --output=$@ $<

.PHONY: clean
clean:
	rm $(tasks)

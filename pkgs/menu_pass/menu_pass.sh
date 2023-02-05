#!/bin/sh -eu

prefix=${PASSWORD_STORE_DIR:-~/.password-store}
find "$prefix" -name '*.gpg' | sed "s,^$prefix\(.*\)\.gpg$,\1," | sort

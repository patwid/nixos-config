#!/bin/sh

# Redirect output to stderr.
#exec 1>&2

# files=$(git diff --name-only HEAD HEAD~1 | grep '\.nix$')
files=$(git show --name-only --pretty='' | grep '\.nix$')
if [ -n "$files" ]; then
	nix fmt $files
	git add $files

	files=$(git diff --cached --name-only --diff-filter=ACM | grep '\.nix$')
	if [ -n "$files" ]; then
		git commit -m 'chore: autoformat' -- $files
	fi
fi

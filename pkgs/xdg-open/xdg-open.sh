#!/bin/sh -eu

case "${1%%:*}" in
	http|https)
		exec qutebrowser "$1"
		;;
	mailto)
		exec aerc "$1"
		;;
	*.pdf)
		exec zathura "$1"
		;;
	*.jpg|*.png)
		exec imv "$1"
		;;
	*.mp3|*.flac|*.mkv)
		exec mpv "$1"
		;;
	*)
		exit 1
		;;
esac

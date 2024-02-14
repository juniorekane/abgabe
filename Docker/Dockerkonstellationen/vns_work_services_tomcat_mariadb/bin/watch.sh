#!/usr/bin/env bash

printf '\e[?25l'
cleanup() {
	printf '\e[?25h'
	exit 0
}
trap cleanup SIGINT SIGHUP SIGABRT EXIT
while true; do
	result=$(curl -s http://localhost/)
	if test "$result" != "$lastresult"; then
		clear
		printf '\e[H'
		echo "$result" | bat --theme ansi --paging=never --style=auto --color always | head -n15
		echo
		echo "$result" | html2text | head -n10
		lastresult="$result"
	fi
	sleep 0.5
done

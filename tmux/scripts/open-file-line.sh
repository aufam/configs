#!/bin/sh

LINE="$1"
TARGET="$(printf "%s\n" "$LINE" | grep -Eo '[A-Za-z0-9_\./-]+:[0-9]+')"

if [ "$(uname)" = "Darwin" ]; then
	tmux="/opt/homebrew/bin/tmux"
else
	tmux="tmux"
fi

if [ -n "$TARGET" ]; then
	file=${TARGET%%:*}
	line=${TARGET#*:}
	"$tmux" send -X cancel
	"$tmux" send-keys "fg" Enter ":e $file | $line" Enter # assuming vim or nvim is on the foreground
else
	echo "line '$LINE' does not containe file:line pattern"
	exit 1
fi

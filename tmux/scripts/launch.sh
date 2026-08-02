#!/bin/sh

if [ "$(uname)" = "Darwin" ]; then
	tmux="/opt/homebrew/bin/tmux"
else
	tmux="tmux"
fi

cd || exit 1

session=$("$tmux" list-sessions 2>/dev/null | grep -v "(attached)" | head -n 1 | cut -d: -f1)
if [ -n "$session" ]; then
	exec "$tmux" attach -t "$session"
else
	exec "$tmux"
fi

#!/bin/sh

if [ "$(uname)" = "Darwin" ]; then
	tmux="/opt/homebrew/bin/tmux"
else
	tmux="tmux"
fi

wid=$("$tmux" display-message -p '#{window_id}')
"$tmux" swap-window -t "$1"
"$tmux" select-window -t "$wid"

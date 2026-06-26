#!/bin/bash
set -e

VENV="$HOME/.venv"
PYTHON="${PYTHON:-python3}"

PACKAGES=(
	httpie
	debugpy
	pyright
	black
	tombi
	visidata
)

if [ ! -x "$VENV/bin/python" ]; then
	echo "Creating virtual environment at $VENV"
	"$PYTHON" -m venv "$VENV"
	"$VENV/bin/python" -m ensurepip --upgrade
fi

"$VENV/bin/python" -m pip install --upgrade pip
"$VENV/bin/pip" install "${PACKAGES[@]}"

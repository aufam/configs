#!/usr/bin/env python3

import subprocess
import sys
import platform

if platform.system() == "Darwin":
    TMUX = "/opt/homebrew/bin/tmux"
else:
    TMUX = "tmux"


def get_sessions() -> list[tuple[str, bool]]:
    try:
        output: str = subprocess.check_output([TMUX, "list-sessions"], text=True)
        return [
            (line.split(":")[0], "(attached)" in line)
            for line in output.strip().splitlines()
        ]

    except subprocess.CalledProcessError:
        return []


def switch_next(sessions: list[tuple[str, bool]]):
    switch_relative(sessions, direction=1)


def switch_prev(sessions: list[tuple[str, bool]]):
    switch_relative(sessions, direction=-1)


def switch_relative(sessions: list[tuple[str, bool]], direction: int):
    if not sessions:
        return

    current_idx = next(
        (i for i, (_, attached) in enumerate(sessions) if attached), None
    )

    if current_idx is None:
        return

    target_idx = (current_idx + direction) % len(sessions)
    target_session = sessions[target_idx][0]

    subprocess.run([TMUX, "switch-client", "-t", target_session])


def main():
    arg: str = sys.argv[1]
    sessions = get_sessions()
    if arg == "next":
        switch_next(sessions)
    elif arg == "prev":
        switch_prev(sessions)


if __name__ == "__main__":
    main()

#!/usr/bin/env python3
# TODO test and commit

import shutil
from pathlib import Path

# 👉 Update this list to change the sort order
WINDOW_ORDER = [
    "dash",
    "gtd",
    "int",
    "projmang",
    "smalls",
    "amd",
    "obs",
    "stabref",
    "genai",
    "ads-learn",
    "ml-learn",
    "kaizen",
    "adsboot",
]

def main():
    # File paths
    tmux_file = Path.home() / ".tmux" / "resurrect" / "last"
    backup_file = tmux_file.with_suffix(".bak")

    # Backup first
    shutil.copy2(tmux_file, backup_file)
    print(f"Backup created at {backup_file}")

    # Read lines
    with tmux_file.open("r") as f:
        lines = [line.rstrip("\n") for line in f]

    # Split window and other lines
    window_lines = []
    other_lines = []

    for line in lines:
        if line.startswith("window"):
            window_lines.append(line)
        else:
            other_lines.append(line)

    # Helper to extract window name (2nd column)
    def get_window_name(line):
        return line.split("\t")[1]

    # Build mapping for sort order
    order_map = {name: idx for idx, name in enumerate(WINDOW_ORDER)}

    # Sort window lines by custom order (fallback = inf for unknowns)
    window_lines.sort(key=lambda l: order_map.get(get_window_name(l), float("inf")))

    # Recombine lines (sorted windows first, then all others)
    sorted_lines = window_lines + other_lines

    # Write back to file
    with tmux_file.open("w") as f:
        for line in sorted_lines:
            f.write(line + "\n")

    print(f"Sorted window lines written back to {tmux_file}")


if __name__ == "__main__":
    main()


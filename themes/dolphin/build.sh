#!/usr/bin/env bash

# This script generates dolphin.theme.bash from dolphin.theme.src.bash 
# by replacing color variables with their actual ANSI escape codes.

set -euo pipefail

# Colors definitions
declare -A COLORS
COLORS[YELLOW]="\[\033[22;38;5;227m\]"
COLORS[ORANGE]="\[\033[22;38;5;208m\]"
COLORS[ORANGE_B]="\[\033[48;5;208m\]"
COLORS[BLACK]="\[\033[38;5;0m\]"
COLORS[BLUE]="\[\033[22;38;5;87m\]"
COLORS[BLUE_B]="\[\033[48;5;87m\]"
COLORS[GRAY]="\[\033[38;5;246m\]"
COLORS[GREEN]="\[\033[22;38;5;16m\]"
COLORS[RED]="\[\033[1;31m\]"
COLORS[WHITE]="\[\033[1;37m\]"
COLORS[RESET]="\[\033[m\]"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC_FILE="${SCRIPT_DIR}/dolphin.theme.src.bash"
OUT_FILE="${SCRIPT_DIR}/dolphin.theme.bash"

if [[ ! -f "$SRC_FILE" ]]; then
	echo "Source file not found: $SRC_FILE" >&2
	exit 1
fi

{
	while IFS= read -r line || [[ -n "$line" ]]; do
		for key in "${!COLORS[@]}"; do
			line="${line//\$\{$key\}/${COLORS[$key]}}"
		done
		printf '%s\n' "$line"
	done < "$SRC_FILE"
} > "$OUT_FILE"

echo "Generated: $OUT_FILE"



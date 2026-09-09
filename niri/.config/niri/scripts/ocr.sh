#!/usr/bin/env bash

set -euo pipefail

content="$(
  grim -g "$(slurp)" - |
    tesseract - stdout \
      -l eng \
      --oem 1 \
      --psm 6 \
      -c tessedit_char_blacklist="¦" 2>/dev/null
)"

# Exit if cancelled or OCR produced nothing
[ -z "$content" ] && exit 0

printf '%s' "$content" | wl-copy

preview=$(printf '%s' "$content" | head -c 200)

notify-send \
  -a OCR \
  "OCR Copied to Clipboard" \
  "$preview"

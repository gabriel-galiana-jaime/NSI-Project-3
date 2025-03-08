#!/bin/sh
echo -ne '\033c\033]0;NSI-1A-Zelda-NES\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/NSI-1A-Zelda-NES.x86_64" "$@"

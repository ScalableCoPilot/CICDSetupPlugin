#!/usr/bin/env bash
set -euo pipefail

if [[ $# -eq 0 || -z "$1" ]]; then
  printf '%s\n' 'Usage: bash run-tests.sh <executable> [arguments...]' >&2
  exit 2
fi

if ! command -v -- "$1" >/dev/null 2>&1; then
  printf '%s\n' 'Test executable was not found. Install project prerequisites separately.' >&2
  exit 127
fi

exec -- "$@"
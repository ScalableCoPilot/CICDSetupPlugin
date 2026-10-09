#!/usr/bin/env bash
set -euo pipefail

script_directory="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
plugin_root="${PLUGIN_ROOT:-$(dirname -- "$script_directory")}"

for relative_path in plugin.json skills/test-runner/SKILL.md skills/test-runner/run-tests.sh skills/test-runner/run-tests.ps1; do
  if [[ ! -r "$plugin_root/$relative_path" ]]; then
    printf '%s\n' 'Testing plugin is missing a required bundled file. Reinstall or repair the plugin.' >&2
    exit 1
  fi
done

printf '%s\n' '{"additionalContext":"Testing plugin: use the consuming repository test command. No tests have been run by this hook.","systemMessage":"Testing plugin assets checked; no tests were run."}'
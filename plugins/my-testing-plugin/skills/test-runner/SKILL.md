---
name: test-runner
description: "Use when executing project-native tests, reproducing test failures, or collecting regression evidence with explicit commands on Windows, Linux, or macOS."
---

# Focused test execution

This skill runs tests in the consuming workspace. It does not provide a test framework or assume that the plugin directory is the project under test.

## Procedure

1. Follow the consuming repository's instructions. Identify the test command from its documentation, test configuration, or existing CI.
2. Read the relevant implementation and tests, then choose the cheapest check that can falsify the current hypothesis.
3. Check the executable, arguments, working directory, and required services. Inspect commands for destructive setup, remote access, or secret-bearing arguments. Obtain approval before any operation outside the authorized scope.
4. Set the terminal's working directory to the consuming project or the relevant package. Locate the bundled script relative to this skill file; do not assume the project has a copy of the plugin.
5. Run one executable with separate arguments using the appropriate script below. Neither wrapper accepts a shell command string. For pipelines, shell built-ins, or complex quoting, use the repository's existing trusted script directly after reviewing it.
6. Preserve output and exit status. Do not automatically retry flaky tests, update snapshots, install dependencies, or modify code to make tests pass.
7. Report the sanitized command, working directory, exit code, observed counts, failures, and checks not run. Do not write logs into the installed plugin directory.

## Windows

From PowerShell, replace the example script path with the installed skill's actual path. Use an array so arguments beginning with `-` and arguments containing spaces are forwarded correctly.

```powershell
& 'C:/path/to/plugin/skills/test-runner/run-tests.ps1' -TestExecutable 'npm.cmd' -TestArguments @('test', '--', '--runInBand')
```

PowerShell callers should inspect `$LASTEXITCODE`. A zero wrapper exit code alone does not prove tests were discovered; inspect the framework's output for zero-test runs.

Windows PowerShell 5.1 uses legacy native argument quoting. Arguments containing embedded double quotes or empty strings may not survive unchanged. For such commands, use PowerShell 7 with its standard native argument handling or the project's existing trusted script; do not use this wrapper to pass inline code containing those arguments.

## Linux and macOS

```bash
bash /path/to/plugin/skills/test-runner/run-tests.sh npm test -- --runInBand
```

These are examples, not defaults. Use the actual repository command, including focused filters supported by its framework. Bash scripts can be invoked explicitly with `bash` without relying on executable file permissions.
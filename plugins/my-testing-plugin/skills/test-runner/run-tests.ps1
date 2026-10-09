[CmdletBinding()]
param(
    [string]$TestExecutable,
    [string[]]$TestArguments = @()
)

$ErrorActionPreference = 'Stop'

if ([string]::IsNullOrWhiteSpace($TestExecutable)) {
    [Console]::Error.WriteLine('Usage: run-tests.ps1 -TestExecutable <executable> -TestArguments @(<arguments>)')
    exit 2
}

$executable = Get-Command -Name $TestExecutable -CommandType Application -ErrorAction SilentlyContinue | Select-Object -First 1
if ($null -eq $executable) {
    [Console]::Error.WriteLine('Test executable was not found. Install project prerequisites separately.')
    exit 127
}

try {
    & $executable.Source @TestArguments
    exit $LASTEXITCODE
} catch {
    [Console]::Error.WriteLine('Unable to start the test executable. Check project prerequisites.')
    exit 1
}
$ErrorActionPreference = 'Stop'

$pluginRoot = if ([string]::IsNullOrWhiteSpace($env:PLUGIN_ROOT)) {
    Split-Path -Parent $PSScriptRoot
} else {
    $env:PLUGIN_ROOT
}

$requiredFiles = @(
    'plugin.json',
    'skills/test-runner/SKILL.md',
    'skills/test-runner/run-tests.sh',
    'skills/test-runner/run-tests.ps1'
)

foreach ($relativePath in $requiredFiles) {
    if (-not (Test-Path -LiteralPath (Join-Path $pluginRoot $relativePath) -PathType Leaf)) {
        [Console]::Error.WriteLine('Testing plugin is missing a required bundled file. Reinstall or repair the plugin.')
        exit 1
    }
}

@{
    additionalContext = 'Testing plugin: use the consuming repository test command. No tests have been run by this hook.'
    systemMessage = 'Testing plugin assets checked; no tests were run.'
} | ConvertTo-Json -Compress
exit 0
# My Testing Plugin

A reusable Agent Plugins 1.0 package for testing and code review in other repositories. No Azure services, credentials, dependency installation, or remote MCP integrations are required by the plugin itself.

## Structure

```text
my-testing-plugin/
  plugin.json
  README.md
  mcp.json
  skills/test-runner/
    SKILL.md
    run-tests.sh
    run-tests.ps1
  automations/
    review.automation.md
  scripts/
    validate-tests.sh
    validate-tests.ps1
  com.github.copilot/
    agents/
      test-planner.agent.md
      test-runner.agent.md
      test-reviewer.agent.md
    hooks/
      hooks.json
```

Skills and MCP configuration use portable standard paths. Agents and hooks are Copilot-specific; automation templates are a VS Code capability. Clients load only the capabilities they support. Use a current Copilot client with Agent Plugins 1.0 support.

## Agents

| Agent | Purpose | Tools |
| --- | --- | --- |
| `test-planner` | Identify focused checks and coordinate authorized execution and review | Read, search, delegation |
| `test-runner` | Execute existing tests and report observed evidence | Read, search, terminal |
| `test-reviewer` | Review bugs, regressions, assertions, and coverage gaps | Read and search only |

The planner can delegate to the runner and reviewer when the client supports named custom-agent delegation. Otherwise, select the agents manually using the task briefs it provides. The runner does not edit tests or fix source code; use your normal implementation agent for approved fixes.

## Use locally in VS Code

In your VS Code User settings, add the absolute plugin folder to `chat.pluginLocations`. This makes it available in other workspaces without copying agent files into each repository:

```json
{
  "chat.plugins.enabled": true,
  "chat.pluginLocations": {
    "D:/Work/Dinesh/azure-github-project-setup/plugins/my-testing-plugin": true
  }
}
```

Merge these keys with existing settings rather than replacing them. Change the path when moving the package. Reload VS Code if discovery has not refreshed. Select an agent from the Chat agent picker in your consuming project; plugin discovery remains subject to client version and organization policy.

## Install with Copilot CLI

From this marketplace repository, register the local marketplace and install the plugin:

```powershell
copilot plugin marketplace add .
copilot plugin install my-testing-plugin@cicd-setup-agent
```

Alternatively, install the package directory directly:

```powershell
copilot plugin install ./plugins/my-testing-plugin
```

Start a new Copilot session in the project you want to test and select `test-planner`, `test-runner`, or `test-reviewer`. VS Code also discovers compatible plugins installed by Copilot CLI. Manage the package through the interface that installed it.

After publishing this repository, remote marketplace installation is:

```powershell
copilot plugin marketplace add https://github.com/ScalableCoPilot/CICDSetupPlugin
copilot plugin install my-testing-plugin@cicd-setup-agent
```

These commands are instructions; creating the package does not install or publish it.

## Example tasks

- Planner: "Plan focused regression tests for the changes to the checkout flow. Do not run them yet."
- Runner: "Run the existing checkout regression tests from the web package and report the command, exit code, and failures. Do not edit files."
- Reviewer: "Review these changed files and the supplied test results for concrete regressions and missing coverage."

All commands come from the consuming repository's documentation, configuration, or CI. The wrappers have no default test command and do not use `eval` or execute an environment variable as a command. Run them from the consuming project's working directory, not the installed plugin folder.

For example, only in a project that already defines `npm test`:

```powershell
& 'D:/Work/Dinesh/azure-github-project-setup/plugins/my-testing-plugin/skills/test-runner/run-tests.ps1' -TestExecutable 'npm.cmd' -TestArguments @('test', '--', '--runInBand')
$LASTEXITCODE
```

```bash
bash /path/to/my-testing-plugin/skills/test-runner/run-tests.sh npm test -- --runInBand
```

PowerShell 5.1 uses legacy native argument quoting. Embedded double quotes and empty arguments are not guaranteed to survive unchanged; use PowerShell 7 with standard argument handling or a reviewed project script for those cases. The consuming project's own runtimes and test dependencies must already be installed.

## Hooks and automation

The `SessionStart` hook checks required bundled files and returns a short reminder. Despite the script name, it does not validate test outcomes or execute tests. It does not read or echo the hook payload, log secrets, modify files, contact a service, or grant permissions. Script paths resolve from `PLUGIN_ROOT`, so installation does not depend on the consuming project's directory layout.

The configuration includes Bash and PowerShell commands for Copilot CLI and a Windows override for VS Code Local sessions. Hooks must be enabled by the client and workspace policy. Other harnesses may handle plugin hooks differently; confirm execution in the intended client before relying on them.

The `Testing review` automation is a manual template, not an enabled job. In compatible VS Code versions, select it under Templates from Plugins, review its prompt, and choose the workspace and execution configuration. Installing the plugin does not schedule or enable an automation.

## MCP integrations

The root `mcp.json` contains the required schema identifier and an empty `mcpServers` map. No server starts and no secrets are needed. Add only reviewed MCP integrations using the [portable MCP configuration format](https://agent-plugins.org/plugin-authors/mcp-servers). Never commit credentials or assume remote server fields expand environment variables. Installing a plugin can implicitly trust its MCP servers, so adding one requires a security review.

## Validate and publish

1. Parse the JSON files and validate the manifest and MCP configuration against their declared schemas.
2. Check Markdown frontmatter and verify that the skill name matches its directory.
3. Parse the PowerShell scripts and run `bash -n` on both Bash scripts. Check success, failure, missing executable, missing command, and arguments containing spaces with a harmless local executable.
4. Run each hook script directly. Expect one JSON object and exit code zero; no tests should execute.
5. Load the plugin in a current VS Code or Copilot CLI client. Confirm the three agents, skill, and supported automation template appear. Test against a trusted sample project before publishing.
6. Bump the plugin version and marketplace entry together for releases, then push to your intended repository. Keep the existing CI/CD plugin unchanged.

To publish this package as its own repository, place this folder's contents at that repository's root, include the applicable repository license, and update installation URLs. A marketplace is optional for direct installation.

Configuration and script checks do not prove live client discovery or test success in another project. Those must be exercised separately.

## License

MIT. See the [repository license](../../LICENSE) when using this package from the marketplace repository.
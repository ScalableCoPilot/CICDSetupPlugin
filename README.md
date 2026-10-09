# CICDSetupPlugin

A GitHub Copilot plugin marketplace containing an agent for planning and setting up secure GitHub Actions CI/CD workflows for Azure deployments.

## Install

Register this repository as a Copilot CLI plugin marketplace, then install the plugin:

```powershell
copilot plugin marketplace add https://github.com/ScalableCoPilot/CICDSetupPlugin
copilot plugin install cicd-setup@cicd-setup-agent
```

See [the plugin README](plugins/cicd-setup/README.md) for the agent's workflow, safety notes, and publishing details.

## Multi-agent testing plugin

The marketplace also includes [My Testing Plugin](plugins/my-testing-plugin/README.md), an Agent Plugins 1.0 package with a test planner, test runner, read-only reviewer, cross-platform scripts, a manual review automation template, and an empty MCP integration configuration.

After registering this marketplace, install it with:

```powershell
copilot plugin install my-testing-plugin@cicd-setup-agent
```

For local VS Code use across other projects, follow the plugin README's User settings instructions. No Azure identity, roles, GitHub secrets, or deployment environments are required.

# CICDSetupPlugin

A GitHub Copilot plugin marketplace containing an agent for planning and setting up secure GitHub Actions CI/CD workflows for Azure deployments.

## Install

Register this repository as a Copilot CLI plugin marketplace, then install the plugin:

```powershell
copilot plugin marketplace add https://github.com/ScalableCoPilot/CICDSetupPlugin
copilot plugin install cicd-setup@cicd-setup-agent
```

See [the plugin README](plugins/cicd-setup/README.md) for the agent's workflow, safety notes, and publishing details.

# CI/CD Setup

A GitHub Copilot plugin that helps teams plan and configure GitHub Actions CI/CD workflows for deploying applications to Azure.

## What the agent does

- Inspects the repository to identify application projects, build commands, and deployment targets.
- Collects the target branch, environments, Azure service, and approval requirements before proposing changes.
- Presents a deployment plan for approval before writing workflow files.
- Generates workflows using GitHub OIDC where supported, least-privilege permissions, and environment protection rules when appropriate.
- Validates the generated YAML and reports any configuration that must be completed in Azure or GitHub.

The agent does not provision Azure resources or request secrets. It explains the required identity and repository configuration so maintainers can complete those steps securely.

## Install from the marketplace

Register this repository as a Copilot CLI plugin marketplace and install the plugin:

```powershell
copilot plugin marketplace add https://github.com/ScalableCoPilot/CICDSetupPlugin
copilot plugin install cicd-setup@cicd-setup-agent
```

Then invoke the `cicd-setup` agent from Copilot CLI for a repository where you want to configure a deployment workflow.

## Test locally

Clone this repository, start Copilot CLI from its root, and use its local plugin-development workflow to load the plugin from `plugins/cicd-setup`. Confirm the agent appears and can inspect a sample project before publishing a release.

## Publish

1. Push this project to [ScalableCoPilot/CICDSetupPlugin](https://github.com/ScalableCoPilot/CICDSetupPlugin).
2. Keep the marketplace entry's local source path as `./plugins/cicd-setup`.
3. Validate the marketplace and plugin JSON, then test installation from the public repository.
4. Update the plugin version in both manifests when publishing a new release.

## License

This plugin is distributed under the MIT License. See the repository's `LICENSE` file.
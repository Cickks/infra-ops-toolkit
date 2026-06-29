# Setup

## Purpose

This repository documents and supports an enterprise homelab portfolio. It is not currently a software application with a build step.

## Workstation Prerequisites

Recommended tools:

- Git and Git LFS
- PowerShell 7
- VS Code
- Docker Desktop
- WSL2
- ripgrep
- fd
- jq
- Gitleaks
- Trivy
- Syft
- SOPS and age

## Repository Setup

```powershell
git status
gitleaks detect --no-git --source .
```

## Documentation Workflow

1. Add or update Markdown documentation.
2. Keep diagrams and screenshots in relevant documentation folders.
3. Avoid committing ISOs, installers, VM exports, or compressed binary downloads.
4. Run a secret scan before commits.
5. Update `CHANGELOG.md` for meaningful milestones.

## Suggested VS Code Extensions

- ESLint
- Prettier
- EditorConfig
- Playwright
- GitLens
- YAML
- PowerShell

## No Build Step Yet

There is currently no Node, Python, .NET, or frontend application stack in this repository. If a portfolio website or automation app is added later, document its setup here and add appropriate lint, test, and build commands.

# Setup

## Purpose

This repository documents and supports an enterprise homelab portfolio. It is not currently a
software application with a build step.

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

## Primary Folders

- `Documentation/HomeLab/` - homelab evidence and operational notes.
- `Documentation/HomeLab/Architecture/` - master plan, network baseline, and design notes.
- `Documentation/Server_Documentation/` - server-specific notes.
- `Documentation/TroubleShooting/` - issue-specific troubleshooting notes.
- `Windows/` - Windows administration tools and support utilities.
- `Automation/` - Terraform and future automation tooling.
- `docs/` - repo-level standards, roadmap, trackers, and guides.

## Documentation Workflow

1. Add or update Markdown documentation.
2. Keep diagrams and screenshots in relevant documentation folders.
3. Update all related index, roadmap, tracker, architecture, and evidence files when the change
   affects them.
4. Avoid committing ISOs, installers, VM exports, or compressed binary downloads.
5. Update `docs/SOFTWARE_INVENTORY.md` when adding, moving, or replacing software.
6. Run a secret scan before commits.
7. Update `CHANGELOG.md` for meaningful milestones.

## Suggested VS Code Extensions

- ESLint
- Prettier
- EditorConfig
- Playwright
- GitLens
- YAML
- PowerShell

## No Build Step Yet

There is currently no Node, Python, .NET, or frontend application stack in this repository. If a
portfolio website or automation app is added later, document its setup here and add appropriate
lint, test, and build commands.

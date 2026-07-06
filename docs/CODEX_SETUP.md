# Codex Workstation Setup

This project is designed to work well with Codex as a long-running AI engineering and documentation
partner.

## Configured MCP Servers

The user-level Codex config at `C:\Users\ignov\.codex\config.toml` includes:

| Server                | Purpose                                            | Auth                  |
| --------------------- | -------------------------------------------------- | --------------------- |
| `node_repl`           | Browser and JavaScript-backed Codex plugin runtime | Local bundled runtime |
| `openaiDeveloperDocs` | Official OpenAI and Codex documentation            | None                  |
| `context7`            | Up-to-date library and framework documentation     | None                  |

The config was backed up before MCP changes:

```text
C:\Users\ignov\.codex\config.toml.backup-20260629-013347
```

## Existing Codex Plugins

Already enabled in global Codex config:

- Browser
- Chrome
- Documents
- PDF
- Spreadsheets
- Presentations
- Template Creator

These support portfolio documentation, browser verification, file inspection, Word/PDF work, and
spreadsheet/report workflows.

## Recommended Connectors To Authorize

These require user sign-in or token setup and should not be hardcoded into repository files:

| Connector / Plugin | Why It Matters                                              |
| ------------------ | ----------------------------------------------------------- |
| GitHub             | Push branches, create PRs, inspect issues, debug CI         |
| Google Drive       | Read and update Google Docs, Sheets, Slides source material |
| Figma              | Future portfolio UI/design diagrams and design-to-code work |
| Codex Security     | Deeper security scan workflows inside Codex                 |

## GitHub CLI

GitHub CLI is installed but still needs interactive auth:

```powershell
gh auth login
```

After authentication, Codex can use GitHub workflows more effectively.

## Restart Requirement

After changing MCP config, restart Codex or start a fresh Codex thread so newly configured MCP
servers are discovered.

## Safety Rules

- Do not store access tokens in this repository.
- Prefer environment variables or connector authorization flows.
- Keep broad filesystem MCP servers disabled unless there is a specific need.
- Use Codex approvals for writes outside trusted repositories.
- Keep large binary assets ignored by Git.

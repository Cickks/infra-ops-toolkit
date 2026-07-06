# Infrastructure Operations Toolkit

Infrastructure Operations Toolkit is a documentation-first repository for a hands-on homelab used to
practice systems administration, Linux operations, networking, cybersecurity, automation, and
production-style documentation.

This is not an application repo. There is no build step, API server, or packaged product here. The
value of the repository is the operating evidence: runbooks, architecture notes, inventories,
troubleshooting guides, standards, and phase tracking.

## Current Focus

- Windows Server and Active Directory foundation
- Linux administration on `LINUX01`
- File sharing with Samba and NFS
- Change management and rollback discipline
- Documentation standards for servers, services, ports, incidents, and lessons learned
- Future self-hosted services only after storage, backups, monitoring, and rollback are documented

## Core Environment

| Item        | Value                    |
| ----------- | ------------------------ |
| Domain      | `corp.local`             |
| Subnet      | `192.168.50.0/24`        |
| Gateway     | `192.168.50.1`           |
| Primary DNS | `192.168.50.10` (`DC01`) |

## Folder Structure

| Path                                  | Purpose                                                |
| ------------------------------------- | ------------------------------------------------------ |
| `Documentation/HomeLab/`              | Homelab architecture, SOPs, server notes, and evidence |
| `Documentation/TroubleShooting/`      | Issue-specific troubleshooting notes                   |
| `Documentation/Server_Documentation/` | Server-specific documentation                          |
| `docs/`                               | Roadmap, phase tracker, inventories, and standards     |
| `Linux/`                              | Linux administration, services, Docker, backups, SSH   |
| `Windows/`                            | Windows administration tooling and notes               |
| `PowerShell/`                         | Administration scripts, reports, and testing notes     |
| `Networking/`                         | Network documentation and tooling notes                |
| `Security/`                           | Hardening, vulnerability scanning, and security notes  |
| `Automation/`                         | Terraform and future automation documentation          |
| `Certifications/`                     | Certification study notes and alignment                |
| `Drivers/`                            | Driver-source notes, not binary driver packages        |
| `screenshots/`                        | Curated evidence screenshots only                      |

## Documentation Index

- [Architecture](ARCHITECTURE.md)
- [Setup](SETUP.md)
- [Contributing](CONTRIBUTING.md)
- [Security](SECURITY.md)
- [Change log](CHANGELOG.md)
- [Homelab master plan](Documentation/HomeLab/Architecture/MASTER_PLAN.md)
- [Network baseline](Documentation/HomeLab/Architecture/NETWORK_BASELINE.md)
- [Roadmap](docs/ROADMAP.md)
- [Phase tracker](docs/PHASE_TRACKER.md)
- [IP addressing](docs/IP_ADDRESSING.md)
- [Server inventory](docs/SERVER_INVENTORY.md)
- [Software inventory](docs/SOFTWARE_INVENTORY.md)
- [Operations runbook](docs/OPERATIONS_RUNBOOK.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)
- [Evidence standards](docs/EVIDENCE_STANDARDS.md)

## Development Workflow

`main` is the stable branch. Active documentation and tooling work should happen on `dev` or on
short-lived branches created from `dev`.

Recommended flow:

```powershell
git switch dev
git pull
git switch -c docs/short-description
npx --yes prettier --check "**/*.md"
git status
```

Merge into `main` only after Markdown checks pass and related indexes, inventories, and changelog
entries are updated.

## Verification

Use these checks before opening or merging work:

```powershell
npx --yes prettier --check "**/*.md"
git status
```

Optional local checks when tools are installed:

```powershell
gitleaks detect --no-git --source .
```

## Repository Policy

- Do not commit passwords, API keys, private keys, recovery keys, or unredacted screenshots.
- Do not commit ISOs, installers, VM exports, disk images, or large archives.
- Keep software source URLs, versions, and checksums in Markdown.
- Keep screenshots intentional, redacted, and named according to `screenshots/README.md`.
- Keep claims factual. Do not document services as complete until they have validation evidence.

## Known Limitations

- This repo is documentation-heavy by design and does not currently include a deployable app.
- Some future-phase folders exist as routing points before implementation evidence is added.
- Screenshots should be periodically reviewed for redaction and filename quality.

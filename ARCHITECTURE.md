# Architecture

## Overview

Infrastructure Operations Toolkit documents a realistic SMB-style homelab for systems
administration, infrastructure engineering, cybersecurity, networking, cloud, automation, and future
AI operations work.

The lab is intentionally sequenced: infrastructure fundamentals come first, then security,
monitoring, cloud, automation, DevOps, and AI. The future LocalOps Assistant platform should enhance
operations only after the environment is understood and documented.

## Documentation Map

Use these files as the architecture source of truth:

- `Documentation/HomeLab/Architecture/MASTER_PLAN.md` - homelab master plan summary and sequencing.
- `Documentation/HomeLab/Architecture/NETWORK_BASELINE.md` - network, host, DNS, and DHCP baseline.
- `docs/ROADMAP.md` - Enterprise Homelab Master Plan v12.0 summary.
- `docs/PHASE_TRACKER.md` - current phase status and portfolio evidence checklist.
- `docs/SERVER_INVENTORY.md` - server and client inventory.

## Design Philosophy

- Build the foundation first.
- Understand before automating.
- Document everything.
- Follow enterprise best practices.
- Use the lab as a professional portfolio.
- Make every phase useful for real interviews and job tasks.

## Network Baseline

| Item            | Value                    |
| --------------- | ------------------------ |
| Domain          | `corp.local`             |
| Subnet          | `192.168.50.0/24`        |
| Default gateway | `192.168.50.1`           |
| Primary DNS     | `192.168.50.10` (`DC01`) |

## Core Windows Infrastructure

| Host       | Role                                                                |
| ---------- | ------------------------------------------------------------------- |
| `DC01`     | Active Directory Domain Services, DNS, Kerberos, OUs, users, groups |
| `DHCP01`   | DHCP scope and address leasing                                      |
| `FILE01`   | File services and shared storage                                    |
| `PRINT01`  | Print services                                                      |
| `CLIENTxx` | Domain-joined Windows workstations                                  |

## Linux And Future Platform Areas

- `LINUX01` for Linux administration fundamentals.
- SSH administration.
- Docker and Portainer.
- Security hardening and monitoring.
- Wazuh and vulnerability scanning.
- Terraform and infrastructure-as-code for future cloud and automation phases.
- Future automation and AI operations layers.

## Operational Model

Every infrastructure change should include:

1. Objective.
2. Prerequisites.
3. Implementation steps.
4. Validation commands.
5. Rollback plan.
6. Lessons learned.
7. Interview relevance.

## Evidence Model

Portfolio evidence should be stored as:

- Markdown summaries.
- Screenshots with meaningful filenames.
- Command-output summaries.
- Diagrams.
- SOPs and troubleshooting guides.
- Change logs.

Large binary artifacts should remain outside Git history.

## Folder Routing

Use these folders for portfolio evidence:

- `Documentation/HomeLab/Architecture/` for architecture, master plan, and baseline design.
- `Documentation/HomeLab/Servers/` and `Documentation/Server_Documentation/` for server evidence.
- `Documentation/HomeLab/Clients/` for workstation and help desk evidence.
- `Documentation/HomeLab/Network/` and `Documentation/Network_Diagrams/` for network notes and
  diagrams.
- `Documentation/HomeLab/SOPs/` and `Documentation/SOPs/` for procedures.
- `Documentation/TroubleShooting/` for issue-specific troubleshooting notes.
- `Windows/` for Windows administration tooling.
- `Automation/` for Terraform and future automation tooling.

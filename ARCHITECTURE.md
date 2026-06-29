# Architecture

## Overview

The Enterprise Homelab simulates a realistic SMB IT environment for systems administration, infrastructure engineering, cybersecurity, networking, cloud, automation, and future AI operations work.

The lab is intentionally sequenced: infrastructure fundamentals come first, then security, monitoring, cloud, automation, DevOps, and AI. The future AI Steve platform should enhance operations only after the environment is understood and documented.

## Design Philosophy

- Build the foundation first.
- Understand before automating.
- Document everything.
- Follow enterprise best practices.
- Use the lab as a professional portfolio.
- Make every phase useful for real interviews and job tasks.

## Network Baseline

| Item | Value |
| --- | --- |
| Domain | `corp.local` |
| Subnet | `192.168.50.0/24` |
| Default gateway | `192.168.50.1` |
| Primary DNS | `192.168.50.10` (`DC01`) |

## Core Windows Infrastructure

| Host | Role |
| --- | --- |
| `DC01` | Active Directory Domain Services, DNS, Kerberos, OUs, users, groups |
| `DHCP01` | DHCP scope and address leasing |
| `FILE01` | File services and shared storage |
| `PRINT01` | Print services |
| `CLIENTxx` | Domain-joined Windows workstations |

## Linux And Future Platform Areas

- `LINUX01` for Linux administration fundamentals.
- SSH administration.
- Docker and Portainer.
- Security hardening and monitoring.
- Wazuh and vulnerability scanning.
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

# Enterprise Homelab Roadmap

## Master Plan

Enterprise Homelab Master Plan v12.0.

Canonical portfolio locations:

- `../Documentation/HomeLab/Architecture/MASTER_PLAN.md`
- `../Documentation/HomeLab/Architecture/NETWORK_BASELINE.md`
- `PHASE_TRACKER.md`
- `SERVER_INVENTORY.md`

Focus areas:

- Windows
- Linux
- Cybersecurity
- Cloud
- Automation
- AI
- Career launch

Supporting software inventory:

- `SOFTWARE_INVENTORY.md`

## Current Status

- Target graduation: 2027.
- Current status from source document: Phase 12 in progress.
- Current focus: `LINUX01` advanced Linux practice through backups, first app planning,
  documentation platform planning, then dedicated `INFRA01` production readiness.
- Recently completed: Phase 12.7 Gitea first self-hosted app deployment, Git workflow validation,
  backup, checksum, manifest, and restore test on `LINUX01`.

## Mission

Build a realistic enterprise IT environment from the perspective of a Systems Administrator,
Infrastructure Engineer, and Cybersecurity professional.

## Sequencing Principle

AI development intentionally starts after completing the Windows, Linux, networking, cybersecurity,
monitoring, cloud, automation, and DevOps foundation. The goal is to become a strong Systems
Administrator first, then build LocalOps Assistant as a platform that enhances and automates
enterprise operations.

## Core Principles

- Build the foundation first.
- Understand before automating.
- Document everything.
- Follow enterprise best practices.

## Portfolio Outcome

Each phase should produce:

- Completed objective.
- Evidence.
- Troubleshooting notes.
- Lessons learned.
- Interview talking points.
- Next steps.

## Phase 12 Direction

Phase 12 should build advanced Linux confidence before installing several self-hosted applications.
`LINUX01` remains the safe training and staging host, while `INFRA01` is prepared as the future 24/7
infrastructure host before real services are placed on it.

Primary order:

1. Confirm rollback readiness and optional package maintenance for `LINUX01`.
2. Practice INFRA01 production-readiness concepts on `LINUX01`: disk discovery, mounting, static IP
   planning, SSH validation, Docker data paths, Docker, Compose, and Portainer review.
3. Build Samba for Windows/Linux file-sharing practice. Complete.
4. Build NFS for Linux-to-Linux sharing and future container/storage concepts. Complete.
5. Create cron jobs for scheduled maintenance and reporting. Complete.
6. Create a custom systemd service to prove service lifecycle management. Complete.
7. Expand SSH key authentication and portfolio sync to `INFRA01`. Complete.
8. Build Linux backup and restore validation. Complete.
9. Choose one first self-hosted app with a documented change plan. Complete with Gitea on `LINUX01`.
10. Plan the enterprise documentation platform after backups and first-app decision are understood.
11. Prepare `INFRA01` hardware before services as a dedicated production-readiness change: NVMe HAT,
    1TB NVMe SSD, active cooling, OS updates, SSH, static IP/DHCP reservation, SSD mount, Docker
    data path, Docker Engine, Compose, Portainer, backup plan, and rollback.

First-app order:

1. Gitea: complete as the first app on `LINUX01`; validated web UI, private repository creation,
   HTTP Git push, backup, checksum, manifest, and restore test.
2. Vaultwarden: recommended after backup and security process is proven because it handles secrets
   and requires stronger operational discipline.
3. Nextcloud: defer until storage and restore process are stronger because it is storage-heavy and
   backup-sensitive.
4. Home Assistant: optional; use only if there is a clear hardware or integration goal.
5. Jellyfin: defer because it is media/storage-heavy and lower priority for the
   systems-administrator career track.

Enterprise documentation platform:

- Recommended placement: Phase 12.8, after Linux backups and first-app planning.
- Build BookStack or Wiki.js first, not both at the same time.
- BookStack is the recommended first documentation platform if the goal is clean SOPs, server-build
  notes, troubleshooting guides, change logs, and incident reports.
- Wiki.js is a strong alternate if the goal is Git-backed documentation and DevOps-style
  documentation workflows.
- Documentation targets: SOPs, server builds, troubleshooting guides, change logs, incident reports,
  rollback procedures, port and service inventory, and backup/restore tests.

Enterprise reason:

- This sequence teaches the operating-system services that real self-hosted platforms depend on:
  identity, network access, storage paths, permissions, service supervision, scheduled jobs, logs,
  backups, and rollback.
- This also keeps the future 24/7 host clean: risky concepts are practiced on `LINUX01`, while
  `INFRA01` becomes production-ready before monitoring, automation, dashboards, and LocalOps
  Assistant integrations rely on it.

## Evidence Routing

Store phase evidence in the most specific folder:

- Architecture and baseline design: `../Documentation/HomeLab/Architecture/`
- Server work: `../Documentation/Server_Documentation/<HOST>/`
- Cross-server notes: `../Documentation/HomeLab/Servers/`
- Client and help desk scenarios: `../Documentation/HomeLab/Clients/`
- Network implementation: `../Documentation/HomeLab/Network/`
- SOPs: `../Documentation/HomeLab/SOPs/`
- Troubleshooting: `../Documentation/TroubleShooting/`

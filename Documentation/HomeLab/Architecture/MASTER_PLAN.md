# Enterprise Homelab Master Plan

Source: Enterprise Homelab Master Plan v12.0.

## Mission

Build a realistic enterprise IT environment from the perspective of a Systems Administrator, Infrastructure Engineer, and Cybersecurity professional.

## Current Status

| Item | Value |
| --- | --- |
| Target graduation | 2027 |
| Current phase | Phase 12 |
| Current focus | LINUX01 advanced Linux practice through backups, app planning, documentation platform planning, then INFRA01 production readiness |
| Recently completed | Phase 11.9 enterprise hardening and environment validation |
| Future platform | AI Steve / AI Operations Platform |

## Sequencing

1. Windows Server and Active Directory foundation.
2. Active Directory administration and help desk operations.
3. Stable homelab export, migration, and rollback evidence.
4. PowerShell Remoting validation.
5. Linux administration fundamentals on `LINUX01`.
6. Networking, cybersecurity, monitoring, cloud, automation, and DevOps.
7. AI Steve after the infrastructure foundation is understood and documented.

## Dashboard Sub-Plan

The homelab should eventually have dashboards for both the workstation and INFRA01:

- Laptop/workstation dashboard first: static or lightweight local dashboard for server links, IPs, roles, phase status, and documentation links.
- INFRA01 dashboard later: add Raspberry Pi status after Phase 11.8 storage, OS, SSH, and IP validation.
- Pi-hosted services dashboard later: wait until storage is stable; heavier services can wait for a future SSD upgrade.
- Monitoring dashboard later: Uptime Kuma, Grafana, Prometheus, and service checks during monitoring phases.
- AI Steve integration later: use the dashboard/service inventory as a source for automation, documentation, and AI operations.

This keeps the dashboard goal visible without forcing heavy services onto Raspberry Pi storage too early.

## INFRA01 Strategy

`INFRA01` is the future always-on Raspberry Pi infrastructure host, but it will mature in stages.

Current state:

- Staged Raspberry Pi 5.
- Raspberry Pi OS Lite installed.
- SSH validated.
- Running on staging Wi-Fi at `192.168.1.133`.
- Future production target IP is `192.168.50.60`.
- Storage is currently microSD, so important write-heavy services should wait.

Operating decision:

- Use `LINUX01` as the main Phase 12 practice and testing host.
- Use `INFRA01` for production-readiness work before real services: NVMe HAT, 1TB NVMe SSD, active cooling, OS updates, SSH, static IP/DHCP reservation, SSD-backed Docker data, Docker Engine, Compose, and Portainer.
- Continue practicing risky service concepts on `LINUX01` before promoting them to `INFRA01`.
- Make `INFRA01` a primary services host after SSD storage, Docker data placement, monitoring, and backup planning are in place.

Future AI Steve path:

- Phase 14 gives visibility through monitoring and dashboards.
- Phase 18 makes `INFRA01` a real container/services node.
- Phase 22 lets AI Steve read from or operate against documented services, health checks, logs, and inventories.

Expanded AI Steve vision:

- AI Steve should become more than an infrastructure chatbot.
- Long-term target: a personal enterprise operating system for infrastructure, documentation, help desk practice, cybersecurity, automation, portfolio evidence, certification study, future business workflows, and personal productivity.
- AI Steve should only run meaningful operations against documented, monitored, backed-up systems with approval gates and rollback plans.

## Portfolio Outcome

Each phase should produce:

- Completed objective.
- Evidence.
- Troubleshooting notes.
- Lessons learned.
- Interview talking points.
- Next steps.

## Phase 12 Operating Plan

Phase 12 advances `LINUX01` from Linux fundamentals into internal service hosting.

Core build order:

1. Samba. Complete.
2. NFS. Complete.
3. Cron jobs. Next.
4. Custom systemd services.
5. SSH key expansion.
6. Linux backups and restore testing.
7. First self-hosted application decision and change plan.
8. Enterprise documentation platform planning.
9. Dedicated INFRA01 production readiness after the LINUX01 practice path unless hardware readiness becomes urgent.

First-app guidance:

- Prefer Gitea as the first real self-hosted application after backup basics because it teaches Git, repositories, service ownership, persistence, updates, and restore testing.
- Use Vaultwarden after backup and security processes are proven because it handles secrets.
- Keep Nextcloud for later after storage confidence improves.
- Defer Jellyfin because it is media/storage-heavy and lower priority for the systems-administrator career track.
- Use Home Assistant only if there is a clear hardware or integration goal.

Enterprise documentation platform guidance:

- Place the documentation platform after backups and first-app planning, not as Phase 12.5.
- Build BookStack or Wiki.js first, not both at the same time.
- Prefer BookStack first for clean SOPs, server builds, troubleshooting guides, change logs, and incident reports.
- Use Wiki.js first only if Git-backed documentation and DevOps-style documentation workflows are the main goal.

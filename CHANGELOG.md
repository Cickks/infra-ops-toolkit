# Changelog

## 2026-07-06

- Completed Phase 12.2 NFS baseline on `LINUX01`.
- Installed `nfs-kernel-server` and `nfs-common` version `1:2.6.4-3ubuntu5.1`.
- Configured internal NFS export `/srv/nfs/linux_shared` for the `192.168.56.0/24` management
  subnet.
- Validated NFS service state, export visibility, TCP ports `111` and `2049`, `nfs4` mount behavior,
  file create/read/delete, unmount, server-side cleanup, and rollback notes.
- Recorded the expected historical `/etc/exports` startup warning and resolved it by creating and
  backing up `/etc/exports` before applying the controlled export.

## 2026-06-30

- Started the new Phase 12 flow by marking 12.0A LINUX01 practice before INFRA01 as in progress.
- Added `Linux/ProductionReadiness/README.md` and `Linux/ProductionReadiness/INFRA01_RUNBOOK.md` for
  practice-first INFRA01 production readiness.
- Revised Phase 12 direction to add `LINUX01` practice before `INFRA01` changes and a new `INFRA01`
  production-readiness step before real services.
- Planned `INFRA01` upgrades now include NVMe HAT, 1TB NVMe SSD, active cooling, Raspberry Pi OS
  updates, SSH key validation, static IP or DHCP reservation, SSD-backed Docker data, Docker Engine,
  Docker Compose, and Portainer.
- Expanded the LocalOps Assistant vision beyond infrastructure chat: local operations support for
  homelab operations, documentation, help desk workflows, security, automation, career evidence,
  study, business automation, dashboard/voice interaction, and personal productivity.
- Added `LocalOps Assistant/docs/AI_STEVE_VISION.md` and linked it from the LocalOps Assistant
  README.
- Documented the INFRA01 lifecycle strategy: staged Raspberry Pi now, light use during Phase 12,
  monitoring/dashboard visibility later, main always-on services host around Phase 18 after SSD
  readiness, and LocalOps Assistant integration around Phase 22.
- Recorded the storage decision that the 128GB microSD is valid for boot/staging, while SSD storage
  should be added before important write-heavy services.
- Started Phase 12 Advanced Linux and self-hosting kickoff.
- Added Phase 12 sequence guidance for Samba, NFS, cron, systemd services, SSH key expansion, Linux
  backups, and first self-hosted app selection.
- Updated roadmap, phase tracker, Linux index, `LINUX01` server documentation, master plan, and
  server inventory for Phase 12.
- Started Phase 11.6 Docker Engine baseline for `LINUX01`.
- Validated pre-change state over SSH: Ubuntu 24.04.4 LTS, user `michael`, no Docker CLI installed,
  no Docker unit files present, and sufficient baseline disk and memory for Docker testing.
- Added a production-style Docker runbook with official apt repository install steps, service
  validation, `hello-world` runtime validation, troubleshooting, rollback, evidence targets,
  security notes, and interview relevance.
- Updated Phase tracker, roadmap, master plan, server inventory, Linux documentation, and `LINUX01`
  host documentation for Phase 11.6.
- Validated Docker Engine 29.6.1, Docker Compose plugin v5.2.0, active/enabled `docker.service` and
  `containerd.service`, successful `hello-world` container execution, and intentionally blocked
  non-root Docker API access.
- Completed Phase 11.6 Docker validation by capturing `docker info`, container inventory, image
  inventory, default networks, and empty volume inventory.
- Documented the distinction between Windows Docker Desktop for local development and Docker Engine
  on `LINUX01` for server-side homelab infrastructure.
- Started Phase 11.7 Portainer for `LINUX01`.
- Added a Portainer CE runbook, Compose deployment definition, pre-change validation checklist,
  HTTPS management plan, rollback steps, Docker socket security warning, and evidence targets.
- Updated Phase tracker, roadmap, master plan, server inventory, Linux documentation, and `LINUX01`
  host documentation for Phase 11.7.
- Completed Phase 11.7 Portainer validation: container running, `portainer_data` volume created,
  `portainer_network` created, host port `9443` reachable from Windows, Portainer UI loaded, admin
  login working, and local Docker environment visible.
- Added a dashboard sub-plan covering a laptop/workstation dashboard first, INFRA01 visibility after
  Raspberry Pi setup, Pi-hosted dashboards after stable storage, monitoring integration, and future
  LocalOps Assistant/LabTrack integration.
- Completed Phase 11.8 Raspberry Pi preparation for `INFRA01`: Raspberry Pi OS Lite installed on
  microSD, hostname `infra01`, Wi-Fi staging IP `192.168.1.133`, SSH validated from Windows,
  baseline system evidence captured, package updates applied, reboot tested, and future production
  IP/storage decisions documented.
- Updated roadmap, master plan, and Linux documentation to make Phase 11.9 enterprise hardening and
  environment validation the next focus.
- Started Phase 11.9 enterprise hardening and environment validation.
- Documented Phase 11.9 DNS and WinRM findings: FILE01 initially offline, stale DNS records,
  production versus management DNS cleanup, scoped TrustedHosts on the physical workstation, and
  successful WinRM validation to DC01, PRINT01, DHCP01, and FILE01 by management FQDN.
- Documented Phase 11.9 Linux and container health validation: LINUX01 SSH, Docker, containerd,
  Portainer container, Portainer volume/network, Portainer port `9443`, INFRA01 SSH, INFRA01 staging
  IP, storage, memory, SSH service, and update state.
- Completed Phase 11.9 enterprise hardening and environment validation, including the RDP-closed
  decision, WinRM-as-primary-admin-path decision, stable VM snapshots, INFRA01 backup note, and
  final Phase 11 readiness summary.
- Marked Phase 11 complete and moved the roadmap to Phase 12 Advanced Linux and self-hosting
  planning.
- Added a safe manual Portfolio sync script for copying `C:\Portfilio` to `/home/michael/Portfolio`
  on Linux hosts without deleting remote files.
- Completed first manual Portfolio sync to `LINUX01`; verified remote files, Markdown readability,
  and exclusions for `.git`, `node_modules`, and `dist`. `INFRA01` sync remains pending until SSH
  key authentication is configured.

## 2026-06-29

- Marked Phase 11.4 SSH administration and 11.4.8 SSH troubleshooting complete for `LINUX01`.
- Documented successful SSH validation over management IP `192.168.56.50`, including service state,
  port `22`, SSH alias, and auth log review.
- Recorded Phase 11.5 follow-up items for `linux01` DNS resolution, production IP `192.168.50.50`,
  and adapter mapping.
- Expanded server documentation for `DC01`, `DHCP01`, `FILE01`, `PRINT01`, `LINUX01`, and `INFRA01`
  with notes, commands, validation, evidence, rollback, and interview relevance.
- Expanded HomeLab section docs with client, network, backup, SOP, and cross-server command
  guidance.
- Added documentation guidance for PowerShell, Linux, Security, Certifications, Drivers, ISOs,
  Networking documentation, and screenshots folders.
- Added project readiness checklist to separate ready-to-start structure from remaining live
  evidence capture.
- Downloaded and organized Terraform, Sysinternals Suite, and Windows Admin Center into
  phase-appropriate local folders.
- Added software inventory with source URLs, purposes, and SHA256 hashes.
- Added `Windows/` and `Automation/` folder documentation.
- Added top-level portfolio workspace README and root `.gitignore`.
- Filled empty homelab architecture, server documentation, SOP, network diagram, and troubleshooting
  folders with README guidance.
- Added homelab master plan and network baseline files under `Documentation/HomeLab/Architecture/`.
- Updated navigation, architecture, roadmap, phase tracker, evidence standards, setup, contribution,
  change-management, and agent guidance to keep related docs synchronized.
- Added documentation-first repository foundation for Infrastructure Operations Toolkit.
- Added AI agent instructions for future coding and documentation assistants.
- Added architecture, setup, security, contribution, roadmap, IP addressing, operations, interview,
  and AI prompting documentation.
- Added `.gitignore` rules to prevent large binaries and secrets from entering Git history.
- Added GitHub Actions, Dependabot, Prettier, Git attributes, and API documentation placeholders.
- Added phase tracking, evidence standards, server/client inventory, change management, and
  troubleshooting documentation.
- Documented Codex MCP setup, plugin state, connector auth needs, and safety rules.

- Completed Phase 11.5 Linux networking validation for `LINUX01`, including interface mapping,
  Netplan DNS scoping, management DNS records, workstation resolver configuration, DNS cleanup, and
  routing validation.

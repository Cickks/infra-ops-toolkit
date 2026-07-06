# Phase Tracker

Use this tracker to turn the master plan into portfolio evidence. Keep each phase small enough that
a reviewer can understand the objective, evidence, and skills demonstrated.

## Status Legend

| Status      | Meaning                                     |
| ----------- | ------------------------------------------- |
| Planned     | Not started yet                             |
| In Progress | Active work                                 |
| Validation  | Built, currently being tested               |
| Complete    | Tested and documented                       |
| Revisit     | Needs cleanup, rework, or stronger evidence |

## Current Phase Snapshot

| Phase | Area                                            | Status               | Evidence Target                                                                                                                                              |
| ----- | ----------------------------------------------- | -------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| 1     | Windows Server and Active Directory             | Complete             | AD DS notes, `DC01`, domain baseline                                                                                                                         |
| 2     | Active Directory Administration                 | Complete             | OUs, users, groups, GPO notes                                                                                                                                |
| 3     | Help Desk Operations                            | Complete/In Progress | Tickets, offboarding, rehire, PC deployment                                                                                                                  |
| 9     | Stable Enterprise Homelab Export                | Complete             | OVA export notes and rollback                                                                                                                                |
| 10    | LG Gram Migration                               | Complete/In Progress | Transfer, import, validation notes                                                                                                                           |
| 10.2  | PowerShell Remoting                             | In Progress          | Remoting commands and server checks                                                                                                                          |
| 11    | Linux Administration Fundamentals               | Complete             | Linux, SSH, networking, Docker, Portainer, Raspberry Pi prep, hardening, and validation evidence                                                             |
| 11.4  | SSH Administration                              | Complete             | SSH key login, service validation, port 22 test, auth log review                                                                                             |
| 11.5  | Linux Networking                                | Complete             | Netplan, DNS, routing, interface mapping, name resolution                                                                                                    |
| 11.6  | Docker Engine Baseline                          | Complete             | Docker installed; daemon active/enabled; Compose present; hello-world and inventory validation passed                                                        |
| 11.7  | Portainer                                       | Complete             | Portainer CE deployed; HTTPS UI validated; local Docker environment visible; access-control notes captured                                                   |
| 11.8  | Raspberry Pi Preparation                        | Complete             | `INFRA01` imaged, Wi-Fi connected, SSH validated, updated, reboot tested, staging IP documented                                                              |
| 11.9  | Enterprise Hardening And Environment Validation | Complete             | DNS cleanup, WinRM validation, Linux/Portainer/INFRA01 checks, snapshots, and final Phase 11 readiness                                                       |
| 12    | Advanced Linux And Self-Hosting                 | In Progress          | Linux shared services, automation primitives, backups, and first self-hosted service planning                                                                |
| 12.0A | LINUX01 Practice Before INFRA01                 | Complete             | Baseline and package-maintenance validation complete; new kernel `6.8.0-134-generic`, SSH, Docker, containerd, Compose, and Portainer validated after reboot |
| 12.0B | INFRA01 Production Readiness                    | Planned              | NVMe HAT, 1TB NVMe SSD, active cooling, OS updates, SSH, static IP/DHCP reservation, Docker, Compose, Portainer, and SSD-backed data path                    |
| 22    | LocalOps Assistant / AI Operations Platform     | Planned              | Prompt/versioning, provider abstraction, ops automation                                                                                                      |

## Current Phase 12 Detail

Goal:

- Turn `LINUX01` from a Linux fundamentals host into a controlled internal services host.
- Practice production-readiness tasks safely on `LINUX01` before applying them to `INFRA01`.
- Prepare `INFRA01` as a future 24/7 infrastructure, monitoring, automation, dashboard, and LocalOps
  Assistant node before real services depend on it.
- Build enterprise Linux skills before adding heavier self-hosted apps.
- Keep self-hosting management-only and documentation-first.

Recommended sequence:

| Subphase | Area                              | Status      | Notes                                                                                                                                                                                         |
| -------- | --------------------------------- | ----------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| 12.0     | Kickoff and change plan           | In Progress | Confirm snapshots, package maintenance plan, service naming, storage paths, firewall scope, and evidence targets                                                                              |
| 12.0A    | LINUX01 readiness practice        | Complete    | 2026-07-05 baseline passed; 2026-07-06 package maintenance and post-reboot validation passed                                                                                                  |
| 12.0B    | INFRA01 production readiness      | Planned     | Dedicated INFRA01 hardware/storage/service-foundation phase after LINUX01 practice through 12.7 unless hardware readiness becomes urgent                                                      |
| 12.1     | Samba baseline                    | Complete    | `linux_shared` Samba share validated from Windows; authentication, mapping, write/read/delete, server-side cleanup, permissions, and logs checked                                             |
| 12.2     | NFS baseline                      | Complete    | Internal NFS export `/srv/nfs/linux_shared` validated on `LINUX01`; package install, export config, ports `111/2049`, mount, write/read/delete, unmount, cleanup, and rollback notes complete |
| 12.3     | Cron jobs                         | Planned     | Scheduled Linux tasks for maintenance, reports, and backup checks                                                                                                                             |
| 12.4     | Custom systemd services           | Planned     | Build and manage a simple internal service with unit files, logs, enablement, and rollback                                                                                                    |
| 12.5     | SSH key expansion                 | Planned     | Add `INFRA01` key auth and complete portfolio sync workflow                                                                                                                                   |
| 12.6     | Linux backups                     | Planned     | Back up configs, service data, and documentation with restore validation                                                                                                                      |
| 12.7     | First self-hosted app decision    | Planned     | Choose one starter app after shared-service and backup basics are proven                                                                                                                      |
| 12.8     | Enterprise documentation platform | Planned     | Choose BookStack or Wiki.js first; document SOPs, server builds, troubleshooting guides, change logs, incidents, rollback, ports, and backup/restore tests                                    |

Phase 12 first-app recommendation:

- Start with Gitea only after Samba, NFS, cron, systemd, SSH keys, and backup basics are documented.
- Use Vaultwarden after backup and security handling are proven because it stores secrets.
- Defer Nextcloud until storage and backup discipline are stronger.
- Defer Jellyfin because it is media-heavy and less relevant to the immediate systems-administrator
  track.
- Defer Home Assistant unless there is a clear hardware/integration goal.

Evidence target:

- `../Linux/SelfHosting/README.md`
- `../Linux/ProductionReadiness/README.md`
- `../Linux/ProductionReadiness/INFRA01_RUNBOOK.md`
- `../Linux/Samba/README.md`
- `../Linux/NFS/README.md`
- `../Linux/Cron/README.md`
- `../Linux/Systemd/README.md`
- `../Linux/Backups/README.md`
- `../Documentation/Server_Documentation/LINUX01/README.md`

## Phase 11 Detail

| Subphase | Area                                            | Status   | Notes                                                                                                                    |
| -------- | ----------------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------ |
| 11.4.8   | SSH troubleshooting                             | Complete | Validated SSH over management network `192.168.56.50`; reviewed service state, port 22 listener, and `/var/log/auth.log` |
| 11.5     | Linux networking                                | Complete | Management DNS, Linux interface mapping, DNS cleanup, and routing validation complete                                    |
| 11.6     | Docker Engine baseline                          | Complete | Docker Engine 29.6.1 installed; services active/enabled; hello-world and inventory validation passed                     |
| 11.7     | Portainer                                       | Complete | Portainer CE running on `9443`; UI and local Docker environment validated                                                |
| 11.8     | Raspberry Pi preparation                        | Complete | `INFRA01` online at staging IP `192.168.1.133`; SSH, update, storage, memory, and reboot validation complete             |
| 11.9     | Enterprise hardening and environment validation | Complete | Windows DNS/WinRM, Linux, Docker, Portainer, INFRA01, RDP decision, and snapshot readiness validated                     |

## Readiness

See `PROJECT_READINESS.md` for the current decision on whether the portfolio foundation is ready to
begin active project work.

## Dashboard Sub-Plan

Purpose: track the future homelab services dashboard so it does not get lost between Phase 11,
INFRA01, monitoring, and LocalOps Assistant.

| Stage       | Target                         | Status  | Notes                                                                                                         |
| ----------- | ------------------------------ | ------- | ------------------------------------------------------------------------------------------------------------- |
| Dashboard-1 | Laptop/workstation dashboard   | Planned | Build a lightweight local dashboard first for service links, IPs, roles, phase status, and evidence links     |
| Dashboard-2 | Add INFRA01 visibility         | Planned | After Raspberry Pi microSD setup, track hostname, IP, SSH status, storage state, and future service readiness |
| Dashboard-3 | Pi-hosted dashboard            | Future  | Host on INFRA01 after storage is stable; heavier service hosting can wait until SSD upgrade                   |
| Dashboard-4 | Monitoring integration         | Future  | Add Uptime Kuma, Grafana, Prometheus, and service checks during monitoring phases                             |
| Dashboard-5 | LocalOps Assistant integration | Future  | Feed dashboard/service inventory into LocalOps Assistant, LabTrack, or documentation automation later         |

Initial dashboard fields:

- Hostname.
- Role.
- Production IP.
- Management IP.
- Service URLs.
- Owner/admin notes.
- Phase status.
- Backup status.
- Evidence links.
- Manual health status first, live checks later.

Storage decision:

- Laptop dashboard can start before INFRA01 storage is ready.
- Raspberry Pi dashboard hosting should wait until microSD setup is complete.
- Write-heavy monitoring, logs, databases, and LocalOps Assistant support services should wait for a
  future SSD upgrade.

## INFRA01 Lifecycle Decision

Current role:

- `INFRA01` is a staged Raspberry Pi infrastructure node, not yet the main services host.
- It is safe for SSH practice, light network testing, portfolio sync validation, hardware/storage
  readiness, and carefully documented lightweight pilots.
- `LINUX01` remains the main Phase 12 learning and service-testing host.

Future role:

| Phase | Decision                                                                                                                     |
| ----- | ---------------------------------------------------------------------------------------------------------------------------- |
| 12    | Practice risky concepts on `LINUX01`; prepare `INFRA01` hardware/storage/SSH/static IP/Docker/Portainer before real services |
| 14    | Begin monitoring/dashboard visibility for `INFRA01` when useful                                                              |
| 18    | Promote `INFRA01` into the main always-on container/services host after SSD readiness                                        |
| 22    | Allow LocalOps Assistant to observe or manage `INFRA01` only after services are documented, monitored, and backed up         |

Storage plan:

- The 128GB microSD is useful as the boot/staging drive.
- Install the NVMe HAT, 1TB NVMe SSD, and active cooling before real services are placed on
  `INFRA01`.
- Important Docker data, logs, databases, repositories, and app state should live on SSD, not only
  microSD.

## Phase Completion Checklist

For each phase, record:

- Objective.
- Systems touched.
- Commands or UI steps used.
- Screenshots or other evidence.
- Validation results.
- Problems encountered.
- Root cause and fix.
- Rollback plan.
- Lessons learned.
- Interview relevance.

## Phase 11.8 Raspberry Pi Preparation

Date validated: 2026-06-30

| Subphase | Area                             | Status   | Notes                                                                                          |
| -------- | -------------------------------- | -------- | ---------------------------------------------------------------------------------------------- |
| 11.8.1   | Boot media preparation           | Complete | Raspberry Pi OS Lite 64-bit written to 128GB microSD                                           |
| 11.8.2   | Host identity                    | Complete | Hostname configured as `infra01`; user `michael` created                                       |
| 11.8.3   | SSH enablement                   | Complete | SSH enabled, active, and reachable after Wi-Fi connection                                      |
| 11.8.4   | Wi-Fi staging network            | Complete | `wlan0` connected with DHCP address `192.168.1.133/24`; gateway `192.168.1.254`                |
| 11.8.5   | Remote administration            | Complete | Windows workstation ping and SSH to `192.168.1.133` succeeded                                  |
| 11.8.6   | Baseline capture                 | Complete | Captured OS, kernel, architecture, network, route, disk, memory, uptime, and SSH service state |
| 11.8.7   | Update and reboot validation     | Complete | `apt update`, `apt upgrade`, reboot, and SSH reconnect succeeded                               |
| 11.8.8   | Future network/storage decisions | Complete | Documented staging IP, future `192.168.50.60` target, microSD risk, and future SSD upgrade     |

Key outcome:

- `INFRA01` is operational on the staging Wi-Fi network.
- Current IP is `192.168.1.133`.
- Future homelab production IP remains `192.168.50.60` when the Pi is moved into the
  `192.168.50.0/24` network.
- MicroSD is acceptable for early setup and light services; SSD should be added before write-heavy
  services.

## Phase 11.9 Enterprise Hardening And Environment Validation

Date started: 2026-06-30

Objective:

- Validate that the environment is stable before Phase 12.
- Clean DNS and management-plane issues.
- Confirm Windows remote administration, Linux SSH, Docker, Portainer, and INFRA01 baseline access.
- Document findings, fixes, rollback notes, and remaining risks.

### Windows Management DNS And WinRM Validation

| Check                           | Result                                                         |
| ------------------------------- | -------------------------------------------------------------- |
| DC01 management ping            | Pass                                                           |
| PRINT01 management ping         | Pass                                                           |
| DHCP01 management ping          | Pass                                                           |
| FILE01 management ping          | Initially failed because VM was powered off; passed after boot |
| LINUX01 management ping         | Pass                                                           |
| LINUX01 SSH `22`                | Pass                                                           |
| Portainer `9443`                | Pass                                                           |
| INFRA01 SSH `22`                | Pass                                                           |
| Windows server WinRM TCP `5985` | Pass                                                           |
| Windows server RDP TCP `3389`   | Fail/closed by design for now                                  |

DNS cleanup finding:

- Production DNS names temporarily returned extra NAT or management records.
- Management DNS names temporarily pointed at production IPs for some hosts.
- This broke or confused WinRM because the client could resolve the wrong path or hit SPN/trust
  mismatches.

DNS cleanup result:

| Name Type                 | Expected Result | Status  |
| ------------------------- | --------------- | ------- |
| `DC01.corp.local`         | `192.168.50.10` | Cleaned |
| `PRINT01.corp.local`      | `192.168.50.20` | Cleaned |
| `DHCP01.corp.local`       | `192.168.50.30` | Cleaned |
| `FILE01.corp.local`       | `192.168.50.40` | Cleaned |
| `LINUX01.corp.local`      | `192.168.50.50` | Cleaned |
| `dc01-mgmt.corp.local`    | `192.168.56.10` | Cleaned |
| `print01-mgmt.corp.local` | `192.168.56.20` | Cleaned |
| `dhcp01-mgmt.corp.local`  | `192.168.56.30` | Cleaned |
| `file01-mgmt.corp.local`  | `192.168.56.40` | Cleaned |
| `linux01-mgmt.corp.local` | `192.168.56.50` | Cleaned |

WinRM validation:

| Host      | Management Name           | Validation                                                            |
| --------- | ------------------------- | --------------------------------------------------------------------- |
| `DC01`    | `dc01-mgmt.corp.local`    | `Test-WSMan` passed; `Invoke-Command { hostname }` returned `DC01`    |
| `PRINT01` | `print01-mgmt.corp.local` | `Test-WSMan` passed; `Invoke-Command { hostname }` returned `PRINT01` |
| `DHCP01`  | `dhcp01-mgmt.corp.local`  | `Invoke-Command { hostname }` returned `DHCP01`                       |
| `FILE01`  | `file01-mgmt.corp.local`  | `Invoke-Command { hostname }` returned `FILE01`                       |

Client access-control note:

- The physical workstation `BigMike` uses narrow WinRM `TrustedHosts` entries for the lab management
  names.
- This is a scoped homelab workaround because the physical laptop is not using a clean Kerberos path
  to the management aliases.
- Do not use `TrustedHosts *`.

Remaining Phase 11.9 work:

- Re-check LINUX01 SSH hardening and update state. Complete; service health validated and updates
  noted as separate maintenance.
- Re-check Portainer and Docker service restart behavior. Complete; Docker, containerd, Portainer
  container, volume, network, and port `9443` validated.
- Re-check INFRA01 SSH, update state, and staging IP. Complete; SSH active, `192.168.1.133` stable,
  storage/memory healthy, packages up to date.
- Review Windows firewall/RDP decision. Complete; RDP remains closed by design and WinRM is the
  supported remote administration path.
- Confirm backup/snapshot/export state before Phase 12. Complete; VM snapshots created for the
  current stable state.
- Update network diagram or architecture notes if needed. Complete enough for Phase 11; network
  baseline updated with DNS and management validation.

### Linux, Docker, Portainer, And INFRA01 Health Validation

Date validated: 2026-06-30

| System    | Check                  | Result                                   |
| --------- | ---------------------- | ---------------------------------------- |
| `LINUX01` | SSH login from Windows | Pass                                     |
| `LINUX01` | `ssh.service`          | Active and enabled                       |
| `LINUX01` | `docker.service`       | Active and enabled                       |
| `LINUX01` | `containerd.service`   | Active and enabled                       |
| `LINUX01` | Portainer container    | Running                                  |
| `LINUX01` | Portainer volume       | `portainer_data` present                 |
| `LINUX01` | Portainer network      | `portainer_network` present              |
| `LINUX01` | Portainer HTTPS port   | `192.168.56.50:9443` passed from Windows |
| `INFRA01` | SSH login from Windows | Pass                                     |
| `INFRA01` | Hostname               | `infra01`                                |
| `INFRA01` | Staging Wi-Fi IP       | `192.168.1.133/24` on `wlan0`            |
| `INFRA01` | Root filesystem        | 118G total, 3.9G used, 109G available    |
| `INFRA01` | Memory                 | 7.9Gi total, about 7.6Gi available       |
| `INFRA01` | `ssh.service`          | Active and enabled                       |
| `INFRA01` | Package update state   | All packages up to date                  |

Finding:

- `LINUX01` login banner shows available Ubuntu updates. This should be handled as a scoped
  package-maintenance task, not mixed into the current validation sweep unless required for
  security.

### RDP, Snapshot, And Final Readiness Decisions

| Area                    | Decision                                                                                                                                                                                       |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Windows RDP             | Keep RDP `3389` closed by default. Use WinRM/PowerShell Remoting as the normal admin path. Use VirtualBox console or temporary documented RDP access only when GUI administration is required. |
| Windows WinRM           | Management FQDNs are validated and are the preferred path from `BigMike`.                                                                                                                      |
| VirtualBox snapshots    | Current stable VM snapshots have been created before moving toward Phase 12.                                                                                                                   |
| INFRA01 backup          | No microSD image backup captured yet; document as future backup work before hosting important services.                                                                                        |
| LINUX01 package updates | Available updates noted; handle as a deliberate maintenance change later.                                                                                                                      |
| INFRA01 network         | Keep staging Wi-Fi IP `192.168.1.133`; do not force `192.168.50.60` until connected to the lab production network.                                                                             |

Phase 11 final readiness:

- Core Windows management path validated.
- Linux administration host validated.
- Docker and Portainer baseline validated.
- Raspberry Pi `INFRA01` staged and documented.
- DNS production versus management naming cleaned up.
- Snapshot rollback point created.
- Phase 12 can begin after any optional package-maintenance task is scheduled.

## Pre-Phase 12 Portfolio Sync Utility

Date started: 2026-06-30

Objective:

- Manually sync the Windows `C:\Portfilio` folder to Linux hosts before Phase 12.
- Keep documentation, scripts, roadmaps, and project files available on `LINUX01` and later
  `INFRA01`.
- Avoid remote deletion until the workflow is trusted and explicitly approved.

Initial sync design:

| Item             | Value                                                                                      |
| ---------------- | ------------------------------------------------------------------------------------------ |
| Local source     | `C:\Portfilio`                                                                             |
| Primary target   | `linux01:/home/michael/Portfolio`                                                          |
| Secondary target | `michael@192.168.1.133:/home/michael/Portfolio`                                            |
| Script           | `PowerShell/Scripts/Sync-PortfolioToLinux.ps1`                                             |
| Delete behavior  | No remote deletes                                                                          |
| Exclusions       | `.git`, `node_modules`, virtual environments, caches, build outputs, logs, temporary files |

Validation target:

- Confirm files exist on Linux with `ls`.
- View Markdown with `cat`, `less`, or `nano`.
- Open the synced folder from Claude Code/Codex on Linux later.

Initial validation:

| Target             | Result                                                                                                         |
| ------------------ | -------------------------------------------------------------------------------------------------------------- |
| `LINUX01`          | Complete; `/home/michael/Portfolio` created and populated                                                      |
| `LINUX01` size     | About 15 MB after excluding large binaries, build outputs, caches, `.git`, `node_modules`, and temporary files |
| Linux file viewing | `README.md` and `PHASE_TRACKER.md` readable with shell tools                                                   |
| Exclusion check    | `.git`, `node_modules`, and `dist` excluded successfully                                                       |
| `INFRA01`          | Pending; SSH key authentication is not configured yet                                                          |

Next improvement:

- Add SSH key authentication to `INFRA01`, then run the same sync with `-IncludeInfra01`.

## Folder Targets

| Work Type                     | Primary Folder                                  |
| ----------------------------- | ----------------------------------------------- |
| Master plan and architecture  | `../Documentation/HomeLab/Architecture/`        |
| Server-specific evidence      | `../Documentation/Server_Documentation/<HOST>/` |
| Cross-server homelab evidence | `../Documentation/HomeLab/Servers/`             |
| Client workstation evidence   | `../Documentation/HomeLab/Clients/`             |
| Network evidence              | `../Documentation/HomeLab/Network/`             |
| SOPs                          | `../Documentation/HomeLab/SOPs/`                |
| Troubleshooting notes         | `../Documentation/TroubleShooting/`             |
| Diagrams                      | `../Documentation/Network_Diagrams/`            |

## Evidence Quality Bar

A phase is portfolio-ready only when someone else can answer:

1. What was built?
2. Why does it matter in a real company?
3. How was it validated?
4. What broke?
5. How was it fixed?
6. What skill does it prove?

## Phase 11.5 Linux Networking Validation

Date validated: 2026-06-29

| Subphase | Area                                      | Status   | Notes                                                                                                            |
| -------- | ----------------------------------------- | -------- | ---------------------------------------------------------------------------------------------------------------- |
| 11.5.1   | Management DNS records                    | Complete | Created and validated `*-mgmt.corp.local` records for DC01, PRINT01, DHCP01, FILE01, and LINUX01                 |
| 11.5.2   | LINUX01 interface mapping                 | Complete | Mapped `enp0s3` production, `enp0s8` NAT/internet, and `enp0s9` management                                       |
| 11.5.3   | Linux DNS routing/search domain           | Complete | Configured `corp.local` on production DNS path and prevented NAT DNS from owning `corp.local`                    |
| 11.5.4   | Enterprise DNS cleanup                    | Complete | Removed bad duplicate `DC01` and `LINUX01` A records; kept production records clean                              |
| 11.5.5   | Internal and management DNS validation    | Complete | Validated production, management, and internet DNS from LINUX01                                                  |
| 11.5.6   | Linux routing and connectivity validation | Complete | Validated production, management, NAT gateway, and internet paths; IPv4 is the operating standard for this phase |

Key design outcome:

- Production DNS names resolve to `192.168.50.0/24` server identities.
- Management DNS names resolve to `192.168.56.0/24` administration identities.
- LINUX01 uses `enp0s3` for production, `enp0s8` for NAT/internet, and `enp0s9` for management.
- The physical workstation uses DC01 DNS on the VirtualBox host-only management adapter for
  `corp.local` resolution.

## Phase 11.6 Docker Engine Baseline

Date started: 2026-06-30

| Subphase | Area                                | Status   | Notes                                                                                                            |
| -------- | ----------------------------------- | -------- | ---------------------------------------------------------------------------------------------------------------- |
| 11.6.1   | Pre-change host validation          | Complete | Confirmed SSH access, Ubuntu 24.04.4 LTS, user context, disk, memory, network, and current package state         |
| 11.6.2   | Docker install method selection     | Complete | Use Docker official apt repository for Ubuntu Noble; avoid convenience script for production-style documentation |
| 11.6.3   | Docker Engine installation          | Complete | Installed Docker Engine 29.6.1 from Docker official apt repository                                               |
| 11.6.4   | Docker service validation           | Complete | `docker.service` and `containerd.service` are active and enabled                                                 |
| 11.6.5   | Container runtime validation        | Complete | `docker version`, Compose plugin, `hello-world`, `docker info`, images, networks, and volumes validated          |
| 11.6.6   | Security and rollback documentation | Complete | Docker group privilege risk and rollback commands documented                                                     |

Pre-change findings:

- `LINUX01` is reachable with `ssh linux01`.
- Host OS is Ubuntu 24.04.4 LTS.
- Current user is `michael`.
- `michael` is in the `sudo` group, but non-interactive sudo requires a password.
- Docker CLI was not installed before the change.
- No Docker systemd unit files were listed before the change.
- `/` and `/var` have about 16G available, enough for baseline Docker testing.

Validated install findings:

- Docker Engine 29.6.1 is installed from Docker's official Ubuntu Noble repository.
- Docker Compose plugin v5.2.0 is installed.
- `docker.service` is active and enabled.
- `containerd.service` is active and enabled.
- `sudo docker run hello-world` completed successfully.
- `sudo docker info`, `sudo docker ps -a`, `sudo docker images`, `sudo docker network ls`, and
  `sudo docker volume ls` were captured.
- Non-root Docker API access is denied, which is expected until an explicit Docker access decision
  is made.

Success criteria:

- Docker Engine installed from a documented source. Complete.
- `docker.service` and `containerd.service` enabled and running. Complete.
- `docker version` and `docker compose version` pass. Complete.
- `hello-world` container runs successfully. Complete.
- Docker security and rollback notes are captured in `Linux/Docker/README.md`. Complete.
- `docker info`, `docker ps -a`, `docker images`, `docker network ls`, and `docker volume ls`
  captured with `sudo`. Complete.

Access-control decision:

- Docker remains sudo-only for now.
- `michael` has not been added to the `docker` group.
- This preserves a conservative privilege boundary while Docker fundamentals are being validated.

## Phase 11.7 Portainer

Date started: 2026-06-30

| Subphase | Area                                | Status   | Notes                                                                                                                 |
| -------- | ----------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------- |
| 11.7.1   | Scope confirmation                  | Complete | Master plan defines 11.7 as Portainer install, Docker management, and container administration                        |
| 11.7.2   | Deployment plan                     | Complete | Use Portainer CE on Docker Standalone with Docker Compose and HTTPS port `9443`                                       |
| 11.7.3   | Pre-change validation               | Complete | Captured Docker state, empty volumes, default networks, and listening ports before deployment; `9443` was free        |
| 11.7.4   | Portainer deployment                | Complete | Deployed `portainer/portainer-ce:sts` with persistent `portainer_data` volume                                         |
| 11.7.5   | Web UI validation                   | Complete | Validated `https://192.168.56.50:9443` from the management workstation                                                |
| 11.7.6   | Container administration evidence   | Complete | Confirmed local Docker environment visibility, running Portainer container, volume, network, and Docker version       |
| 11.7.7   | Security and rollback documentation | Complete | Documented Docker socket risk, admin password handling, management-only access, setup token sensitivity, and rollback |

Success criteria:

- Portainer container is running and set to restart automatically. Complete.
- Portainer data persists in the `portainer_data` Docker volume. Complete.
- Only HTTPS port `9443` is exposed to the host for Phase 11.7. Complete.
- Windows workstation can reach `192.168.56.50:9443`. Complete.
- Initial Portainer admin setup and admin login completed. Complete.
- Local Docker environment is visible in Portainer. Complete.
- Docker socket privilege risk is documented. Complete.
- Rollback steps are documented. Complete.

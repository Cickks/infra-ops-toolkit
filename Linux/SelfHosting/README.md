# Phase 12 Self-Hosting

Purpose: plan and document Phase 12 self-hosted services without skipping the Linux operations work
those services depend on.

## Phase 12 Mission

Build `LINUX01` into an internal services host while practicing enterprise administration:

- Change planning.
- Package and service management.
- Firewall and port validation.
- Storage paths and permissions.
- Logs and troubleshooting.
- Backups and restore testing.
- Rollback planning.

## Phase 12.0A Readiness Decision

Date validated: 2026-07-05

`LINUX01` passed the Phase 12.0A baseline validation needed before beginning the first
shared-service build.

Validated:

- SSH management reachability to `192.168.56.50:22` from the Windows workstation.
- Portainer management reachability to `192.168.56.50:9443` from the Windows workstation.
- Linux identity, network, storage, mount, and `/etc/fstab` review.
- SSH, Docker, containerd, Docker inventory, Docker volumes, and Docker networks.

Decision:

- Proceed next to a controlled Phase 12.1 Samba baseline change on `LINUX01`.
- Keep package updates separate from the Samba change.
- Keep `INFRA01` out of important service hosting until storage, Docker data placement, backups,
  monitoring expectations, and rollback are documented.

## Phase 12 Package Maintenance Gate

Date performed: 2026-07-06 UTC

Before Samba installation, `LINUX01` package maintenance was run as a separate change.

Result:

- `sudo apt update` completed.
- `sudo apt upgrade` upgraded 58 packages and installed 7 new kernel-related packages.
- New kernel `6.8.0-134-generic` installed.
- Running kernel remains `6.8.0-124-generic` until reboot.
- `fwupd` was deferred by phased updates.
- `fwupd.service` failed during automatic restart and requires post-reboot review.
- Samba remains uninstalled; candidate version is `2:4.19.5+dfsg-4ubuntu9.6`.
- No listeners were shown on TCP `445` or `139`.

Decision:

- Reboot and validate before installing Samba.
- Do not mix Samba installation with unresolved package-maintenance validation.

Post-reboot result:

Date validated: 2026-07-06 UTC

- Reboot completed and SSH login from `192.168.56.1` succeeded.
- Running kernel is now `6.8.0-134-generic`.
- `ssh.service`, `docker.service`, and `containerd.service` are active.
- Docker Compose reports `v5.3.0`.
- Portainer container is running and publishing `9443/tcp`.
- `fwupd` remains listed as an upgradable phased package and is a non-blocking follow-up.

Decision:

- LINUX01 is ready to proceed to Phase 12.1 Samba baseline.

## Service Order

| Order | Area          | Reason                                                                    |
| ----- | ------------- | ------------------------------------------------------------------------- |
| 1     | Samba         | Teaches SMB interoperability with Windows clients and permissions mapping |
| 2     | NFS           | Teaches Linux-to-Linux storage and future container/storage patterns      |
| 3     | Cron          | Teaches scheduled maintenance, reporting, and recurring operations        |
| 4     | systemd       | Teaches service lifecycle, boot behavior, logs, and unit-file discipline  |
| 5     | SSH keys      | Complete; reliable admin access to `INFRA01` and sync workflow validated  |
| 6     | Linux backups | Complete; config and small service-data backup with restore test passed   |
| 7     | First app     | Adds a real internal app after rollback and backup paths exist            |

## First App Decision

Recommended first candidates:

| App            | Recommendation                | Why                                                                                                           |
| -------------- | ----------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Gitea          | Strong candidate              | Practical portfolio value; teaches web app hosting, persistence, backups, updates, and internal Git workflows |
| Vaultwarden    | Strong candidate with caution | High real-world value; requires careful secrets handling and backup discipline                                |
| Nextcloud      | Later                         | Storage-heavy and backup-sensitive; better after Linux backup confidence improves                             |
| Jellyfin       | Later                         | Useful but less aligned with immediate sysadmin interview evidence                                            |
| Home Assistant | Later                         | Best when there is a clear hardware or automation goal                                                        |

Default recommendation: build Gitea first after the Phase 12 Linux basics are complete.

## Standard Change Template

For each service, record:

- Objective.
- Host.
- Date.
- Packages installed.
- Config files changed.
- Ports opened.
- Users and groups created.
- Storage paths.
- Validation commands.
- Logs reviewed.
- Rollback steps.
- Backup/restore status.
- Troubleshooting notes.
- Interview relevance.

## Guardrails

- Keep services internal to the lab.
- Prefer management-network access for administration.
- Do not expose services directly to the internet.
- Do not commit secrets, admin passwords, database passwords, tokens, SSH private keys, or backup
  archives.
- Do not host important or write-heavy data on `INFRA01` microSD without a backup image and restore
  plan.

## Phase 12 Success Criteria

- Samba validated from a Windows client. Complete on 2026-07-06.
- NFS validated from a Linux client.
- At least one cron job runs and logs successfully.
- At least one custom systemd service starts, stops, restarts, enables, and logs correctly.
- SSH key auth works to `INFRA01`. Complete on 2026-07-07.
- Linux config and service data backup runs successfully. Complete on 2026-07-07.
- At least one restore test is completed. Complete on 2026-07-07.
- One first self-hosted app is selected with a documented change plan.

## Phase 12.5 SSH Key Expansion

Date validated: 2026-07-07

Objective:

- Expand reliable SSH administration to `INFRA01` without starting full `INFRA01` production
  readiness.
- Validate a safe portfolio sync workflow for documentation availability.

Validation:

- `INFRA01` staging IP `192.168.1.133` responded on TCP `22` from Windows source `192.168.1.182`.
- Password SSH worked before key changes.
- Public key authentication was added and validated with BatchMode SSH.
- Windows SSH alias `infra01` was validated.
- SCP transfer, remote readback, and cleanup succeeded.
- Portfolio sync to `INFRA01` succeeded with:

```powershell
& "C:\Portfilio\IT-ENGINEER-TOOLKIT\PowerShell\Scripts\Sync-PortfolioToLinux.ps1" -Targets infra01 -NoRsync
```

Result:

- `/home/michael/Portfolio` on `INFRA01` reported `22M` after sync.
- Remote sync used create/update behavior only.
- `-DeleteRemote` was not used.

Boundary:

- No Docker, Portainer, NVMe, static production IP, service hosting, or storage changes were made on
  `INFRA01`.

## Phase 12.6 Linux Backup And Restore Validation

Date validated: 2026-07-07

Objective:

- Create a local backup of important `LINUX01` configuration and small service data.
- Validate archive integrity and prove restore to a temporary non-production location.

Backup scope:

- `/etc`
- `/srv`
- `/opt/homelab`
- `/var/log/homelab`

Result:

- Backup archive: `/var/backups/homelab/phase12-6/linux01-config-service-20260707-215146.tar.gz`
- Archive size: `653K`.
- Manifest size: `56K`.
- Archive entries: `1801`.
- SHA256 validation returned `OK`.
- Restore test path: `/tmp/phase12-6-restore-test`.
- Temporary restore content was removed after validation.

Restore checks passed:

- Samba config restored.
- NFS exports restored.
- Cron health-report file restored.
- Custom systemd unit restored.
- `/srv`, `/opt/homelab`, and `/var/log/homelab` content restored.

Post-change validation:

- Root filesystem remained at `35%` used with about `15G` available.
- `ssh`, `docker`, `containerd`, `smbd`, `nfs-server`, `cron`, and
  `linux01-systemd-heartbeat.service` remained active.

Limitation:

- This is a local backup proof-of-process. It does not replace off-host disaster recovery.

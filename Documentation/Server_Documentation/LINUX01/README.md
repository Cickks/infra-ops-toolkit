# LINUX01

Role: Linux administration fundamentals host and current Phase 11 focus.

## Portfolio Status

| Item           | Status                                                                                                                                                                                      |
| -------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Phase          | 12                                                                                                                                                                                          |
| Area           | Advanced Linux and self-hosting                                                                                                                                                             |
| Evidence state | Phase 11 complete; Phase 12 kickoff active                                                                                                                                                  |
| Related docs   | `../../../Linux/Documentation/README.md`, `../../../Linux/Docker/README.md`, `../../../Linux/Portainer/README.md`, `../../../Linux/SelfHosting/README.md`, `../../../docs/PHASE_TRACKER.md` |

## Notes

- This host should prove Linux fundamentals before moving deeper into Docker, monitoring, security,
  and automation.
- Start with baseline identity, hostname, network, package, service, storage, user, permission, and
  SSH evidence.
- Keep screenshots and command summaries redacted and dated.

## Phase 11.4.8 SSH Troubleshooting Validation

Date validated: 2026-06-29

Management network SSH is confirmed working.

| Check                                         | Result |
| --------------------------------------------- | ------ |
| Ping `192.168.56.50` from Windows             | Pass   |
| TCP port `22` from Windows to `192.168.56.50` | Pass   |
| `ssh linux01` from Windows                    | Pass   |
| `ssh.service` active/running                  | Pass   |
| `ssh.service` enabled at boot                 | Pass   |
| SSH listening on port `22`                    | Pass   |
| `/var/log/auth.log` reviewed                  | Pass   |

Validated commands:

```powershell
ping 192.168.56.50
Test-NetConnection 192.168.56.50 -Port 22
ssh linux01
```

```bash
sudo systemctl status ssh
sudo ss -tulpn | grep ':22'
sudo tail -n 50 /var/log/auth.log
```

Findings:

- SSH administration works over the management network at `192.168.56.50`.
- Public key authentication succeeded from Windows source `192.168.56.1`.
- The SSH client alias `linux01` works for SSH.
- `ping linux01` from PowerShell does not currently resolve through DNS.
- Production IP `192.168.50.50` is not currently reachable from the Windows host.
- The login banner showed NAT interface address `10.0.3.15`.

Next action:

- Move remaining name resolution and production-network reachability work into Phase 11.5 Linux
  Networking.

## Useful Commands

Run on `LINUX01`:

```bash
hostnamectl
uname -a
cat /etc/os-release
ip addr
ip route
resolvectl status
df -h
lsblk
free -h
uptime
whoami
id
getent passwd
getent group
systemctl --type=service --state=running
systemctl status ssh
sudo journalctl -xe --no-pager | tail -50
sudo apt update
apt list --upgradable
```

SSH validation from the workstation:

```powershell
ssh <user>@<LINUX01-IP>
ssh linux01
ssh -V
Test-NetConnection 192.168.56.50 -Port 22
```

## Validation Checklist

- Confirm hostname is `LINUX01`.
- Confirm OS/version is documented.
- Confirm IP address, gateway, and DNS.
- Confirm SSH service status.
- Confirm SSH listener on TCP port `22`.
- Confirm SSH authentication logs show successful login.
- Confirm administrative user and group membership.
- Confirm package update workflow.
- Confirm disk and memory baseline.

## Evidence To Capture

- `hostnamectl` output.
- `/etc/os-release` output.
- `ip addr` and route summary.
- SSH login screenshot or command summary.
- Service status for SSH.
- Port `22` listener output.
- `/var/log/auth.log` login evidence.
- Package update summary.

## Rollback

- Revert network changes from backup config.
- Restore SSH config from a copied known-good file.
- Revert package changes when possible.
- Restore VM snapshot for unrecoverable system misconfiguration.

## Interview Relevance

This proves Linux CLI comfort, service management, networking basics, SSH administration, and
disciplined evidence capture.

## Phase 12 Advanced Linux And Self-Hosting Kickoff

Date started: 2026-06-30

Objective:

- Use `LINUX01` as the controlled Phase 12 services host.
- Build Linux shared-service, automation, service-management, and backup skills before installing
  heavier self-hosted apps.
- Keep access scoped to the management and internal lab networks.

Starting assumptions:

| Item                       | Value                                        |
| -------------------------- | -------------------------------------------- |
| Production IP              | `192.168.50.50`                              |
| Management IP              | `192.168.56.50`                              |
| NAT IP                     | `10.0.3.15`                                  |
| SSH management path        | `ssh linux01` or `ssh michael@192.168.56.50` |
| Current container baseline | Docker and Portainer validated               |
| Rollback state             | Stable VM snapshot exists from Phase 11.9    |

Phase 12 order of operations:

1. Confirm snapshot and package-maintenance readiness.
2. Build a Samba lab share and validate from Windows.
3. Build an NFS lab export and validate from Linux.
4. Create cron-based maintenance or report jobs.
5. Create a simple custom systemd service.
6. Expand SSH key authentication to `INFRA01`.
7. Create Linux backup jobs and perform at least one restore test.
8. Choose the first self-hosted app after the backup path is proven.

Evidence to capture:

- Change ticket or change notes for each service.
- Packages installed and versions.
- Config file locations.
- Firewall/listening-port validation.
- Client access test.
- Log review.
- Rollback commands.
- Screenshot or command evidence.
- Interview relevance.

Guardrails:

- Do not expose self-hosted services to the internet in Phase 12.
- Do not put secrets in Git.
- Do not store important service data only on `INFRA01` microSD.
- Do not deploy multiple apps before backups and restore testing are documented.

## Phase 12.0A LINUX01 Baseline Validation

Date validated: 2026-07-05

Objective:

- Confirm `LINUX01` remains safe to use as the Phase 12 practice and staging host before starting
  Samba, NFS, cron, systemd, SSH key expansion, backups, or first-app work.
- Validate the management plane, service plane, storage view, Docker inventory, and Portainer
  reachability without making configuration changes.

Systems affected:

| System              | Role                                     |
| ------------------- | ---------------------------------------- |
| `LINUX01`           | Phase 12 Linux practice and staging host |
| Windows workstation | Management client at `192.168.56.1`      |

Validated evidence:

| Check                                            | Result                                                        |
| ------------------------------------------------ | ------------------------------------------------------------- |
| SSH management TCP test to `192.168.56.50:22`    | Pass                                                          |
| Portainer TCP test to `192.168.56.50:9443`       | Pass                                                          |
| Source address for management tests              | `192.168.56.1`                                                |
| `ssh.service` review                             | Captured in terminal validation                               |
| `docker.service` and `containerd.service` review | Captured in terminal validation                               |
| Docker inventory review                          | `docker info`, container, volume, and network checks captured |
| Storage and mount review                         | `lsblk`, `df`, `findmnt`, and `/etc/fstab` review captured    |

Result:

- Phase 12.0A baseline validation is good enough to proceed toward the next planned Phase 12 service
  task.
- `LINUX01` remains the correct host for risky practice before applying storage, Docker, networking,
  or service changes to `INFRA01`.
- Package maintenance remains a separate planned change and should not be mixed into the first
  Samba/NFS service build.

Next action:

- Prepare a controlled change for Phase 12.1 Samba baseline on `LINUX01`.
- Keep `INFRA01` in staging until SSD storage, Docker data placement, backups, monitoring, and
  rollback are documented.

Rollback:

- No rollback required because this validation was read-only.
- If future service changes fail, revert the affected package/configuration or restore the Phase
  11.9 stable VM snapshot.

Interview relevance:

- This demonstrates production-style readiness validation before adding services to a Linux host.
- The process separates management access, service access, storage readiness, and
  application/runtime state instead of treating "the server is up" as enough evidence.

## Phase 12.0A Package Maintenance Before Samba

Date performed: 2026-07-06 UTC

Objective:

- Apply pending Ubuntu package updates before beginning the Phase 12.1 Samba service change.
- Keep package maintenance separate from Samba installation so any service issue can be troubleshot
  cleanly.

Pre-change evidence:

| Check                            | Result                                        |
| -------------------------------- | --------------------------------------------- |
| SSH login from Windows           | Pass; login from `192.168.56.1`               |
| Hostname                         | `linux01`                                     |
| OS before reboot                 | Ubuntu 24.04.4 LTS                            |
| Running kernel before reboot     | `6.8.0-124-generic`                           |
| Root filesystem before upgrade   | 24G total, 7.2G used, 16G available, 33% used |
| SSH service                      | Active and enabled                            |
| Available updates before upgrade | 59 packages                                   |

Maintenance performed:

- Ran `sudo apt update`.
- Ran `sudo apt upgrade`.
- Upgraded 58 packages and installed 7 new kernel-related packages.
- One package, `fwupd`, was deferred by Ubuntu phased updates.
- Docker Compose plugin upgraded from `v5.2.0` to `5.3.0-1~ubuntu.24.04~noble`.
- New kernel `6.8.0-134-generic` was installed.

Important findings:

- A reboot is required because the running kernel is still `6.8.0-124-generic` while the expected
  installed kernel is `6.8.0-134-generic`.
- `fwupd.service` failed during automatic service restart and needs post-reboot review.
- Some user/session binaries were reported as outdated until logout/reboot.
- No containers needed restart according to the upgrade output.

Samba pre-check:

| Check                                    | Result                          |
| ---------------------------------------- | ------------------------------- |
| `apt policy samba` installed state       | `(none)`                        |
| Samba candidate                          | `2:4.19.5+dfsg-4ubuntu9.6`      |
| Existing listeners on TCP `445` or `139` | None shown by `ss -tulpn` check |

Current decision:

- Do not install Samba until `LINUX01` is rebooted and post-reboot validation passes.
- Treat the package-maintenance change as complete only after validating SSH, kernel version,
  Docker, Portainer, and `fwupd.service`.

Post-reboot validation commands:

```bash
hostnamectl
uname -r
df -h
systemctl status ssh --no-pager
systemctl status docker --no-pager
systemctl status containerd --no-pager
systemctl status fwupd --no-pager
docker compose version
sudo docker ps
sudo docker volume ls
sudo docker network ls
apt list --upgradable
```

Windows validation after reboot:

```powershell
Test-NetConnection 192.168.56.50 -Port 22
Test-NetConnection 192.168.56.50 -Port 9443
```

Rollback:

- If the host fails to boot cleanly, use the VirtualBox console and boot the previous kernel
  `6.8.0-124-generic` from GRUB advanced options.
- If services fail after reboot, troubleshoot one service at a time using `systemctl status` and
  `journalctl -xeu <service>`.
- Restore the Phase 11.9 stable VM snapshot only if boot or service recovery fails.

Post-reboot validation:

Date validated: 2026-07-06 UTC

| Check                        | Result                                                 |
| ---------------------------- | ------------------------------------------------------ |
| SSH login after reboot       | Pass; login from `192.168.56.1`                        |
| Running kernel               | `6.8.0-134-generic`                                    |
| `ssh.service`                | Active and enabled                                     |
| `docker.service`             | Active and enabled                                     |
| `containerd.service`         | Active and enabled                                     |
| `fwupd.service`              | Loaded/static; inactive/dead after reboot              |
| Docker Compose version       | `v5.3.0`                                               |
| Portainer container          | Running; up about 2 minutes after reboot               |
| Portainer published port     | `0.0.0.0:9443->9443/tcp` and `[::]:9443->9443/tcp`     |
| Remaining upgradable package | `fwupd` listed as upgradable because of Ubuntu phasing |

Decision after reboot:

- Package-maintenance gate is closed for Phase 12.1 purposes.
- `fwupd` remains a non-blocking follow-up because it is still phased and not part of the Samba
  service path.
- `LINUX01` is ready to begin the controlled Phase 12.1 Samba baseline change.

## Phase 12.1 Samba Pre-Change Validation

Date validated: 2026-07-06 UTC

| Check                       | Result                                                    |
| --------------------------- | --------------------------------------------------------- |
| Hostname                    | `linux01`                                                 |
| OS                          | Ubuntu 24.04.4 LTS                                        |
| Kernel                      | `6.8.0-134-generic`                                       |
| Disk baseline               | 24G total, 7.6G used, 15G available, 34% used             |
| SSH service                 | Active and enabled                                        |
| Samba installed state       | `(none)`                                                  |
| Samba candidate version     | `2:4.19.5+dfsg-4ubuntu9.6`                                |
| TCP `445` / `139` pre-check | No listeners shown                                        |
| Change marker               | `/root/phase12-backups/phase12-1-samba-start.txt` created |

Decision:

- Pre-change validation passed.
- Proceed next to Samba package installation.

## Phase 12.1 Samba Package Installation

Date validated: 2026-07-06 UTC

| Check          | Result                                                                                          |
| -------------- | ----------------------------------------------------------------------------------------------- |
| Samba version  | `4.19.5-Ubuntu`                                                                                 |
| `smbd.service` | Active, running, enabled                                                                        |
| `nmbd.service` | Active, running, enabled                                                                        |
| TCP `139`      | Listening on IPv4 and IPv6                                                                      |
| TCP `445`      | Listening on IPv4 and IPv6                                                                      |
| Noted warning  | `Referenced but unset environment variable ...OPTIONS`; non-blocking while services are healthy |

Decision:

- Samba package installation is successful.
- Next step is to back up `/etc/samba/smb.conf`, then create the controlled `linux_shared` share.

## Phase 12.1 Samba Config Backup And Share Directory

Date validated: 2026-07-06 UTC

| Check                          | Result                                                   |
| ------------------------------ | -------------------------------------------------------- |
| Samba config backup            | `/root/phase12-backups/smb.conf.pre-phase12-1`           |
| Backup owner/group             | `root:root`                                              |
| Backup size                    | 8917 bytes                                               |
| `testparm` before custom share | Loaded services file OK                                  |
| Samba server role              | `ROLE_STANDALONE`                                        |
| Share path                     | `/srv/samba/linux_shared`                                |
| Share group                    | `linuxshare`                                             |
| User added to group            | `michael`                                                |
| Share directory permissions    | `drwxrws---`, mode `2770`, owner/group `root:linuxshare` |

Decision:

- Baseline config backup and filesystem permissions are ready.
- Next step is adding the `[linux_shared]` share block to `/etc/samba/smb.conf`.

## Phase 12.1 Samba Share Config And Restart

Date validated: 2026-07-06 UTC

| Check             | Result                                                                                          |
| ----------------- | ----------------------------------------------------------------------------------------------- |
| Share block       | `[linux_shared]` present in `testparm` output                                                   |
| Share path        | `/srv/samba/linux_shared`                                                                       |
| Valid users       | `@linuxshare`                                                                                   |
| Force group       | `linuxshare`                                                                                    |
| Create mask       | `0660`                                                                                          |
| Directory mask    | `02770`                                                                                         |
| Read-only setting | `No`                                                                                            |
| Service restart   | `smbd` and `nmbd` restarted                                                                     |
| `smbd.service`    | Active, running, enabled                                                                        |
| `nmbd.service`    | Active, running, enabled                                                                        |
| Noted warning     | `Referenced but unset environment variable ...OPTIONS`; non-blocking while services are healthy |

Decision:

- Samba share configuration and service restart passed.
- Next step is Samba authentication and Windows client validation.

## Phase 12.1 Samba Authentication And Windows Mapping

Date validated: 2026-07-06 UTC

| Check                   | Result                                                                      |
| ----------------------- | --------------------------------------------------------------------------- |
| Samba account created   | `michael` added with `smbpasswd`; password not documented                   |
| Samba account enabled   | `michael` enabled                                                           |
| Samba account listing   | `michael:1000:Michael Painter`                                              |
| Local Samba client tool | `smbclient` was missing, then installed                                     |
| Windows share mapping   | `net use \\192.168.56.50\linux_shared /user:michael` completed successfully |

Decision:

- Samba authentication and Windows mapping passed.
- Final proof requires file create/read/delete validation through the share.

## Phase 12.1 Samba Server-Side Validation

Date validated: 2026-07-06 UTC

| Check                     | Result                                                                          |
| ------------------------- | ------------------------------------------------------------------------------- |
| Share path                | `/srv/samba/linux_shared`                                                       |
| Directory owner/group     | `root:linuxshare`                                                               |
| Directory permissions     | `drwxrws---`                                                                    |
| Post-test directory state | No test file remained after deletion                                            |
| Samba log review          | `log.smbd` showed normal startup entries and no obvious displayed access errors |

Decision:

- Server-side validation is healthy.
- Need Windows create/read/delete command output before closing Phase 12.1 as complete.

## Phase 12.1 Samba Baseline Complete

Date completed: 2026-07-06 UTC

| Check                        | Result                                                             |
| ---------------------------- | ------------------------------------------------------------------ |
| Windows file create          | Passed using `\\192.168.56.50\linux_shared\phase12-samba-test.txt` |
| Windows file read            | Passed with `type` command                                         |
| Windows file delete          | Passed with `del` command                                          |
| Server-side cleanup          | Test file no longer present                                        |
| Share permissions after test | `root:linuxshare`, `drwxrws---`                                    |
| Samba logs                   | No obvious displayed access errors                                 |

Result:

- Phase 12.1 Samba baseline is complete.
- `LINUX01` hosts the internal `linux_shared` SMB share.
- Windows client access, Samba authentication, write/read/delete, and server-side cleanup were
  validated.

Operational guardrail:

- Keep the share internal to the lab.
- Do not expose SMB to the internet.
- Continue using group-based access through `linuxshare`.

## Phase 12.2 NFS Pre-Change Validation

Date validated: 2026-07-06 UTC

| Check                                             | Result                                        |
| ------------------------------------------------- | --------------------------------------------- |
| Hostname                                          | `linux01`                                     |
| OS                                                | Ubuntu 24.04.4 LTS                            |
| Kernel                                            | `6.8.0-134-generic`                           |
| Root filesystem                                   | 24G total, 7.7G used, 15G available, 35% used |
| SSH service                                       | Active and enabled                            |
| Windows management TCP test to `192.168.56.50:22` | Pass from source `192.168.56.1`               |
| `nfs-kernel-server` installed state               | `(none)`                                      |
| `nfs-kernel-server` candidate version             | `1:2.6.4-3ubuntu5.1`                          |
| Existing TCP/UDP `2049` or `111` listeners        | None shown in pre-change check                |

Decision:

- Pre-change validation passed.
- Phase 12.2 NFS baseline is started.
- Next step is installing NFS packages and creating a controlled internal export under
  `/srv/nfs/linux_shared`.

## Phase 12.2 NFS Baseline Complete

Date completed: 2026-07-06 UTC

Objective:

- Build a controlled internal NFS export on `LINUX01`.
- Validate package installation, service state, export configuration, port reachability, client
  mount behavior, file operations, cleanup, and rollback notes.

Validated implementation:

| Check                                     | Result                                                                               |
| ----------------------------------------- | ------------------------------------------------------------------------------------ |
| `nfs-kernel-server`                       | Installed, version `1:2.6.4-3ubuntu5.1`                                              |
| `nfs-common`                              | Installed, version `1:2.6.4-3ubuntu5.1`                                              |
| `nfs-server`                              | Active and enabled                                                                   |
| NFS export path                           | `/srv/nfs/linux_shared`                                                              |
| Export client scope                       | `192.168.56.0/24`                                                                    |
| Export config backup                      | `/root/phase12-backups/exports.pre-phase12-2`                                        |
| Export directory owner/group              | `nobody:nogroup`                                                                     |
| Export directory permissions              | `drwxrwsr-x`, mode `2775`                                                            |
| TCP `2049` from Windows management source | Pass                                                                                 |
| TCP `111` from Windows management source  | Pass                                                                                 |
| `sudo exportfs -v`                        | Export active for `192.168.56.0/24`; `root_squash` shown                             |
| `showmount -e localhost`                  | `/srv/nfs/linux_shared 192.168.56.0/24`                                              |
| Client mount test                         | `192.168.56.50:/srv/nfs/linux_shared` mounted to `/mnt/nfs-linux-shared` with `nfs4` |
| File create/read/delete                   | Passed using `phase12-nfs-test.txt`                                                  |
| Unmount                                   | Passed; test mount removed                                                           |
| Server-side cleanup                       | No test file remained under `/srv/nfs/linux_shared`                                  |

Operational finding:

- `nfs-server` initially logged `exportfs: can't open /etc/exports for reading` because
  `/etc/exports` did not exist before the export configuration step.
- The issue was resolved by creating `/etc/exports`, backing it up, adding the controlled export,
  and reloading exports with `sudo exportfs -ra`.
- After client unmount, `nfsd on /proc/fs/nfsd` can remain visible because it is the server
  pseudo-filesystem, not the client test mount.

Result:

- Phase 12.2 NFS baseline is complete.
- `LINUX01` now provides an internal NFS export for Linux storage practice.

## Phase 12.3 Cron Baseline Complete

Date validated: 2026-07-06

Objective:

- Create a safe scheduled health-report job on `LINUX01`.
- Prove the script works manually before scheduling it.
- Validate cron execution with a temporary short interval.
- Change the final schedule to a daily production-style cadence.

Pre-change validation:

| Check           | Result                                        |
| --------------- | --------------------------------------------- |
| Hostname        | `linux01`                                     |
| OS              | Ubuntu 24.04.4 LTS                            |
| Kernel          | `6.8.0-134-generic`                           |
| Time sync       | Enabled                                       |
| NTP service     | Active                                        |
| Root filesystem | 24G total, 7.7G used, 15G available, 35% used |
| Memory          | 3.8Gi total, about 3.3Gi available            |
| Cron service    | Active and enabled                            |
| User crontab    | No crontab for `michael`                      |

Implemented artifacts:

| Artifact  | Path                                            |
| --------- | ----------------------------------------------- |
| Script    | `/opt/homelab/scripts/linux01-health-report.sh` |
| Log file  | `/var/log/homelab/linux01-health-report.log`    |
| Cron file | `/etc/cron.d/linux01-health-report`             |

Validated behavior:

- Script syntax check passed with `sudo bash -n`.
- Manual execution appended a health report to `/var/log/homelab/linux01-health-report.log`.
- Temporary validation schedule ran every 5 minutes.
- Cron logs showed `/opt/homelab/scripts/linux01-health-report.sh` executed automatically at
  `04:30:01`.
- Final schedule changed to daily at `06:15 UTC`.
- Cron file ownership is `root:root`.
- Cron file mode is `0644`.

Final cron entry:

```cron
# Phase 12.3 - LINUX01 daily health report
# Runs daily at 06:15 UTC.
15 6 * * * root /opt/homelab/scripts/linux01-health-report.sh
```

Rollback:

- Remove `/etc/cron.d/linux01-health-report`.
- Confirm cron remains active with `systemctl status cron --no-pager`.
- Check recent cron logs with `journalctl -u cron --since "15 minutes ago" --no-pager`.
- Optionally remove the script and log file if the job is fully retired.

Operational result:

- Phase 12.3 cron baseline is complete.
- `LINUX01` now has a documented scheduled health-report job.
- Phase 12.4 custom systemd service is the next planned Phase 12 task.
- The service remains internal to the lab management subnet and must not be exposed to the internet.

Rollback:

- Unmount any clients using the export.
- Remove or comment out the `/srv/nfs/linux_shared` line in `/etc/exports`.
- Run `sudo exportfs -ra`.
- Stop and disable `nfs-server` if the service must be removed from the host.
- Restore `/root/phase12-backups/exports.pre-phase12-2` if the export file must be reverted.

## Phase 12.4 Custom systemd Service Complete

Date validated: 2026-07-07 UTC

Objective:

- Create a simple custom `systemd` service on `LINUX01`.
- Validate service account usage, unit-file syntax, service lifecycle controls, logging, enablement,
  and reboot persistence.

Implemented artifacts:

| Artifact        | Path / Value                                             |
| --------------- | -------------------------------------------------------- |
| Service account | `homelabsvc`                                             |
| Script          | `/opt/homelab/scripts/linux01-systemd-heartbeat.sh`      |
| Unit file       | `/etc/systemd/system/linux01-systemd-heartbeat.service`  |
| Service name    | `linux01-systemd-heartbeat.service`                      |
| Log file        | `/var/log/homelab/systemd/linux01-systemd-heartbeat.log` |

Validated behavior:

- Script syntax check passed.
- Script ran successfully as `homelabsvc`.
- `systemd-analyze verify` passed.
- `systemctl start`, `restart`, `stop`, and `enable` were validated.
- `systemctl is-enabled` returned `enabled`.
- `systemctl is-active` returned `active`.
- Journald captured service startup and heartbeat output.
- File logging wrote heartbeat entries.
- After reboot, the service started automatically and remained active.

Operational result:

- Phase 12.4 is complete.
- `LINUX01` now has a documented custom service-management training artifact.
- No new network ports were opened.
- No Docker, Samba, NFS, SSH, cron, storage, or `INFRA01` settings were changed.

Rollback:

```bash
sudo systemctl disable --now linux01-systemd-heartbeat.service
sudo rm /etc/systemd/system/linux01-systemd-heartbeat.service
sudo systemctl daemon-reload
sudo systemctl reset-failed
sudo rm /opt/homelab/scripts/linux01-systemd-heartbeat.sh
sudo rm -f /var/log/homelab/systemd/linux01-systemd-heartbeat.log
```

## Phase 12.6 Linux Backup And Restore Validation Complete

Date validated: 2026-07-07 UTC

Objective:

- Create and validate a local backup of `LINUX01` configuration and small service data before moving
  toward the first real self-hosted app decision.

Backup artifact:

| Item          | Value                                                                                   |
| ------------- | --------------------------------------------------------------------------------------- |
| Archive       | `/var/backups/homelab/phase12-6/linux01-config-service-20260707-215146.tar.gz`          |
| Checksum file | `/var/backups/homelab/phase12-6/linux01-config-service-20260707-215146.tar.gz.sha256`   |
| Manifest file | `/var/backups/homelab/phase12-6/linux01-config-service-20260707-215146.tar.gz.manifest` |
| Archive size  | `653K`                                                                                  |
| Entry count   | `1801`                                                                                  |

Backup scope:

- `/etc`
- `/srv`
- `/opt/homelab`
- `/var/log/homelab`

Restore validation:

- Restored selected files and directories to `/tmp/phase12-6-restore-test`.
- Confirmed Samba config, NFS exports, cron file, and custom systemd unit were present.
- Confirmed `/srv`, `/opt/homelab`, and `/var/log/homelab` content restored.
- `sha256sum -c` returned `OK`.
- Temporary restore directory was removed after validation.

Post-change validation:

- Root filesystem remained `35%` used with about `15G` available.
- `ssh`, `docker`, `containerd`, `smbd`, `nfs-server`, `cron`, and
  `linux01-systemd-heartbeat.service` remained active.

Operational result:

- Phase 12.6 is complete as a local backup and restore proof.
- Off-host backup copy and retention remain future maturity work before heavier applications.

## Phase 11.5 Linux Networking Validation

Date validated: 2026-06-29

Interface map:

| Interface | Network      | Address                 | Purpose                                                  |
| --------- | ------------ | ----------------------- | -------------------------------------------------------- |
| `enp0s3`  | Production   | `192.168.50.50/24`      | VM-to-VM enterprise server traffic and internal DNS path |
| `enp0s8`  | NAT/Internet | `10.0.3.15/24` via DHCP | Internet access and package updates                      |
| `enp0s9`  | Management   | `192.168.56.50/24`      | Host-to-Linux SSH administration                         |

Validated Netplan behavior:

- `enp0s3` statically configured with `192.168.50.50/24`.
- `enp0s3` uses DC01 DNS at `192.168.50.10`.
- `corp.local` search domain is scoped to `enp0s3`.
- `enp0s8` uses DHCP for NAT/internet but does not own the `corp.local` search domain.
- `enp0s9` statically configured with `192.168.56.50/24` for management access.

Validated DNS results from LINUX01:

| Name                      | Expected Result    | Status          |
| ------------------------- | ------------------ | --------------- |
| `DC01.corp.local`         | `192.168.50.10`    | Pass using IPv4 |
| `PRINT01.corp.local`      | `192.168.50.20`    | Pass            |
| `DHCP01.corp.local`       | `192.168.50.30`    | Pass            |
| `FILE01.corp.local`       | `192.168.50.40`    | Pass            |
| `LINUX01.corp.local`      | `192.168.50.50`    | Pass            |
| `dc01-mgmt.corp.local`    | `192.168.56.10`    | Pass            |
| `print01-mgmt.corp.local` | `192.168.56.20`    | Pass            |
| `dhcp01-mgmt.corp.local`  | `192.168.56.30`    | Pass            |
| `file01-mgmt.corp.local`  | `192.168.56.40`    | Pass            |
| `linux01-mgmt.corp.local` | `192.168.56.50`    | Pass            |
| `ubuntu.com`              | Public DNS results | Pass            |

Validated routing results:

- `ping -c 4 192.168.50.10` passed over the production path.
- `ping -4 -c 4 DC01.corp.local` passed and resolved to `192.168.50.10`.
- `ping -c 4 dc01-mgmt.corp.local` passed and resolved to `192.168.56.10`.
- `ping -c 4 10.0.3.2` passed to the NAT gateway.
- `ping -c 4 ubuntu.com` passed through internet DNS and routing.
- `ping DC01.corp.local` without `-4` attempted IPv6 first; IPv6 is documented as out of scope for
  this phase.

Enterprise findings and fixes:

- Added missing `LINUX01.corp.local` production A record.
- Removed incorrect duplicate `LINUX01 -> 192.168.50.60` record.
- Created and validated management DNS records using `*-mgmt.corp.local`.
- Configured the Windows workstation management adapter to use DC01 DNS and `corp.local` suffix.
- Removed incorrect `DC01` A records for `10.0.3.15` and `192.168.56.10`; kept
  `DC01.corp.local -> 192.168.50.10`.
- Left DC01 IPv6 AAAA record in place, with IPv4 treated as the operating standard for this phase.

## Phase 11.6 Docker Baseline

Date started: 2026-06-30

Date validated: 2026-06-30

Objective:

- Install and validate Docker Engine on `LINUX01` using a production-style change process.
- Confirm Docker daemon, containerd, Compose plugin, image pull, and basic container execution.
- Document Docker privilege risk, troubleshooting, rollback, and interview relevance.

Pre-change validation:

| Check                     | Result                                                       |
| ------------------------- | ------------------------------------------------------------ |
| SSH alias `linux01`       | Pass                                                         |
| Hostname                  | `linux01`                                                    |
| User                      | `michael`                                                    |
| OS                        | Ubuntu 24.04.4 LTS                                           |
| Docker CLI                | Not installed                                                |
| Docker systemd unit files | Not present                                                  |
| Sudo access               | User is in `sudo`; password required for privileged commands |
| Disk baseline             | 24G root filesystem, about 16G available                     |
| Memory baseline           | 3.8Gi total, about 3.4Gi available                           |

Validated implementation:

- Docker installed from Docker's official Ubuntu apt repository.
- `docker.service` is active and enabled.
- `containerd.service` is active and enabled.
- Docker Engine and CLI version: `29.6.1`.
- Docker Compose plugin version: `v5.2.0`.
- `sudo docker run hello-world` completed successfully.
- `sudo docker info` captured daemon, runtime, security, storage, and host baseline.
- `sudo docker ps -a` shows the stopped `hello-world` validation container.
- `sudo docker images` shows `hello-world:latest`.
- `sudo docker network ls` shows default `bridge`, `host`, and `none` networks.
- `sudo docker volume ls` shows no volumes yet.
- Non-root Docker API access is currently denied, which confirms `michael` has not been granted
  Docker daemon access through the `docker` group.

Access-control decision:

- Keep Docker administration sudo-only for now.
- Do not add `michael` to the `docker` group until there is a clear operational need.

Operational warning:

- Membership in the `docker` group is privileged and should be treated like administrative access
  because Docker can control host-mounted filesystems and privileged containers.

Evidence target:

- Store Docker command summaries and validation notes in `../../../Linux/Docker/README.md`.

## Phase 11.7 Portainer

Date started: 2026-06-30

Date validated: 2026-06-30

Objective:

- Deploy Portainer CE on `LINUX01`.
- Manage the local Docker Engine through a web UI.
- Validate HTTPS management access on port `9443`.
- Document Docker socket risk, persistent storage, rollback, and interview relevance.

Planned deployment:

- Container image: `portainer/portainer-ce:sts`.
- Container name: `portainer`.
- Published port: `9443/tcp`.
- Persistent volume: `portainer_data`.
- Docker network: `portainer_network`.
- Docker socket mount: `/var/run/docker.sock:/var/run/docker.sock`.

Validated implementation:

- Portainer container `portainer` is running from image `portainer/portainer-ce:sts`.
- `portainer_data` volume exists.
- `portainer_network` exists.
- Host port `9443/tcp` is listening and reachable from the Windows management workstation.
- `Test-NetConnection 192.168.56.50 -Port 9443` passed.
- Portainer UI loads at `https://192.168.56.50:9443`.
- Portainer admin login works.
- Local Docker environment is visible and marked `Up`.
- Portainer shows Docker `29.6.1`.

Security notes:

- Portainer admin access is privileged because Portainer controls Docker through the host Docker
  socket.
- The initial admin password must be stored in a password manager, not in this repository.
- Phase 11.7 should use management-network access only.
- Do not expose Portainer to the internet.

Evidence target:

- Store Portainer validation notes in `../../../Linux/Portainer/README.md`.

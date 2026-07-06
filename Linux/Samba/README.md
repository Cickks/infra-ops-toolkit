# Samba

Purpose: document Phase 12 Linux SMB file-sharing work on `LINUX01`.

## Objective

Build an internal Samba share so Windows and Linux systems can access a Linux-hosted file share. This reinforces file sharing, permissions, firewall validation, service management, and troubleshooting.

## Enterprise Relevance

Samba appears in mixed Windows/Linux environments where Linux servers provide SMB-compatible shares. It helps compare Linux sharing against the existing Windows `FILE01` file server.

## Planned Baseline

| Item | Planned Value |
| --- | --- |
| Host | `LINUX01` |
| Share name | `linux_shared` |
| Path | `/srv/samba/linux_shared` |
| Admin path | Management network |
| Client validation | Windows workstation and Linux shell |
| Internet exposure | None |

## Phase 12.1 Pre-Change Status

Date checked: 2026-07-06 UTC

Package maintenance was performed before Samba installation. Samba is not installed yet.

| Check | Result |
| --- | --- |
| `apt policy samba` installed state | `(none)` |
| Samba candidate | `2:4.19.5+dfsg-4ubuntu9.6` |
| Existing listeners on TCP `445` or `139` | None shown |
| Package maintenance state | Upgrade completed; reboot and post-upgrade validation passed on 2026-07-06 UTC |

Decision:

- Package-maintenance gate is closed for Phase 12.1 purposes.
- `LINUX01` is ready for the controlled Samba baseline change.
- `fwupd` remains a non-blocking phased-update follow-up, not a Samba blocker.

## Phase 12.1 Pre-Change Validation

Date validated: 2026-07-06 UTC

Objective:

- Confirm `LINUX01` is ready before installing Samba packages.
- Confirm no existing SMB service is already listening on the expected ports.
- Create a local change marker under `/root/phase12-backups`.

Validated evidence:

| Check | Result |
| --- | --- |
| Hostname | `linux01` |
| OS | Ubuntu 24.04.4 LTS |
| Kernel | `6.8.0-134-generic` |
| Root filesystem | 24G total, 7.6G used, 15G available, 34% used |
| SSH service | Active and enabled |
| Samba installed state | `(none)` |
| Samba candidate version | `2:4.19.5+dfsg-4ubuntu9.6` |
| Existing TCP `445` listener | None shown |
| Existing TCP `139` listener | None shown |
| Change marker | `/root/phase12-backups/phase12-1-samba-start.txt` |
| Change marker timestamp | Mon Jul 6 01:24:05 AM UTC 2026 |

Decision:

- Pre-change gate passed.
- Proceed to Samba package installation as the next controlled step.

## Phase 12.1 Samba Package Installation

Date validated: 2026-07-06 UTC

Objective:

- Install Samba packages on `LINUX01`.
- Confirm the SMB/NMB daemons start successfully.
- Confirm expected SMB ports are listening before editing share configuration.

Validated evidence:

| Check | Result |
| --- | --- |
| Samba version | `4.19.5-Ubuntu` |
| `smbd.service` | Active, running, enabled |
| `nmbd.service` | Active, running, enabled |
| TCP `139` | Listening on IPv4 and IPv6 |
| TCP `445` | Listening on IPv4 and IPv6 |
| Service warning | `Referenced but unset environment variable ...OPTIONS` shown for `smbd` and `nmbd`; services still active |

Decision:

- Samba package installation succeeded.
- Proceed to backing up `/etc/samba/smb.conf` before creating or modifying shares.
- Treat the systemd environment-variable warning as non-blocking unless service behavior fails validation.

## Phase 12.1 Config Backup And Share Directory

Date validated: 2026-07-06 UTC

Objective:

- Back up the default Samba configuration before editing.
- Validate the default Samba configuration with `testparm`.
- Create the planned Linux share path and group-based permissions.

Validated evidence:

| Check | Result |
| --- | --- |
| Initial typo | `sudo c[ p ...` failed with command not found; no change made |
| Config backup | `/root/phase12-backups/smb.conf.pre-phase12-1` created |
| Backup owner/group | `root:root` |
| Backup size | 8917 bytes |
| `testparm` | Loaded services file OK |
| Server role | `ROLE_STANDALONE` |
| Share directory | `/srv/samba/linux_shared` created |
| Share group | `linuxshare` created |
| User group assignment | `michael` added to `linuxshare` |
| Directory owner/group | `root:linuxshare` |
| Directory mode | `2770` / `drwxrws---` |

Operational note:

- The current shell session may not see the new `linuxshare` group membership until logout/login.
- Samba authentication is separate from Linux group membership; a Samba password for `michael` may be required before Windows access succeeds.

Decision:

- Configuration backup and share directory permissions are ready.
- Proceed to adding the `[linux_shared]` share block to `/etc/samba/smb.conf`.

## Phase 12.1 Share Configuration And Service Restart

Date validated: 2026-07-06 UTC

Objective:

- Add the controlled `[linux_shared]` Samba share definition.
- Validate the Samba configuration parser output.
- Restart Samba services and confirm both daemons are healthy.

Share block validated by `testparm`:

```ini
[linux_shared]
    create mask = 0660
    directory mask = 02770
    force group = linuxshare
    path = /srv/samba/linux_shared
    read only = No
    valid users = @linuxshare
```

Validated evidence:

| Check | Result |
| --- | --- |
| `testparm` share output | `[linux_shared]` present with expected path, group, masks, and write access |
| Service restart | `sudo systemctl restart smbd nmbd` completed |
| Typo during validation | `system status smbd --no-pager` failed safely; corrected command used |
| `smbd.service` after restart | Active, running, enabled |
| `nmbd.service` after restart | Active, running, enabled |
| Service warning | `Referenced but unset environment variable ...OPTIONS` still present; non-blocking while services are healthy |

Decision:

- Samba share configuration is loaded and services are healthy.
- Next gate is authentication and client access validation.
- Confirm editor is closed before continuing if `sudo nano /etc/samba/smb.conf` is still open.

Next validation:

- Set or confirm Samba password for `michael`.
- Confirm Samba account exists.
- Test local Samba listing.
- Test Windows connectivity and file create/read/delete.

## Phase 12.1 Samba Authentication And Client Mapping

Date validated: 2026-07-06 UTC

Objective:

- Enable Samba authentication for `michael`.
- Confirm the Samba account exists.
- Install `smbclient` when the local test tool was missing.
- Validate Windows can map the share using the Samba account.

Validated evidence:

| Check | Result |
| --- | --- |
| Samba password creation | `sudo smbpasswd -a michael` succeeded; password not documented |
| Samba user enablement | `sudo smbpasswd -e michael` succeeded |
| Samba account listing | `michael:1000:Michael Painter` shown by `pdbedit -L` |
| `smbclient` initial state | Missing; command not found |
| `smbclient` install | Installed `smbclient` and `libsmbclient0` |
| Package restart impact | No services, containers, sessions, or VM guests needed restart |
| Windows mapping | `net use \\192.168.56.50\linux_shared /user:michael` completed successfully |

Decision:

- Authentication and Windows share mapping passed.
- Final validation still requires create/read/delete testing through the mapped share and server-side permission verification.

Next validation:

```powershell
echo Phase 12 Samba test > \\192.168.56.50\linux_shared\phase12-samba-test.txt
type \\192.168.56.50\linux_shared\phase12-samba-test.txt
del \\192.168.56.50\linux_shared\phase12-samba-test.txt
```

Server-side validation after the Windows test:

```bash
ls -la /srv/samba/linux_shared
sudo tail -n 50 /var/log/samba/log.smbd
```

## Phase 12.1 Server-Side Share Validation

Date validated: 2026-07-06 UTC

Objective:

- Confirm the Samba share path is clean after client-side testing.
- Confirm share ownership and group permissions remained correct.
- Review Samba server logs for obvious service-side errors.

Validated evidence:

| Check | Result |
| --- | --- |
| Share path listing | `/srv/samba/linux_shared` checked |
| Directory owner/group | `root:linuxshare` |
| Directory permissions | `drwxrws---` |
| Directory contents after test | No test file remained after delete |
| Parent directory | `/srv/samba` remains `root:root` |
| `log.smbd` review | Normal Samba startup entries shown; no obvious access-denied or share errors in displayed output |

Decision:

- Server-side share state looks healthy.
- Phase 12.1 can be closed after Windows create/read/delete output is confirmed.

## Phase 12.1 Final Windows Client Validation

Date validated: 2026-07-06 UTC

Objective:

- Prove the Windows client can write to, read from, and delete from the Linux-hosted Samba share.
- Confirm the business outcome: a Windows user can use the Linux SMB share through the management network.

Validated evidence:

| Check | Result |
| --- | --- |
| Create file from Windows | `echo Phase 12 Samba test > \\192.168.56.50\linux_shared\phase12-samba-test.txt` succeeded |
| Read file from Windows | `type \\192.168.56.50\linux_shared\phase12-samba-test.txt` returned the test content |
| Delete file from Windows | `del \\192.168.56.50\linux_shared\phase12-samba-test.txt` succeeded |
| Server-side cleanup | `/srv/samba/linux_shared` showed no test file remaining after deletion |
| Server-side permissions | Share directory remained `root:linuxshare` with `drwxrws---` permissions |

Note:

- PowerShell `echo` wrote the words on separate lines, but the readback confirmed the file was created and read successfully over SMB.

Phase result:

- Phase 12.1 Samba baseline is complete.
- `LINUX01` now hosts an internal Samba share named `linux_shared`.
- Windows access using `\\192.168.56.50\linux_shared` and Samba user `michael` was validated.
- The share remains internal-only and must not be exposed to the internet.

Rollback:

- Remove or comment out the `[linux_shared]` block in `/etc/samba/smb.conf`.
- Restore `/root/phase12-backups/smb.conf.pre-phase12-1` if needed.
- Restart Samba with `sudo systemctl restart smbd nmbd`.
- Remove the share directory only after confirming no needed data remains.

Interview relevance:

- This proves Linux package installation, Samba service management, Linux group permissions, SMB authentication, Windows client mapping, port validation, and end-to-end access testing.

## Implementation Checklist

- Confirm snapshot or rollback point.
- Record package state before install.
- Install Samba packages. Complete.
- Create service directory under `/srv/samba`. Complete.
- Create Linux group for share access. Complete.
- Assign ownership and permissions. Complete.
- Configure `/etc/samba/smb.conf`. Complete.
- Test config with `testparm`. Complete.
- Restart and enable Samba services. Complete.
- Validate listening ports.
- Validate firewall scope.
- Connect from Windows. Complete.
- Review logs. Complete.
- Document rollback. Complete.

## Evidence Commands

```bash
hostnamectl
sudo apt update
apt policy samba
sudo testparm
systemctl status smbd --no-pager
systemctl status nmbd --no-pager
ss -tulpn | grep -E ':445|:139'
sudo tail -n 50 /var/log/samba/log.smbd
```

```powershell
Test-NetConnection 192.168.56.50 -Port 445
net view \\192.168.56.50
```

## Rollback Notes

- Back up `/etc/samba/smb.conf` before editing.
- Remove or disable the share if validation fails.
- Stop and disable Samba services if needed.
- Restore VM snapshot for unrecoverable misconfiguration.

## Interview Talking Points

- Difference between SMB and NFS.
- Linux permissions versus share-level permissions.
- How to validate a listening service.
- How to troubleshoot access denied errors.
- Why internal file services require backups and least privilege.

# Linux Backups

Purpose: document Phase 12 Linux backup and restore work.

## Objective

Create a repeatable backup process for Linux configuration and service data, then validate at least
one restore.

## Enterprise Relevance

Self-hosting without restore testing is fragile. A real administrator must know what data matters,
where it lives, how often it changes, how to back it up, and how to restore it.

## Initial Backup Scope

Start with configs and small service data:

- `/etc`
- `/srv`
- Selected Docker Compose files.
- Selected service data after each app is deployed.
- Documentation notes describing backup location and restore status.

Do not commit backup archives to Git.

## Candidate Tools

| Tool        | Use                                            |
| ----------- | ---------------------------------------------- |
| `rsync`     | File sync and simple backups                   |
| `tar`       | Portable archives                              |
| `sha256sum` | Integrity checks                               |
| `systemctl` | Stop/start services around backups when needed |
| `cron`      | Schedule backup checks after manual validation |

## Evidence Commands

```bash
df -h
du -sh /etc /srv
sudo tar --version
rsync --version
sha256sum <backup-file>
```

## Restore Test Requirement

A backup is not complete until at least one restore is tested.

Minimum restore test:

- Restore a small test directory or config copy to a temporary location.
- Compare file count and checksum where practical.
- Document the command and result.
- Remove temporary restore data after validation.

## Interview Talking Points

- Difference between backup and restore.
- Why configuration and data paths must be known.
- Why databases often need app-aware backups.
- Why backup archives should not be stored in Git.
- How retention and restore testing reduce outage risk.

## Phase 12.6 LINUX01 Backup And Restore Validation

Date validated: 2026-07-07

Objective:

- Back up `LINUX01` configuration and small service data.
- Generate checksum and manifest evidence.
- Restore selected content to a temporary location without overwriting production paths.
- Validate core services after the backup and restore test.

Backup artifact:

```text
/var/backups/homelab/phase12-6/linux01-config-service-20260707-215146.tar.gz
```

Backup scope:

- `/etc`
- `/srv`
- `/opt/homelab`
- `/var/log/homelab`

Validation results:

| Check             | Result                                                                 |
| ----------------- | ---------------------------------------------------------------------- |
| Archive size      | `653K`                                                                 |
| Manifest size     | `56K`                                                                  |
| Archive entries   | `1801`                                                                 |
| SHA256 validation | `OK`                                                                   |
| Restore target    | `/tmp/phase12-6-restore-test`                                          |
| Disk after test   | `/` remained `35%` used with about `15G` available                     |
| Cleanup           | Temporary restore directory removed                                    |
| Services          | `ssh`, `docker`, `containerd`, `smbd`, `nfs-server`, `cron`, heartbeat active |

Restore checks:

- `etc/samba/smb.conf` present.
- `etc/exports` present.
- `etc/cron.d/linux01-health-report` present.
- `etc/systemd/system/linux01-systemd-heartbeat.service` present.
- `/srv`, `/opt/homelab`, and `/var/log/homelab` content present.

Operational note:

- The backup archive is stored locally on `LINUX01`. This proves the backup and restore process, but
  it is not full disaster recovery. The next maturity step is off-host backup copy and retention
  planning.

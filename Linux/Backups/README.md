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

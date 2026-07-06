# Backup And Rollback Evidence

Use this folder for backup, restore, VM export, snapshot, and rollback documentation.

Record:

- Objective.
- Systems protected.
- Backup method.
- Storage location.
- Validation result.
- Restore test result.
- Rollback steps.
- Problems encountered and fixes.
- Interview relevance.

Do not commit large VM exports, appliance images, or backup archives. Store checksums, versions, paths, and evidence notes instead.

## Standard Backup Notes

For each VM or system backup, document:

- VM or host name.
- Backup type: snapshot, export, file copy, image, or config backup.
- Backup location.
- Date created.
- Size.
- Checksum when practical.
- Restore test result.

## Useful Commands

Checksum from Windows:

```powershell
Get-FileHash "C:\Path\To\Export.ova" -Algorithm SHA256
```

Disk usage from Linux:

```bash
df -h
du -sh /path/to/backup
sha256sum /path/to/file
```

## Evidence Checklist

- Pre-change snapshot or backup exists.
- Restore process is known.
- Rollback steps are documented.
- Large backup files are not committed.
- Inventory records where the backup is stored.

## Phase 11.9 Stable Snapshot Readiness

Date documented: 2026-06-30

Snapshot status:

| System | Backup Type | Status | Notes |
| --- | --- | --- | --- |
| `DC01` | VirtualBox snapshot | Complete | Stable post-Phase 11 management/DNS validation state |
| `PRINT01` | VirtualBox snapshot | Complete | Stable post-Phase 11 management/WinRM validation state |
| `DHCP01` | VirtualBox snapshot | Complete | Stable post-Phase 11 management/WinRM validation state |
| `FILE01` | VirtualBox snapshot | Complete | Stable post-Phase 11 management/WinRM validation state |
| `LINUX01` | VirtualBox snapshot | Complete | Stable Docker and Portainer baseline state |
| `INFRA01` | microSD image backup | Pending | Raspberry Pi is staged and validated; create image backup before hosting important services |

Rollback note:

- Use VM snapshots as the immediate rollback point for Windows and `LINUX01` before Phase 12.
- Do not commit VM snapshots, OVA exports, or microSD images to Git.
- For `INFRA01`, create a microSD image backup before adding write-heavy or important services.

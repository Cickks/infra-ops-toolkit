# PowerShell

Purpose: Windows administration, reporting, monitoring, testing, and reusable scripts for the
homelab.

Use subfolders by domain:

- `ActiveDirectory/` - AD user, group, OU, and lifecycle scripts.
- `DHCP/` - DHCP scope, lease, and option reporting.
- `FileServer/` - share and NTFS permission reporting.
- `Monitoring/` - health checks and service checks.
- `Reports/` - generated or curated admin reports.
- `Scripts/` - general reusable scripts.
- `Testing/` - validation and Pester tests.
- `Modules/` - reusable module code.

Every reusable script should include purpose, prerequisites, example usage, validation, and rollback
notes where applicable.

## Portfolio Sync

Manual Portfolio sync script:

```powershell
.\Scripts\Sync-PortfolioToLinux.ps1
```

Default target:

- `linux01:/home/michael/Portfolio`

Optional INFRA01 target:

```powershell
.\Scripts\Sync-PortfolioToLinux.ps1 -IncludeInfra01
```

Fallback mode when `rsync.exe` is unavailable or blocked by endpoint controls:

```powershell
.\Scripts\Sync-PortfolioToLinux.ps1 -NoRsync
```

Safety notes:

- The script stages a clean copy first.
- It excludes `.git`, `node_modules`, virtual environments, caches, and build outputs.
- It does not delete files from the remote `/home/michael/Portfolio` destination.
- `-NoRsync` uses tar/scp create-update mode and is safer when rsync cannot run.
- INFRA01 may require password SSH until SSH key authentication is configured.

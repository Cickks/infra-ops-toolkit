# NFS

Purpose: document Phase 12 Linux NFS sharing work.

## Objective

Build a basic internal NFS export from `LINUX01` and validate Linux-to-Linux access. This prepares for future Linux storage, container storage, and `INFRA01` integration.

## Enterprise Relevance

NFS is common for Linux servers, virtualization platforms, backup targets, and application data paths. Understanding NFS helps with storage troubleshooting and later Proxmox/NAS work.

## Planned Baseline

| Item | Planned Value |
| --- | --- |
| Host | `LINUX01` |
| Export path | `/srv/nfs/linux_shared` |
| Allowed client | `192.168.56.0/24` management subnet |
| Client validation | `LINUX01` same-host NFS mount over management IP |
| Internet exposure | None |

## Phase 12.2 Pre-Change Validation

Date validated: 2026-07-06 UTC

Objective:

- Confirm `LINUX01` is ready before installing NFS packages.
- Confirm no existing NFS service is already listening on the expected ports.
- Keep the NFS change scoped to an internal lab export only.

Validated evidence:

| Check | Result |
| --- | --- |
| Hostname | `linux01` |
| OS | Ubuntu 24.04.4 LTS |
| Kernel | `6.8.0-134-generic` |
| Root filesystem | 24G total, 7.7G used, 15G available, 35% used |
| SSH service | Active and enabled |
| Windows management TCP test to `192.168.56.50:22` | Pass from source `192.168.56.1` |
| `nfs-kernel-server` installed state | `(none)` |
| `nfs-kernel-server` candidate version | `1:2.6.4-3ubuntu5.1` |
| Existing TCP/UDP `2049` or `111` listeners | None shown in pre-change check |

Decision:

- Pre-change gate passed.
- Proceed to a controlled NFS package installation and export configuration.
- Privileged commands require an interactive `sudo` password on `LINUX01`; do not document the password.

Next implementation commands to run from an SSH session on `LINUX01`:

```bash
sudo mkdir -p /root/phase12-backups
date | sudo tee /root/phase12-backups/phase12-2-nfs-start.txt
sudo apt update
sudo apt install nfs-kernel-server nfs-common
systemctl status nfs-server --no-pager
ss -tulpn | grep -E ':2049|:111' || true
```

## Phase 12.2 NFS Package Installation

Date validated: 2026-07-06 UTC

Objective:

- Install NFS server and client support packages on `LINUX01`.
- Confirm `nfs-server` is active and enabled.
- Confirm NFS-related ports begin listening only after installation.

Validated evidence:

| Check | Result |
| --- | --- |
| `nfs-kernel-server` package | Installed, version `1:2.6.4-3ubuntu5.1` |
| `nfs-common` package | Installed, version `1:2.6.4-3ubuntu5.1` |
| `nfs-server` service | Active and enabled |
| TCP `2049` | Listening on IPv4 and IPv6 |
| TCP/UDP `111` | Listening on IPv4 and IPv6 |
| Windows management TCP test to `192.168.56.50:2049` | Pass from source `192.168.56.1` |
| Windows management TCP test to `192.168.56.50:111` | Pass from source `192.168.56.1` |

Operational note:

- The first service start logged `exportfs: can't open /etc/exports for reading` because `/etc/exports` did not exist yet.
- This was resolved by creating `/etc/exports`, backing it up, adding the controlled export, and reloading exports successfully.

## Phase 12.2 Export Configuration

Date validated: 2026-07-06 UTC

Objective:

- Create a rollback copy of `/etc/exports`.
- Create the NFS export directory.
- Restrict the export to the management subnet.
- Validate the active export list before client testing.

Configured export:

```exports
/srv/nfs/linux_shared 192.168.56.0/24(rw,sync,no_subtree_check)
```

Validated evidence:

| Check | Result |
| --- | --- |
| `/etc/exports` | Created |
| Export config backup | `/root/phase12-backups/exports.pre-phase12-2` |
| Backup owner/group | `root:root` |
| Backup size | 389 bytes |
| Export directory | `/srv/nfs/linux_shared` |
| Export directory owner/group | `nobody:nogroup` |
| Export directory permissions | `drwxrwsr-x`, mode `2775` |
| `sudo exportfs -ra` | Completed successfully |
| `sudo exportfs -v` | Export active for `192.168.56.0/24` |
| `showmount -e localhost` | `/srv/nfs/linux_shared 192.168.56.0/24` |
| Security defaults | `root_squash` active by default; `no_all_squash` shown |

Decision:

- Export configuration is valid.
- Export is scoped to the management subnet.
- Do not broaden the export with `*` or internet-facing access.

## Phase 12.2 Mount And File Validation

Date validated: 2026-07-06 UTC

Objective:

- Prove that the NFS export can be mounted over the management IP.
- Prove write, read, list, delete, and unmount behavior.
- Confirm server-side cleanup after testing.

Validated evidence:

| Check | Result |
| --- | --- |
| Mount command | `sudo mount -t nfs 192.168.56.50:/srv/nfs/linux_shared /mnt/nfs-linux-shared` succeeded |
| Mounted protocol | `nfs4` |
| Mount path | `/mnt/nfs-linux-shared` |
| Export source | `192.168.56.50:/srv/nfs/linux_shared` |
| Disk view through NFS | 24G total, 7.7G used, 15G available, 35% used |
| File create | `phase12-nfs-test.txt` created through mounted export |
| File read | Returned `Phase 12.2 NFS test` |
| File owner/group shown through mount | `nobody:nogroup` |
| File delete | Test file removed |
| Unmount | `/mnt/nfs-linux-shared` unmounted successfully |
| Server-side cleanup | `/srv/nfs/linux_shared` contained no test file after cleanup |
| Final `nfs-server` state | Active and enabled |
| Final export check | `/srv/nfs/linux_shared` active for `192.168.56.0/24` |

Note:

- After unmount, `nfsd on /proc/fs/nfsd` may still appear in `mount | grep nfs`.
- That is the kernel NFS server pseudo-filesystem, not the test client mount remaining attached.

Phase result:

- Phase 12.2 NFS baseline is complete.
- `LINUX01` now hosts an internal NFS export at `/srv/nfs/linux_shared`.
- The export is management-subnet scoped and validated for mount, write, read, list, delete, unmount, port reachability, and service health.

## Implementation Checklist

- Confirm rollback point. Complete.
- Install NFS server packages. Complete.
- Create export directory. Complete.
- Set ownership and permissions. Complete.
- Configure `/etc/exports`. Complete.
- Apply exports. Complete.
- Validate with `exportfs`. Complete.
- Confirm service status. Complete.
- Validate listening ports. Complete.
- Mount from client. Complete.
- Create/read/delete test file. Complete.
- Unmount cleanly. Complete.
- Review logs. Complete.
- Document rollback. Complete.

## Evidence Commands

```bash
sudo apt update
apt policy nfs-kernel-server
systemctl status nfs-server --no-pager
sudo exportfs -v
showmount -e localhost
ss -tulpn | grep -E ':2049|:111'
```

Client-side validation:

```bash
showmount -e linux01
sudo mount -t nfs linux01:/srv/nfs/linux_shared /mnt
mount | grep nfs
```

## Rollback Notes

- Back up `/etc/exports` before editing.
- Remove the export entry and run `sudo exportfs -ra`.
- Stop and disable NFS services if needed.
- Unmount clients before removing directories.
- Restore `/root/phase12-backups/exports.pre-phase12-2` if the export configuration must be reverted.
- Restore the Phase 11.9 stable VM snapshot only if package/config rollback fails.

## Interview Talking Points

- When to use NFS instead of SMB.
- How exports restrict clients.
- Why UID/GID mapping matters.
- How to validate mounts, ports, and logs.
- Why storage services need backup and monitoring.

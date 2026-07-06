# INFRA01 Production Readiness Runbook

Status: Phase 12.0A active; Phase 12.0B planned.

## Operating Model

`LINUX01` is the practice host.

`INFRA01` is the future 24/7 infrastructure host.

Do not place important services on `INFRA01` until storage, network, SSH, Docker, Portainer, backup, and rollback are documented.

## Phase 12.0A — LINUX01 Practice

Objective:

- Practice the commands and concepts needed for `INFRA01` production readiness without risking the Raspberry Pi.

Run on `LINUX01`:

```bash
hostnamectl
cat /etc/os-release
ip addr
ip route
resolvectl status
lsblk -f
df -h
findmnt
cat /etc/fstab
systemctl status ssh --no-pager
systemctl status docker --no-pager
docker --version
docker compose version
sudo docker info
sudo docker ps
sudo docker volume ls
sudo docker network ls
```

Run from Windows:

```powershell
ssh linux01
Test-NetConnection 192.168.56.50 -Port 22
Test-NetConnection 192.168.56.50 -Port 9443
```

What to learn:

- How Linux identifies disks and filesystems.
- How persistent mounts use UUIDs.
- Why `/etc/fstab` mistakes can break boot.
- How to validate SSH before and after changes.
- How Docker stores data.
- Why Docker data should live on SSD-backed storage on `INFRA01`.
- Why Portainer is powerful and should stay internal.

Do not change:

- Do not repartition disks on `LINUX01`.
- Do not move Docker data-root yet.
- Do not alter production network settings unless there is a documented change.

Success criteria:

- Baseline commands captured.
- Disk, mount, SSH, Docker, Compose, and Portainer concepts understood.
- Any questions or risks recorded before touching `INFRA01`.

Validation result:

- 2026-07-05: Phase 12.0A baseline validation completed on `LINUX01` using screenshot evidence from the terminal session.
- Windows management tests from source `192.168.56.1` to `LINUX01` management IP `192.168.56.50` passed for SSH port `22` and Portainer port `9443`.
- Linux baseline checks captured host, network, storage, mounts, `/etc/fstab`, SSH, Docker, containerd, Docker inventory, volumes, and networks.
- Result is good for continuing Phase 12 work on `LINUX01`.
- Do not promote the same workflow to `INFRA01` yet; `INFRA01` still needs NVMe SSD, persistent mounts, Docker data placement, backup planning, and rollback documentation before important services.

Open item:

- Treat `LINUX01` package updates as a separate package-maintenance change with its own validation and rollback notes.

## Phase 12.0B — INFRA01 Hardware And OS Readiness

Objective:

- Prepare `INFRA01` to become a reliable always-on infrastructure server.

Hardware tasks:

1. Power down `INFRA01`.
2. Install NVMe HAT.
3. Install 1TB NVMe SSD.
4. Install or confirm active cooling.
5. Boot and confirm the Pi is stable.

Baseline commands on `INFRA01`:

```bash
hostnamectl
cat /etc/os-release
uname -a
ip addr
ip route
lsblk -f
df -h
free -h
vcgencmd measure_temp
systemctl status ssh --no-pager
```

OS update:

```bash
sudo apt update
apt list --upgradable
sudo apt upgrade
sudo reboot
```

Post-reboot validation:

```bash
hostnamectl
ip addr
lsblk -f
df -h
systemctl status ssh --no-pager
```

## Static IP Decision

Preferred enterprise approach:

- Use a DHCP reservation on the router or DHCP server when possible.
- Document the final IP before relying on it.

Future target:

- `infra01.corp.local`
- `192.168.50.60` when attached to the homelab production network.

Current staging:

- `192.168.1.133` on Wi-Fi.

Do not force `192.168.50.60` while the Pi is still on a network where `192.168.50.0/24` is not valid.

## NVMe SSD Readiness

After installing the NVMe SSD, identify it:

```bash
lsblk -f
sudo fdisk -l
```

Before formatting:

- Confirm the device name carefully.
- Confirm it is the new NVMe SSD.
- Do not format the microSD.

Planned mount point:

```text
/srv
```

Alternative:

```text
/mnt/infra-data
```

Use UUID in `/etc/fstab`, not a changing device name.

## Docker Readiness

Docker should store persistent container data on SSD-backed storage before real services are deployed.

Validate:

```bash
docker --version
docker compose version
sudo docker info
sudo systemctl status docker --no-pager
sudo systemctl status containerd --no-pager
```

Important:

- Decide Docker data-root before hosting important containers.
- Record whether Docker is sudo-only or whether `michael` is added to the `docker` group.
- Treat Docker group membership as privileged admin access.

## Portainer Readiness

Portainer should be deployed only after Docker storage placement is decided.

Validation target:

- Portainer reachable from internal/management network only.
- Persistent Portainer data stored on SSD-backed storage.
- Admin password stored in password manager, not in Git.
- Docker socket risk documented.

## Rollback

Rollback options:

- Remove experimental containers.
- Stop and disable Docker.
- Restore previous Docker config.
- Remove failed mount entry from `/etc/fstab` using local console if boot fails.
- Re-image microSD only if OS recovery is needed.

## Interview Relevance

This proves:

- Linux production-readiness planning.
- Raspberry Pi server preparation.
- Storage and mount discipline.
- Static IP and DNS planning.
- SSH administration.
- Docker and Portainer infrastructure setup.
- Change control and rollback thinking.

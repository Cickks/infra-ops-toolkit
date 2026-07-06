# INFRA01

Role: Raspberry Pi infrastructure services host.

## Portfolio Status

| Item | Status |
| --- | --- |
| Phase | 11.8 |
| Area | Raspberry Pi preparation, production readiness, and future infrastructure services |
| Evidence state | Raspberry Pi OS Lite, Wi-Fi, SSH, update, reboot, storage, and baseline validation complete; production-readiness upgrade planned |
| Related docs | `../../../docs/ROADMAP.md`, `../../../docs/SERVER_INVENTORY.md`, `../../../Linux/ProductionReadiness/INFRA01_RUNBOOK.md` |

## Notes

- `INFRA01` is a Raspberry Pi 5 staged as a future infrastructure services host.
- Current role is preparation and remote administration validation.
- Candidate future roles include lightweight dashboard, monitoring, logging, Docker services, or automation services.
- Any role assignment should include dependencies, security impact, backup plan, and rollback plan.
- Do not run write-heavy services on microSD without backup and storage-risk documentation.
- Before real services, complete the production-readiness upgrade: NVMe HAT, 1TB NVMe SSD, active cooling, OS updates, SSH, static IP/DHCP reservation, SSD-backed Docker data, Docker Engine, Docker Compose, and Portainer.

## INFRA01 Lifecycle Plan

Current decision:

- `INFRA01` is alive and validated, but still in staging.
- `LINUX01` remains the main Phase 12 learning and testing host.
- `INFRA01` can be used for SSH practice, network tests, hardware/storage readiness, light dashboard pilots, and portfolio sync validation.
- `INFRA01` should not become the main services host until SSD storage, Docker data placement, and backup planning are ready.

Phase timing:

| Phase | INFRA01 Role |
| --- | --- |
| 11.8 | Raspberry Pi prepared, named, updated, SSH validated, and documented |
| 12 | Production-readiness upgrade; `LINUX01` remains the main Linux/self-hosting practice host |
| 12.5 | Documentation and dashboard planning may reference `INFRA01` |
| 14 | Monitoring may begin watching `INFRA01`; light Uptime Kuma/dashboard pilot is acceptable if documented |
| 18 | Main activation point for `INFRA01` as an always-on Docker/container infrastructure host |
| 18.5 | Reverse proxy and HTTPS patterns can make `INFRA01` services cleaner to access internally |
| 21.5 | Storage/NAS maturity improves long-term service placement decisions |
| 22 | AI Steve can query or operate against `INFRA01` after services, monitoring, logs, backups, and documentation are stable |

SSD decision:

- A 128GB microSD was not wasted; it is the boot/staging medium that made `INFRA01` real.
- Install the NVMe HAT, 1TB NVMe SSD, and active cooling before real services are deployed.
- Use the SSD for Docker data, service data, logs, repositories, databases, and important persistent storage.
- Keep microSD use limited to boot/staging or light services unless a backup image and restore plan exist.

## Phase 12.0B INFRA01 Production Readiness Plan

Objective:

- Turn `INFRA01` from a staged Raspberry Pi into a production-ready 24/7 infrastructure foundation before hosting important monitoring, automation, dashboard, Portainer, or AI Steve support services.

Practice-first rule:

- Practice risky concepts on `LINUX01` first where possible.
- Apply to `INFRA01` only after the commands, rollback, and evidence targets are understood.

Planned build sequence:

1. Install NVMe HAT.
2. Install 1TB NVMe SSD.
3. Confirm active cooling is installed and functioning.
4. Update Raspberry Pi OS.
5. Validate SSH and configure SSH key authentication.
6. Configure static IP or DHCP reservation for the final network placement.
7. Confirm hostname and future DNS plan: `infra01` and later `infra01.corp.local`.
8. Detect, partition, format, and mount the NVMe SSD.
9. Configure persistent mount in `/etc/fstab` using UUID.
10. Move Docker data path to SSD before running real containers.
11. Install Docker Engine.
12. Install Docker Compose plugin.
13. Deploy Portainer with persistent data on SSD.
14. Document firewall, ports, backup plan, validation commands, and rollback.

Success criteria:

- `INFRA01` boots reliably.
- SSH works after reboot.
- Static IP or DHCP reservation is documented.
- NVMe SSD mounts after reboot.
- Docker data path uses SSD-backed storage.
- Docker and Compose versions are captured.
- Portainer is reachable only from the intended internal/management network.
- Backup and rollback notes exist before real services are deployed.

AI Steve connection:

- `INFRA01` is intended to become one of the infrastructure nodes AI Steve can observe or help manage later.
- Before AI Steve touches it, `INFRA01` needs stable IP/DNS, SSH keys, service inventory, monitoring, logs, backups, and clear rollback procedures.
- The goal is for AI Steve to work against documented infrastructure, not undocumented experiments.

## Phase 11.8 Raspberry Pi Preparation

Date validated: 2026-06-30

| Item | Value |
| --- | --- |
| Hardware | Raspberry Pi 5 |
| Hostname | `infra01` |
| OS | Debian GNU/Linux 13 Trixie / Raspberry Pi OS Lite |
| Kernel | `6.18.34+rpt-rpi-2712` |
| Architecture | `arm64` |
| Current IP | `192.168.1.133/24` on `wlan0` |
| Gateway | `192.168.1.254` |
| Future target IP | `192.168.50.60` when connected to the homelab production network |
| Storage | microSD, 118G root filesystem, about 109G available |
| Memory | 7.9Gi total, about 7.6Gi available |
| SSH | Active, enabled, and validated from Windows |

Validation:

- First boot succeeded.
- Wi-Fi connection succeeded after local console troubleshooting.
- Windows ping to `192.168.1.133` succeeded.
- SSH from Windows to `michael@192.168.1.133` succeeded.
- `apt update` and `apt upgrade` completed successfully.
- Reboot completed and SSH reconnected successfully.

Network note:

- `INFRA01` is currently on the home Wi-Fi staging network, not the `corp.local` production subnet.
- Do not assign `192.168.50.60` until the Pi is connected to a network where `192.168.50.0/24` is valid.

## Planning Commands

Use once the OS and role are known:

```powershell
Test-NetConnection INFRA01
Resolve-DnsName INFRA01.corp.local
```

Linux candidate commands:

```bash
hostnamectl
ip addr
systemctl --type=service --state=running
docker version
docker ps
```

Windows candidate commands:

```powershell
hostname
Get-ComputerInfo
Get-Service | Where-Object Status -eq Running
Get-NetIPConfiguration
```

## Validation Checklist

- Confirm exact role.
- Confirm static IP or DHCP reservation.
- Confirm DNS record.
- Confirm firewall requirements.
- Confirm backup or snapshot exists.
- Confirm monitoring and logging expectations.

## Evidence To Capture

- Role decision note.
- Baseline system information.
- Network validation.
- Installed services.
- Security and firewall notes.

## Rollback

- Remove experimental services.
- Revert firewall rules.
- Restore from snapshot before reusing the host for another role.

## Interview Relevance

This will prove infrastructure planning, service ownership, dependency mapping, and change control once implemented.

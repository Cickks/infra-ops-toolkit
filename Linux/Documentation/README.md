# Linux Documentation

Use this folder for Linux notes, runbooks, and evidence.

Phase 11 baseline commands:

```bash
hostnamectl
cat /etc/os-release
ip addr
ip route
df -h
systemctl status ssh
```

Store `LINUX01` host-specific evidence in `../../Documentation/Server_Documentation/LINUX01/`.

Current Phase 11 status:

- Phase 11.4 SSH administration is complete.
- Phase 11.4.8 SSH troubleshooting validated management SSH to `192.168.56.50`.
- Phase 11.5 Linux networking is complete.
- Phase 11.6 Docker Engine baseline is complete.
- Phase 11.7 Portainer is complete.
- Phase 11.8 Raspberry Pi preparation is complete.
- Phase 11.9 enterprise hardening and environment validation is complete.
- Phase 11 Linux administration fundamentals is complete.

Phase 11.5 networking status:

- LINUX01 production interface: `enp0s3`, `192.168.50.50/24`.
- LINUX01 NAT interface: `enp0s8`, `10.0.3.15/24` via DHCP.
- LINUX01 management interface: `enp0s9`, `192.168.56.50/24`.
- `corp.local` DNS is handled by DC01 at `192.168.50.10`.
- NAT DHCP no longer owns the `corp.local` search domain.
- IPv4 routing and DNS validation completed for production, management, NAT, and internet paths.

Phase 11.6 Docker status:

- `LINUX01` is Ubuntu 24.04.4 LTS.
- Docker Engine 29.6.1 is installed from Docker's official Ubuntu Noble repository.
- Docker Compose plugin v5.2.0 is installed.
- `docker.service` and `containerd.service` are active and enabled.
- `sudo docker run hello-world` passed.
- `docker info`, `docker ps -a`, `docker images`, `docker network ls`, and `docker volume ls` were captured with `sudo`.
- Non-root Docker API access is denied by design; Docker administration remains sudo-only for now.
- Use `../Docker/README.md` for the Docker install runbook, validation checklist, troubleshooting path, rollback, and interview relevance.

Phase 11.7 Portainer status:

- Portainer CE is deployed on `LINUX01`.
- Management URL: `https://192.168.56.50:9443`.
- Portainer container is running.
- `portainer_data` volume exists.
- `portainer_network` exists.
- Windows workstation connectivity to port `9443` passed.
- Local Docker environment is visible in Portainer.
- Use `../Portainer/README.md` for the deployment runbook, validation checklist, rollback, and security notes.

Phase 11.8 Raspberry Pi status:

- `INFRA01` is a Raspberry Pi 5.
- Raspberry Pi OS Lite / Debian 13 Trixie is installed on microSD.
- Hostname is `infra01`.
- Staging Wi-Fi IP is `192.168.1.133`.
- Future homelab production IP remains `192.168.50.60` when the Pi is moved into the lab network.
- SSH from Windows is validated.
- Package update, package upgrade, reboot, disk, memory, and route validation are complete.
- Use `../RaspberryPi/README.md` and `../../Documentation/Server_Documentation/INFRA01/README.md` for evidence.

Phase 11.9 hardening and validation status:

- Production DNS and management DNS records were cleaned and validated.
- WinRM over management FQDNs was validated for DC01, PRINT01, DHCP01, and FILE01.
- RDP remains closed by design.
- LINUX01 SSH, Docker, containerd, Portainer container, Portainer volume/network, and Portainer port `9443` were validated.
- INFRA01 SSH, staging IP, storage, memory, and package update state were validated.
- Stable VirtualBox snapshots were created before moving toward Phase 12.

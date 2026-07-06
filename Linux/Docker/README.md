# Docker

Use this folder for Docker Engine, Docker Compose, container networking, image management, and container operations evidence for `LINUX01`.

## Phase 11.6 Docker Baseline

Status: Complete

Date started: 2026-06-30

Date validated: 2026-06-30

Host: `LINUX01`

Objective:

- Install Docker Engine on Ubuntu Server using a controlled, documented method.
- Validate the Docker daemon, Docker CLI, Compose plugin, container runtime, image pull, and a basic container lifecycle.
- Document security impact, rollback, troubleshooting, and interview relevance.

Why this matters in a real company:

- Docker is a common platform for internal tools, monitoring stacks, reverse proxies, CI runners, security tools, and lightweight application hosting.
- Installing it cleanly matters because Docker modifies host networking, adds a privileged daemon, creates service units, and stores runtime data under `/var/lib/docker`.
- The `docker` group should be treated like privileged access because users in that group can effectively gain root-level control of the host through the Docker daemon.

## Current LINUX01 Pre-Change State

Validated from Windows over SSH on 2026-06-30:

| Check | Result |
| --- | --- |
| SSH alias `linux01` | Pass |
| Hostname | `linux01` |
| Logged-in user | `michael` |
| OS | Ubuntu 24.04.4 LTS |
| Docker CLI | Not installed |
| Docker systemd unit | No Docker unit files listed |
| Current user groups | `michael adm cdrom sudo dip plugdev lxd` |
| Root filesystem | 24G total, 6.6G used, 16G available |
| Memory | 3.8Gi total, about 3.4Gi available |

Network baseline carried forward from Phase 11.5:

| Interface | Address | Purpose |
| --- | --- | --- |
| `enp0s3` | `192.168.50.50/24` | Production/internal server network |
| `enp0s8` | `10.0.3.15/24` | NAT/internet/package access |
| `enp0s9` | `192.168.56.50/24` | Management SSH |

## Change Plan

Risk level: Medium

Docker installation is medium risk because it changes packages, creates a privileged daemon, adds container networking, and may affect firewall or routing behavior.

Pre-change validation:

```bash
hostnamectl
cat /etc/os-release
id
groups
ip -4 addr show
ip route
resolvectl dns
df -h / /var
free -h
dpkg -l | grep -E 'docker|containerd|runc' || true
systemctl list-unit-files 'docker*' --no-pager
```

Recommended install method:

- Use Docker's official apt repository for Ubuntu 24.04 Noble.
- Avoid the convenience script because this lab is being documented like production, not a throwaway development host.
- Install Docker Engine, CLI, containerd, Buildx, and the Compose plugin.

## Implementation Commands

Run on `LINUX01`.

Remove conflicting packages if present:

```bash
sudo apt remove docker.io docker-compose docker-compose-v2 docker-doc podman-docker containerd runc
```

Set up Docker's apt repository:

```bash
sudo apt update
sudo apt install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
```

```bash
sudo tee /etc/apt/sources.list.d/docker.sources >/dev/null <<EOF
Types: deb
URIs: https://download.docker.com/linux/ubuntu
Suites: $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}")
Components: stable
Architectures: $(dpkg --print-architecture)
Signed-By: /etc/apt/keyrings/docker.asc
EOF
```

Install Docker:

```bash
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Enable and validate services:

```bash
sudo systemctl enable docker.service
sudo systemctl enable containerd.service
sudo systemctl status docker --no-pager
sudo systemctl status containerd --no-pager
```

## Post-Install Validation

Validated on 2026-06-30:

| Check | Result |
| --- | --- |
| Docker package source | Docker official apt repository for Ubuntu Noble |
| `docker.service` | Active and enabled |
| `containerd.service` | Active and enabled |
| Docker Engine | `29.6.1` |
| Docker CLI | `29.6.1` |
| Docker Compose plugin | `v5.2.0`; upgraded to package `5.3.0-1~ubuntu.24.04~noble` during 2026-07-06 package maintenance; post-reboot validation pending |
| `hello-world` image pull | Pass |
| `hello-world` container run | Pass |
| `docker info` | Pass |
| `docker ps -a` | Pass |
| `docker images` | Pass |
| `docker network ls` | Pass |
| `docker volume ls` | Pass |
| Non-root Docker API access | Denied as expected; `michael` has not been added to the `docker` group |

Validated runtime inventory:

| Area | Result |
| --- | --- |
| Containers | 1 total, 0 running, 0 paused, 1 stopped |
| Images | 1 image: `hello-world:latest` |
| Storage driver | `overlayfs` |
| Logging driver | `json-file` |
| Cgroup driver | `systemd` |
| Cgroup version | 2 |
| Default runtime | `runc` |
| Security options | `apparmor`, `seccomp`, `cgroups` |
| Kernel | `6.8.0-124-generic` |
| OS | Ubuntu 24.04.4 LTS |
| Architecture | `x86_64` |
| CPUs | 2 |
| Memory | 3.824GiB |
| Docker root dir | `/var/lib/docker` |
| Firewall backend | `iptables` |
| Default Docker networks | `bridge`, `host`, `none` |
| Docker volumes | None |

Screenshot evidence:

- `systemctl status docker --no-pager`
- `systemctl status containerd --no-pager`
- `sudo docker version`
- `sudo docker compose version`
- `sudo docker run hello-world`
- `sudo docker info`
- `sudo docker ps -a`
- `sudo docker images`
- `sudo docker network ls`
- `sudo docker volume ls`

Optional non-root Docker access decision:

```bash
sudo usermod -aG docker michael
```

Important: adding `michael` to the `docker` group grants root-level Docker control. In a real company, this should be approved, documented, and limited to administrators who need it.

After changing group membership, log out and back in, then validate:

```bash
groups
docker run hello-world
```

Current access-control decision:

- Keep Docker administration sudo-only for now.
- Do not add `michael` to the `docker` group until there is a clear operational need.
- This is the more conservative enterprise posture because Docker daemon access can become host-level administrative access.

## Workstation Docker Desktop Note

The Windows workstation also has Docker Desktop installed.

| Environment | Docker Role | Version / Context |
| --- | --- | --- |
| Windows workstation | Local development and desktop container tooling | Docker CLI `29.5.3`; active context `desktop-linux` |
| `LINUX01` | Server-side Docker Engine baseline for homelab infrastructure | Docker Engine `29.6.1`; Compose plugin originally `v5.2.0`; package upgraded to `5.3.0-1~ubuntu.24.04~noble` on 2026-07-06 |

These are intentionally separate environments. Docker Desktop is useful for local development on the workstation, while Docker Engine on `LINUX01` is the server runtime used for infrastructure services, monitoring tools, reverse proxies, and future automation platforms.

## Phase 12 Package Maintenance Note

Date performed: 2026-07-06 UTC

- `docker-compose-plugin` upgraded from `5.2.0-1~ubuntu.24.04~noble` to `5.3.0-1~ubuntu.24.04~noble`.
- No containers needed restart according to the upgrade output.
- Validate Docker and Portainer after reboot before beginning the Samba change.

Post-reboot validation:

```bash
systemctl status docker --no-pager
systemctl status containerd --no-pager
docker compose version
sudo docker ps
sudo docker volume ls
sudo docker network ls
```

Post-reboot result:

Date validated: 2026-07-06 UTC

- `docker.service` is active and enabled.
- `containerd.service` is active and enabled.
- Docker Compose reports `v5.3.0`.
- Portainer container is running from image `portainer/portainer-ce:sts`.
- Portainer is publishing `9443/tcp`.
- Docker runtime is healthy enough to proceed with Phase 12.1 Samba, which is not a container workload.

## Troubleshooting Methodology

If Docker does not install:

- Confirm NAT/internet path with `ping -c 4 ubuntu.com`.
- Confirm DNS with `resolvectl status`.
- Confirm repository file with `cat /etc/apt/sources.list.d/docker.sources`.
- Confirm GPG key permissions with `ls -l /etc/apt/keyrings/docker.asc`.
- Run `sudo apt update` and read the first error, not the last summary line.

If Docker installs but does not start:

- Check `sudo systemctl status docker --no-pager`.
- Check `sudo journalctl -u docker --no-pager -n 100`.
- Check disk space with `df -h / /var`.
- Confirm containerd is running with `sudo systemctl status containerd --no-pager`.

If `docker run hello-world` fails:

- Confirm daemon access with `sudo docker info`.
- Confirm internet image pull path with `sudo docker pull hello-world`.
- Confirm Docker Hub DNS resolution.
- Check whether proxy, firewall, or DNS settings are blocking outbound HTTPS.

## Rollback

Package rollback:

```bash
sudo apt purge docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras
sudo apt autoremove
```

Repository rollback:

```bash
sudo rm /etc/apt/sources.list.d/docker.sources
sudo rm /etc/apt/keyrings/docker.asc
sudo apt update
```

Data cleanup only if intentionally removing all Docker images, containers, volumes, and networks:

```bash
sudo rm -rf /var/lib/docker
sudo rm -rf /var/lib/containerd
```

VM rollback:

- Restore the pre-change VM snapshot if package rollback fails or host networking is damaged.

## Evidence To Capture

- `docker version`
- `docker info`
- `docker compose version`
- `systemctl status docker`
- `systemctl status containerd`
- `docker run hello-world`
- `docker ps -a`
- `docker images`
- Screenshot or command-output summary showing successful container execution.

## Interview Relevance

This phase proves Linux package management, vendor repository setup, service management with systemd, container runtime validation, least-privilege thinking, troubleshooting discipline, and production-style rollback planning.

## Useful Commands

```bash
docker version
docker info
docker ps
docker images
docker compose version
docker network ls
docker volume ls
docker logs <container>
docker inspect <container-or-image>
```

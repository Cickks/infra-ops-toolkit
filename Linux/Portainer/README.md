# Portainer

Use this folder for Portainer setup, Docker management evidence, and container administration notes for `LINUX01`.

## Phase 11.7 Portainer

Status: Complete

Date started: 2026-06-30

Date validated: 2026-06-30

Host: `LINUX01`

Objective:

- Deploy Portainer Community Edition on `LINUX01`.
- Manage the local Docker Engine through the Portainer web UI.
- Validate container, image, network, volume, and stack visibility.
- Document management-plane risk, rollback, troubleshooting, and interview relevance.

Why this matters in a real company:

- Container platforms need management, visibility, and controlled access.
- Portainer gives administrators a web UI for Docker resources, which helps with operations, troubleshooting, and training.
- Portainer also increases risk because it can control Docker through `/var/run/docker.sock`; protecting Portainer is protecting the Docker host.

## Phase 11.6 Prerequisites

| Requirement | Status |
| --- | --- |
| `LINUX01` reachable over SSH | Complete |
| Docker Engine installed | Complete, Docker Engine `29.6.1` |
| Docker Compose plugin installed | Complete, Compose plugin `v5.2.0` |
| Docker service state | `docker.service` active and enabled |
| Container runtime validation | Complete, `hello-world` passed |
| Docker access model | Sudo-only; `michael` is not in the `docker` group |

## Pre-Change Validation

Run on `LINUX01` before deployment:

```bash
sudo docker ps -a
sudo docker images
sudo docker network ls
sudo docker volume ls
sudo ss -tulpn
```

Confirm:

- Port `9443` is not already in use.
- No existing `portainer` container exists.
- No existing `portainer_data` volume exists unless this is a restore or redeploy.
- Docker still works with `sudo`.

## Deployment Choice

Use Docker Compose instead of a one-line `docker run` command.

Reason:

- Compose creates a repeatable deployment definition.
- The configuration can be documented and reviewed.
- Future changes, upgrades, and rollback are easier to understand.

Security decision:

- Expose only HTTPS port `9443`.
- Do not expose port `8000` because Edge Agent tunnel features are not part of Phase 11.7.
- Do not expose legacy HTTP port `9000`.
- Use Portainer's default self-signed certificate for the initial lab validation.

Official reference:

- Portainer CE Docker Standalone Linux install: `https://docs.portainer.io/start/install-ce/server/docker/linux`

## Deployment Commands

Run on `LINUX01` from a dedicated folder such as `~/portainer`:

```bash
mkdir -p ~/portainer
cd ~/portainer
```

Create `portainer-compose.yaml`:

```yaml
services:
  portainer:
    container_name: portainer
    image: portainer/portainer-ce:sts
    restart: always
    ports:
      - "9443:9443"
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
      - portainer_data:/data

volumes:
  portainer_data:
    name: portainer_data

networks:
  default:
    name: portainer_network
```

Deploy:

```bash
sudo docker compose -f portainer-compose.yaml up -d
```

## Post-Deployment Validation

Validated on 2026-06-30:

| Check | Result |
| --- | --- |
| Portainer image | `portainer/portainer-ce:sts` |
| Container name | `portainer` |
| Container state | Running |
| Persistent volume | `portainer_data` exists |
| Docker network | `portainer_network` exists |
| Published host port | `9443/tcp` |
| Internal container ports | `8000/tcp`, `9000/tcp`, `9443/tcp` |
| Host exposure | Only `9443` is published to the host |
| Windows connectivity | `Test-NetConnection 192.168.56.50 -Port 9443` passed |
| Web UI | Portainer loaded at `https://192.168.56.50:9443` |
| Local Docker environment | Visible and `Up` in Portainer |
| Docker version shown in UI | `29.6.1` |
| Admin login | Working |

Validation note:

- The UI and container output may show internal ports `8000` and `9000`, but they are not published to the host in this deployment. The management surface exposed to the workstation is HTTPS on `9443`.

Run on `LINUX01`:

```bash
sudo docker ps
sudo docker logs portainer --tail 50
sudo docker inspect portainer
sudo docker volume ls
sudo docker network ls
sudo ss -tulpn | grep ':9443'
```

Validate from the Windows workstation:

```powershell
Test-NetConnection 192.168.56.50 -Port 9443
```

Browser validation:

```text
https://192.168.56.50:9443
```

Expected browser behavior:

- A certificate warning is expected because Portainer creates a self-signed certificate by default.
- The first login should show the initial admin setup page.
- Do not store the Portainer admin password in this repository.

## Admin Access Model

Initial decision:

- Create one local Portainer admin account for Phase 11.7.
- Store the password in the user's password manager, not in Git.
- Use Portainer only from the management network for now.
- Do not expose Portainer to the internet.

Security warning:

- Portainer controls Docker through the Docker socket.
- Anyone with Portainer admin access can effectively control the Docker host.
- Treat Portainer admin access like privileged infrastructure access.

## Troubleshooting

If the web UI does not load:

- Confirm the container is running with `sudo docker ps`.
- Check logs with `sudo docker logs portainer --tail 100`.
- Confirm port binding with `sudo ss -tulpn | grep ':9443'`.
- Confirm Windows can reach the management IP with `Test-NetConnection 192.168.56.50 -Port 9443`.
- Confirm the URL uses `https`, not `http`.

If the container exits:

- Check logs.
- Confirm Docker is running.
- Confirm `portainer_data` volume exists.
- Confirm no other service is using `9443`.

If Portainer cannot manage Docker:

- Confirm `/var/run/docker.sock` is mounted into the container.
- Confirm the host Docker daemon is running.
- Review the compose file for the socket volume mapping.

## Rollback

Stop and remove the Portainer container while preserving data:

```bash
sudo docker compose -f portainer-compose.yaml down
```

Remove Portainer data only if intentionally destroying the deployment:

```bash
sudo docker volume rm portainer_data
```

Remove the Portainer image if cleanup is required:

```bash
sudo docker image rm portainer/portainer-ce:sts
```

VM rollback:

- Restore the pre-change VM snapshot if the deployment causes host-level issues.

## Evidence To Capture

- `sudo docker ps` showing `portainer` running.
- `sudo docker logs portainer --tail 50`.
- `sudo docker volume ls` showing `portainer_data`.
- `sudo docker network ls` showing `portainer_network`.
- `sudo ss -tulpn` showing `9443`.
- `Test-NetConnection 192.168.56.50 -Port 9443`.
- Screenshot of the Portainer initial setup page, with no passwords visible.
- Screenshot of the Portainer dashboard showing the local Docker environment.

## Interview Relevance

This phase proves container administration, Docker Compose basics, management UI deployment, service exposure, persistent Docker volumes, privileged socket risk awareness, and production-minded documentation.

Do not store passwords or recovery keys.

## Phase 12 Post-Maintenance Validation

Date validated: 2026-07-06 UTC

After LINUX01 package maintenance and reboot:

- Portainer container `portainer` is running.
- Image: `portainer/portainer-ce:sts`.
- Published port: `9443/tcp`.
- Docker `ps` showed the container up about 2 minutes after reboot.
- Portainer remains internal/management-only for this phase.

Decision:

- Portainer survived the package-maintenance reboot and is not blocking Phase 12.1 Samba.

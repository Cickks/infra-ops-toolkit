# systemd Services

Purpose: document Phase 12 custom Linux service work.

## Objective

Create and manage a simple custom systemd service to understand service lifecycle, logs, startup
behavior, dependencies, and rollback.

## Enterprise Relevance

Modern Linux servers use systemd to manage daemons. Sysadmins must be able to inspect units, modify
service behavior, troubleshoot failed starts, and understand what starts at boot.

## Starter Service Idea

Build a small internal status service or script-based service that writes a timestamped health line
to a log. Keep it simple: the goal is service management, not application complexity.

## Phase 12.4 LINUX01 systemd Heartbeat Service

Date validated: 2026-07-07 UTC

Objective:

- Create a custom `systemd` service on `LINUX01`.
- Run the service as a dedicated non-login service account.
- Validate manual script execution before service registration.
- Validate service start, stop, restart, enablement, journald logging, file logging, and reboot
  persistence.

Systems affected:

| Item            | Value                                                    |
| --------------- | -------------------------------------------------------- |
| Host            | `LINUX01`                                                |
| Service account | `homelabsvc`                                             |
| Script          | `/opt/homelab/scripts/linux01-systemd-heartbeat.sh`      |
| Unit file       | `/etc/systemd/system/linux01-systemd-heartbeat.service`  |
| Log directory   | `/var/log/homelab/systemd`                               |
| Log file        | `/var/log/homelab/systemd/linux01-systemd-heartbeat.log` |
| Service name    | `linux01-systemd-heartbeat.service`                      |

Risk:

- Medium-low. The change created one local service, one service account, one script, and one unit
  file.
- No network ports were opened.
- No Docker, Samba, NFS, SSH, cron, storage, or `INFRA01` configuration was changed.

Pre-change validation:

- `LINUX01` was reachable over SSH.
- Root filesystem had sufficient free space.
- `ssh.service`, `cron.service`, `docker.service`, `smbd.service`, and `nfs-server.service` were
  active.
- `/opt/homelab/scripts` and `/var/log/homelab` existed from earlier Phase 12 work.
- No existing `homelab` custom service conflicted with the planned unit.

Implementation summary:

1. Created or confirmed the `homelabsvc` system account with `/usr/sbin/nologin`.
2. Created `/opt/homelab/scripts`.
3. Created `/var/log/homelab/systemd` owned by `homelabsvc:adm`.
4. Created `/opt/homelab/scripts/linux01-systemd-heartbeat.sh`.
5. Validated shell syntax with `sudo bash -n`.
6. Manually ran the script as `homelabsvc` with `timeout`.
7. Created `/etc/systemd/system/linux01-systemd-heartbeat.service`.
8. Validated the unit with `sudo systemd-analyze verify`.
9. Reloaded systemd with `sudo systemctl daemon-reload`.
10. Started, restarted, stopped, started, and enabled the service.
11. Rebooted `LINUX01` and confirmed the service started automatically.

Unit file:

```ini
[Unit]
Description=Phase 12.4 LINUX01 systemd heartbeat service
Documentation=file:/opt/homelab/scripts/linux01-systemd-heartbeat.sh
After=network-online.target
Wants=network-online.target

[Service]
Type=simple
User=homelabsvc
Group=adm
ExecStart=/opt/homelab/scripts/linux01-systemd-heartbeat.sh
Restart=on-failure
RestartSec=10
StandardOutput=journal
StandardError=journal

NoNewPrivileges=true
PrivateTmp=true
ProtectSystem=full
ProtectHome=true
ReadWritePaths=/var/log/homelab/systemd

[Install]
WantedBy=multi-user.target
```

Validation evidence:

| Check                             | Result    |
| --------------------------------- | --------- |
| Script syntax                     | Passed    |
| Manual script run as `homelabsvc` | Passed    |
| File log write                    | Passed    |
| `systemd-analyze verify`          | Passed    |
| `systemctl start`                 | Passed    |
| `systemctl restart`               | Passed    |
| `systemctl stop`                  | Passed    |
| `systemctl enable`                | Passed    |
| `systemctl is-enabled`            | `enabled` |
| `systemctl is-active`             | `active`  |
| Journald logging                  | Passed    |
| Reboot persistence                | Passed    |

Rollback plan:

```bash
sudo systemctl disable --now linux01-systemd-heartbeat.service
sudo rm /etc/systemd/system/linux01-systemd-heartbeat.service
sudo systemctl daemon-reload
sudo systemctl reset-failed
sudo rm /opt/homelab/scripts/linux01-systemd-heartbeat.sh
sudo rm -f /var/log/homelab/systemd/linux01-systemd-heartbeat.log
sudo rmdir /var/log/homelab/systemd 2>/dev/null || true
```

Do not remove `/var/log/homelab` or `/opt/homelab/scripts` during rollback because earlier Phase
12.3 cron work uses those paths.

Troubleshooting methodology:

- Use `systemd-analyze verify` before loading a new unit.
- Run the script manually as the intended service account before blaming systemd.
- Use absolute paths in `ExecStart`.
- Run `sudo systemctl daemon-reload` after unit changes.
- Check `systemctl status` for lifecycle state.
- Check `journalctl -u linux01-systemd-heartbeat.service` for service output.
- Check `/var/log/homelab/systemd/linux01-systemd-heartbeat.log` for application-level output.

Common mistakes:

- Forgetting `daemon-reload` after editing a unit file.
- Confusing `enabled` with `active`.
- Running the service as root when a dedicated account is enough.
- Not validating reboot behavior.
- Not allowing write access when `ProtectSystem=full` is used.

Interview relevance:

- Explains the difference between `active` and `enabled`.
- Shows how to build, harden, validate, and roll back a custom Linux service.
- Demonstrates service accounts, journald, unit-file dependencies, restart policies, and reboot
  validation.

Phase result:

- Phase 12.4 custom systemd services is complete on `LINUX01`.
- `LINUX01` now runs `linux01-systemd-heartbeat.service` as a simple internal service-management
  training artifact.

## Evidence Commands

```bash
systemctl list-unit-files --type=service
sudo systemctl daemon-reload
sudo systemctl status <service-name> --no-pager
sudo systemctl start <service-name>
sudo systemctl stop <service-name>
sudo systemctl restart <service-name>
sudo systemctl enable <service-name>
sudo journalctl -u <service-name> --no-pager
```

## Unit File Checklist

- Clear `Description`.
- Correct `After=` dependencies.
- Least-privilege `User=` when practical.
- Absolute path in `ExecStart=`.
- Restart behavior documented.
- Logs visible in `journalctl`.
- Rollback steps documented.

## Rollback Notes

- Disable the service.
- Stop the service.
- Remove or archive the unit file.
- Run `sudo systemctl daemon-reload`.
- Confirm the service no longer starts at boot.

## Interview Talking Points

- Difference between enabled and active.
- How to troubleshoot `failed` state.
- Why `daemon-reload` is needed after unit changes.
- Where service logs live.
- How systemd improves operational consistency.

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

# Cron

Purpose: document Phase 12 scheduled Linux task work.

## Objective

Create simple scheduled jobs that perform repeatable maintenance or reporting tasks and write logs
that can be validated.

## Enterprise Relevance

Cron jobs are still common for maintenance, reporting, cleanup, backups, and lightweight automation.
Production systems require scheduled jobs to be documented, observable, and reversible.

## Starter Jobs

Good first candidates:

- Daily disk usage report.
- Weekly package update check.
- Daily service health summary.
- Backup dry-run or backup verification report.

Avoid at first:

- Automatic package upgrades without review.
- Destructive cleanup jobs.
- Jobs that delete backups or logs.

## Evidence Commands

```bash
crontab -l
sudo ls -la /etc/cron.d
systemctl status cron --no-pager
sudo journalctl -u cron --since "1 hour ago" --no-pager
ls -la /var/log
```

## Phase 12.3 LINUX01 Health Report

Date validated: 2026-07-06

Objective:

- Create a safe scheduled report on `LINUX01`.
- Prove the script runs manually before scheduling it.
- Validate cron execution using a temporary 5-minute schedule.
- Change the job to a production-style daily schedule after validation.

Systems affected:

| Item      | Value                                                           |
| --------- | --------------------------------------------------------------- |
| Host      | `LINUX01`                                                       |
| Script    | `/opt/homelab/scripts/linux01-health-report.sh`                 |
| Cron file | `/etc/cron.d/linux01-health-report`                             |
| Log file  | `/var/log/homelab/linux01-health-report.log`                    |
| Schedule  | `15 6 * * * root /opt/homelab/scripts/linux01-health-report.sh` |

Pre-change validation:

| Check           | Result                                                        |
| --------------- | ------------------------------------------------------------- |
| Hostname        | `linux01`                                                     |
| OS              | Ubuntu 24.04.4 LTS                                            |
| Kernel          | `6.8.0-134-generic`                                           |
| Time sync       | Enabled                                                       |
| NTP service     | Active                                                        |
| Root filesystem | 24G total, 7.7G used, 15G available, 35% used                 |
| Memory          | 3.8Gi total, about 3.3Gi available                            |
| Cron service    | Active and enabled                                            |
| User crontab    | No crontab for `michael`                                      |
| Existing cron.d | Standard `e2scrub_all`, `.placeholder`, and `sysstat` entries |

Implementation:

1. Created `/opt/homelab/scripts`.
2. Created `/var/log/homelab`.
3. Created `/opt/homelab/scripts/linux01-health-report.sh`.
4. Added script content to collect timestamp, hostname, uptime, disk usage, memory, cron service
   state, Docker service state, and NFS export summary.
5. Validated shell syntax with `sudo bash -n`.
6. Ran the script manually.
7. Confirmed report output in `/var/log/homelab/linux01-health-report.log`.
8. Created `/etc/cron.d/linux01-health-report` with a temporary every-5-minutes validation schedule.
9. Confirmed cron executed the script automatically at `04:30:01`.
10. Changed the cron file to the daily schedule: `15 6 * * *`.

Validation evidence:

| Validation item      | Result             |
| -------------------- | ------------------ |
| Script syntax check  | Passed             |
| Manual script run    | Passed             |
| Log output           | Passed             |
| Temporary cron run   | Passed             |
| Final cron ownership | `root:root`        |
| Final cron mode      | `0644`             |
| Cron service state   | Active and enabled |

Final cron file:

```cron
# Phase 12.3 - LINUX01 daily health report
# Runs daily at 06:15 UTC.
15 6 * * * root /opt/homelab/scripts/linux01-health-report.sh
```

Rollback plan:

```bash
sudo rm /etc/cron.d/linux01-health-report
sudo systemctl status cron --no-pager
sudo journalctl -u cron --since "15 minutes ago" --no-pager
```

Optional cleanup after rollback:

```bash
sudo rm /opt/homelab/scripts/linux01-health-report.sh
sudo rm /var/log/homelab/linux01-health-report.log
```

Troubleshooting methodology:

- Confirm cron service state with `systemctl status cron --no-pager`.
- Confirm cron file ownership is `root:root`.
- Confirm cron file mode is `0644`.
- Confirm the cron line includes the run-as user field when using `/etc/cron.d`.
- Use absolute paths inside scripts.
- Run the script manually before blaming cron.
- Check `journalctl -u cron --since "15 minutes ago" --no-pager`.
- Check the script log file for missing output or command errors.

Common mistakes:

- Forgetting the user field in `/etc/cron.d` entries.
- Leaving validation jobs running every 5 minutes.
- Using relative paths in scripts.
- Assuming a script works under cron because it works in an interactive shell.
- Not logging output anywhere.

Interview relevance:

- Shows the difference between user crontabs and system cron files.
- Demonstrates safe scheduled-job rollout: manual test, temporary schedule, final schedule.
- Shows how to create observable scheduled maintenance.
- Connects Linux automation to real operations work: reporting, backup checks, cleanup, and health
  validation.

## Standard Job Requirements

- Has a clear owner.
- Logs output to a known file.
- Uses absolute paths.
- Handles errors clearly.
- Can be run manually before scheduling.
- Has rollback instructions.

## Interview Talking Points

- Difference between user crontabs and `/etc/cron.d`.
- Why scripts should use absolute paths.
- How to troubleshoot jobs that work manually but fail under cron.
- Why scheduled jobs need logging.

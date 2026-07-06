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

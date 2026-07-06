# Linux Hardening

Use this folder for Linux hardening evidence.

Topics:

- SSH hardening.
- User and sudo review.
- Firewall status.
- Package updates.
- Service minimization.
- Log review.

Useful commands:

```bash
sudo ufw status verbose
sudo passwd -S root
sudo systemctl --type=service --state=running
sudo journalctl -p warning --since today
```

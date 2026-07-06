# SSH

Use this folder for SSH configuration notes and troubleshooting.

Useful commands:

```bash
sudo systemctl status ssh
sudo ss -tulpn | grep ':22'
sudo journalctl -u ssh --no-pager
sudo tail -n 50 /var/log/auth.log
sudo sshd -t
```

Windows client validation:

```powershell
ssh <user>@<LINUX01-IP>
ssh linux01
ssh -V
Test-NetConnection 192.168.56.50 -Port 22
```

## Phase 11.4.8 Validation

Date validated: 2026-06-29

SSH administration is complete for `LINUX01` over the management network.

Confirmed:

- `LINUX01` reachable at `192.168.56.50`.
- TCP port `22` reachable from Windows.
- `ssh.service` active and enabled.
- SSH daemon listening on port `22`.
- SSH public key login successful using `ssh linux01`.
- `/var/log/auth.log` reviewed for accepted public key login and sudo activity.

Deferred to Phase 11.5 Linux Networking:

- DNS/name resolution for `linux01` outside the SSH client config.
- Production network reachability for `192.168.50.50`.
- Interface mapping review for production, management, and NAT adapters.

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

## Phase 12.5 INFRA01 SSH Key Expansion

Date validated: 2026-07-07

SSH key expansion is complete for `INFRA01` on the staging Wi-Fi network.

Confirmed:

- `INFRA01` reachable at `192.168.1.133`.
- TCP port `22` reachable from Windows source `192.168.1.182`.
- Password SSH to `michael@192.168.1.133` worked before key changes.
- Existing Windows public key `id_ed25519.pub` was added to `/home/michael/.ssh/authorized_keys`.
- SSH client alias `infra01` resolves to `192.168.1.133` with user `michael`.
- `ssh -o BatchMode=yes infra01 "hostname; whoami"` returned `infra01` and `michael`.
- `scp` transfer to `INFRA01` succeeded, followed by remote readback and cleanup.
- Safe portfolio sync to `INFRA01` succeeded with `-Targets infra01 -NoRsync`.

Guardrail:

- This was SSH administration readiness only. It did not start Phase 12.0B production readiness and
  did not change `INFRA01` storage, Docker, Portainer, service hosting, or production IP.

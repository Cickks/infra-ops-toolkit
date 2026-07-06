# Troubleshooting

Use this as the standard troubleshooting method across Windows, Linux, networking, cloud, and AI
phases.

## Method

1. Define the expected behavior.
2. Capture the actual behavior.
3. Identify the affected system and scope.
4. Check the simplest dependency first.
5. Change one thing at a time.
6. Validate the fix.
7. Document the root cause.
8. Add prevention or monitoring if appropriate.

## Active Directory Join Failures

Check in order:

1. Client IP address.
2. Gateway.
3. DNS points to `DC01`.
4. `ping DC01`.
5. `nslookup DC01`.
6. Time synchronization.
7. Domain credentials.
8. Existing stale computer account.
9. Domain controller health.

## PowerShell Remoting Failures

Check:

- WinRM service status.
- Firewall rules.
- DNS resolution.
- TrustedHosts only when appropriate.
- Domain authentication.
- Local administrator or delegated permissions.
- Whether the command is running locally or remotely.

## File Share Access Issues

Check:

- Share permissions.
- NTFS permissions.
- Group membership.
- User token refresh or logoff/logon.
- Network path.
- DNS.
- Most restrictive permission wins.

## Linux SSH Issues

Check:

- IP address and route.
- SSH service status.
- Firewall.
- Username.
- Key permissions.
- Password authentication policy.
- Host key changes.

### LINUX01 SSH Troubleshooting Baseline

Date validated: 2026-06-29

Known-good management path:

- Windows management source: `192.168.56.1`
- `LINUX01` management IP: `192.168.56.50`
- SSH alias: `linux01`
- SSH service: active and enabled
- SSH listener: TCP port `22` on IPv4 and IPv6

Validation commands:

```powershell
ping 192.168.56.50
Test-NetConnection 192.168.56.50 -Port 22
ssh linux01
```

```bash
sudo systemctl status ssh
sudo ss -tulpn | grep ':22'
sudo tail -n 50 /var/log/auth.log
sudo sshd -t
```

Observed result:

- `192.168.56.50` responds to ping.
- `Test-NetConnection` to port `22` succeeds.
- SSH public key login from Windows succeeds.
- `ssh.service` is active and enabled.
- `/var/log/auth.log` shows accepted public key authentication and sudo activity.

Open networking finding for Phase 11.5:

- `ping linux01` from PowerShell does not resolve through DNS.
- `192.168.50.50` does not currently respond from the Windows host.
- `LINUX01` login banner shows NAT interface address `10.0.3.15`.
- Treat this as a networking, DNS, routing, or adapter mapping issue, not an SSH service failure.

## Evidence To Capture

- Command used.
- Host where the command ran.
- Error message.
- Root cause.
- Fix.
- Validation result.
- Lesson learned.

## Phase 11.5 DNS And Networking Findings

Date validated: 2026-06-29

Findings:

- The physical workstation originally used home-router/ISP DNS, so `corp.local` names failed unless
  DC01 was specified manually.
- The workstation could not directly reach `192.168.50.0/24`; this is expected because production is
  VM-to-VM only from the host perspective.
- `LINUX01.corp.local` was missing, then briefly had a wrong duplicate A record for `192.168.50.60`.
- Management records initially had duplicate/wrong values pointing to `192.168.56.10`.
- LINUX01 initially allowed the NAT adapter to receive `corp.local` DNS/search-domain influence.
- `DC01.corp.local` had incorrect A records for `10.0.3.15` and `192.168.56.10`.

Fixes:

- Added `LINUX01.corp.local -> 192.168.50.50`.
- Created `*-mgmt.corp.local` management records for server administration.
- Configured the Windows VirtualBox host-only adapter to use DNS server `192.168.56.10` and suffix
  `corp.local`.
- Updated LINUX01 Netplan so `corp.local` is scoped to `enp0s3` and NAT DHCP does not own internal
  DNS domains.
- Removed incorrect duplicate `DC01` and `LINUX01` DNS records.
- Flushed Linux DNS cache and validated production, management, and internet DNS results.

Troubleshooting method proven:

1. Test DNS service reachability on port `53`.
2. Query authoritative DNS directly with `nslookup <name> <server>`.
3. Separate client resolver configuration from server-side DNS records.
4. Separate production names from management names.
5. Validate Linux `resolvectl dns`, `resolvectl domain`, `/etc/hosts`, and Netplan.
6. Flush caches only after confirming authoritative records are corrected.
7. Validate connectivity by interface path: production, management, NAT, and internet.

## Phase 11.9 DNS And WinRM Findings

Date validated: 2026-06-30

Symptoms:

- Ping to `FILE01` management IP initially failed.
- WinRM TCP port `5985` was reachable, but `Invoke-Command` failed when using IP addresses and
  production FQDNs from the physical workstation.
- `Test-WSMan` initially reported trust/authentication or firewall/profile style errors.

Root causes:

- `FILE01` VM was not booted during the first reachability sweep.
- DNS had stale or incorrect records, including NAT `10.0.3.15` answers and management records
  pointing at production IPs.
- The physical workstation did not have a clean Kerberos trust path for IP-based remoting or
  management aliases.

Fixes:

- Booted `FILE01` and confirmed `192.168.56.40` responded to ping.
- Cleaned production DNS names so they resolve to `192.168.50.0/24`.
- Cleaned management DNS names so they resolve to `192.168.56.0/24`.
- Added narrow WinRM TrustedHosts entries on the physical workstation for exact lab management names
  only.
- Used management FQDNs for remote administration from the physical workstation.

Validated results:

- `print01-mgmt.corp.local` returned `PRINT01` through `Invoke-Command`.
- `dhcp01-mgmt.corp.local` returned `DHCP01` through `Invoke-Command`.
- `file01-mgmt.corp.local` returned `FILE01` through `Invoke-Command`.
- `dc01-mgmt.corp.local` returned `DC01` through `Invoke-Command`.
- `Test-WSMan print01-mgmt.corp.local` passed.
- `Test-WSMan dc01-mgmt.corp.local` passed.

Lessons learned:

- TCP `5985` passing proves the port is open, but it does not prove WinRM authentication works.
- Production names and management names must stay separate in DNS.
- NAT addresses should not register as `corp.local` production server identities.
- Use Kerberos and domain-joined admin workstations when possible.
- If TrustedHosts is needed in a lab, scope it narrowly and document the risk.

## Phase 11.9 Linux And Container Health Findings

Date validated: 2026-06-30

Validated results:

- `LINUX01` SSH is reachable from the Windows workstation.
- `ssh.service` on `LINUX01` is active and enabled.
- `docker.service` on `LINUX01` is active and enabled.
- `containerd.service` on `LINUX01` is active and enabled.
- Portainer container is running.
- `portainer_data` volume exists.
- `portainer_network` exists.
- Windows `Test-NetConnection 192.168.56.50 -Port 9443` passed.
- `INFRA01` SSH is reachable from the Windows workstation.
- `INFRA01` remains on staging Wi-Fi IP `192.168.1.133`.
- `INFRA01` storage, memory, SSH service, and package update state are healthy.

Open maintenance note:

- `LINUX01` reports available Ubuntu package updates in the login banner. Handle this as a
  deliberate package-maintenance change with validation and rollback notes.

# DHCP01

Role: DHCP server for the enterprise homelab client scope.

## Portfolio Status

| Item           | Status                                                                               |
| -------------- | ------------------------------------------------------------------------------------ |
| Phase          | Windows infrastructure and network services                                          |
| Area           | DHCP, client addressing, network validation                                          |
| Evidence state | Template ready; add live scope output when available                                 |
| Related docs   | `../../../docs/IP_ADDRESSING.md`, `../../../Documentation/HomeLab/Network/README.md` |

## Notes

- Dynamic client range: `192.168.50.100-192.168.50.199`.
- Server and infrastructure addresses belong in `192.168.50.10-99`.
- Reserved addresses should be excluded from DHCP.
- DHCP validation matters before troubleshooting domain join issues.

## Useful Commands

Run on `DHCP01` or from an admin workstation with DHCP tools:

```powershell
Get-DhcpServerv4Scope
Get-DhcpServerv4ScopeStatistics
Get-DhcpServerv4OptionValue -ScopeId 192.168.50.0
Get-DhcpServerv4Lease -ScopeId 192.168.50.0
Get-DhcpServerv4ExclusionRange -ScopeId 192.168.50.0
Get-DhcpServerInDC
```

Run on a client:

```powershell
ipconfig /all
ipconfig /release
ipconfig /renew
Resolve-DnsName DC01.corp.local
```

## Validation Checklist

- Confirm the DHCP scope is active.
- Confirm clients receive addresses from `192.168.50.100-199`.
- Confirm option values include gateway `192.168.50.1`.
- Confirm DNS option points to `192.168.50.10`.
- Confirm excluded ranges protect static infrastructure IPs.

## Evidence To Capture

- Scope configuration summary.
- Lease table summary.
- Client `ipconfig /all` after renewal.
- Screenshot or notes showing DNS and gateway options.

## Rollback

- Disable a misconfigured scope.
- Restore previous scope options.
- Remove incorrect reservations or exclusions.
- Revert VM snapshot only if DHCP service configuration cannot be repaired.

## Interview Relevance

This proves understanding of DHCP scopes, client addressing, DNS dependency, and network-first
troubleshooting.

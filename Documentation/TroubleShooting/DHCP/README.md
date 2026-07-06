# DHCP Troubleshooting

Use this folder for DHCP troubleshooting notes.

Record symptoms, affected clients, lease checks, scope checks, root cause, fix, validation,
prevention, and interview relevance.

## Common Checks

```powershell
Get-DhcpServerv4Scope
Get-DhcpServerv4ScopeStatistics
Get-DhcpServerv4Lease -ScopeId 192.168.50.0
Get-DhcpServerv4OptionValue -ScopeId 192.168.50.0
ipconfig /all
ipconfig /renew
```

## Evidence

- Client IP before and after fix.
- Scope status.
- Lease status.
- DNS and gateway options.
- Renewal validation.

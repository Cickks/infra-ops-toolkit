# DNS Troubleshooting

Use this folder for DNS troubleshooting notes.

Record symptoms, lookup results, resolver configuration, zone checks, root cause, fix, validation,
prevention, and interview relevance.

## Common Checks

```powershell
ipconfig /all
Get-DnsClientServerAddress
Resolve-DnsName DC01.corp.local
Resolve-DnsName corp.local
Get-DnsServerZone
Get-DnsServerResourceRecord -ZoneName corp.local
```

## Evidence

- Client DNS server setting.
- Failed lookup.
- Corrected lookup.
- DNS zone or record involved.
- Domain join or login validation after fix.

# Networking Troubleshooting

Use this folder for networking troubleshooting notes.

Record symptoms, affected systems, IP configuration, routing, firewall, packet capture, root cause,
fix, validation, prevention, and interview relevance.

## Common Checks

```powershell
ipconfig /all
Get-NetIPConfiguration
Test-Connection 192.168.50.1
Test-Connection 192.168.50.10
Test-NetConnection DC01 -Port 53
tracert 192.168.50.1
nmap -sn 192.168.50.0/24
```

## Evidence

- Source and destination.
- IP, gateway, and DNS settings.
- Ping or port test result.
- Firewall or route involved.
- Packet capture summary when applicable.

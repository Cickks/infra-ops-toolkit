# Monitoring PowerShell

Use this folder for health checks and monitoring scripts.

Useful commands:

```powershell
Get-Service | Where-Object Status -ne Running
Get-EventLog -LogName System -Newest 20
Get-Volume
Test-Connection DC01
```

Monitoring scripts should produce concise, redacted summaries suitable for portfolio evidence.

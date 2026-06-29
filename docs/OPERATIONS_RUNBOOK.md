# Operations Runbook

## Help Desk And Administration Evidence

Documented completed work includes:

- Ticket `#006` Employee Offboarding.
- Ticket `#007` Employee Rehire.
- Ticket `#008` New PC Deployment.

## New PC Deployment Checklist

1. Create the client VM.
2. Install Windows.
3. Verify IP configuration.
4. Verify DNS configuration.
5. Ping `DC01`.
6. Run `nslookup DC01`.
7. Join `corp.local`.
8. Reboot.
9. Log in as the assigned domain user.
10. Verify drive mapping.
11. Verify Group Policy application.
12. Verify share access.
13. Record lessons learned.

## PowerShell Remoting Notes

Run commands on multiple servers:

```powershell
Invoke-Command -ComputerName FILE01,PRINT01,DHCP01 -ScriptBlock {
    Get-ComputerInfo |
        Select-Object WindowsProductName, WindowsVersion, OsBuildNumber
}
```

Verify remote hostnames:

```powershell
Invoke-Command -ComputerName FILE01,PRINT01,DHCP01 -ScriptBlock {
    hostname
}
```

Check disk volumes remotely:

```powershell
Invoke-Command -ComputerName FILE01,PRINT01,DHCP01 -ScriptBlock {
    Get-Volume |
        Select-Object DriveLetter, FileSystem,
            @{Name="SizeGB"; Expression={ [math]::Round($_.Size / 1GB, 2) }},
            @{Name="FreeGB"; Expression={ [math]::Round($_.SizeRemaining / 1GB, 2) }}
}
```

## Lessons Learned

- Never delete users when offboarding.
- Re-enabling accounts preserves permissions.
- Always verify access before closing tickets.
- Verify networking before domain join.
- DNS is critical for Active Directory.
- Test user access before closing a deployment ticket.

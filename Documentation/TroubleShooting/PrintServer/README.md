# Print Server Troubleshooting

Use this folder for print server troubleshooting notes.

Record symptoms, affected printer or client, queue checks, driver checks, permission checks, root cause, fix, validation, prevention, and interview relevance.

## Common Checks

```powershell
Get-Printer
Get-PrinterDriver
Get-PrintJob -PrinterName <PrinterName>
Get-Service Spooler
Restart-Service Spooler
Test-NetConnection PRINT01
```

## Evidence

- Printer name.
- Client affected.
- Queue state.
- Driver version.
- Spooler status.
- Test print result.

# PRINT01

Role: Print services, printer sharing, drivers, queues, and client print validation.

## Portfolio Status

| Item           | Status                                                           |
| -------------- | ---------------------------------------------------------------- |
| Phase          | Help desk and infrastructure operations                          |
| Area           | Print services and client support                                |
| Evidence state | Template ready; add live printer and queue output when available |
| Related docs   | `../../../Documentation/TroubleShooting/PrintServer/README.md`   |

## Notes

- Print issues often involve driver, queue, permission, or network problems.
- Validate from both server and client sides.
- Document printer names, driver versions, and affected clients.

## Useful Commands

Run on `PRINT01`:

```powershell
Get-Printer
Get-PrinterDriver
Get-PrintConfiguration -PrinterName <PrinterName>
Get-PrintJob -PrinterName <PrinterName>
Restart-Service Spooler
```

Run from a client:

```powershell
Get-Printer
Test-NetConnection PRINT01
rundll32 printui.dll,PrintUIEntry /?
```

## Validation Checklist

- Confirm printer is shared.
- Confirm correct driver is installed.
- Confirm a domain user can see or add the printer.
- Confirm test print succeeds.
- Confirm spooler service is running.

## Evidence To Capture

- Printer list.
- Driver list.
- Queue status.
- Client printer connection.
- Troubleshooting notes for failed print jobs.

## Rollback

- Remove incorrect printer mapping.
- Reinstall previous driver.
- Clear stuck jobs only after documenting impact.
- Restart spooler after confirming no critical jobs are lost.

## Interview Relevance

This proves practical help desk troubleshooting, Windows service awareness, and client/server
validation.

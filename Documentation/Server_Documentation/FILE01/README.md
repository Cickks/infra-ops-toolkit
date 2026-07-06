# FILE01

Role: File services, shared storage, NTFS permissions, and access validation.

## Portfolio Status

| Item | Status |
| --- | --- |
| Phase | Help desk and infrastructure operations |
| Area | File shares, permissions, access testing |
| Evidence state | Template ready; add live share and permission output when available |
| Related docs | `../../../docs/OPERATIONS_RUNBOOK.md`, `../../../Documentation/TroubleShooting/FileServer/README.md` |

## Notes

- Share permissions and NTFS permissions both matter.
- The most restrictive effective permission wins.
- Group-based access is preferred over assigning permissions directly to users.
- Test as the target user before closing a ticket.

## Useful Commands

Run on `FILE01`:

```powershell
Get-SmbShare
Get-SmbShareAccess -Name <ShareName>
Get-Acl "D:\Shares\<ShareName>" | Format-List
Get-LocalGroup
Get-EventLog -LogName System -Newest 20
```

Run from a client:

```powershell
Test-NetConnection FILE01 -Port 445
net use
net use Z: \\FILE01\<ShareName>
whoami /groups
```

## Validation Checklist

- Confirm the file share exists.
- Confirm intended AD groups have access.
- Confirm unauthorized users are denied.
- Confirm mapped drive or UNC path works from a domain client.
- Confirm permissions are documented before and after changes.

## Evidence To Capture

- Share list summary.
- NTFS permission summary.
- User/group access validation.
- Failed access screenshot for unauthorized user when appropriate.

## Rollback

- Restore previous ACLs from documented state.
- Remove accidental direct user permissions.
- Disable or remove an incorrectly created share.
- Restore from backup if data is changed or removed.

## Interview Relevance

This proves file server administration, permission troubleshooting, least privilege, and validation from the user perspective.

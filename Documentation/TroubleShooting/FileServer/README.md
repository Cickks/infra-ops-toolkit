# File Server Troubleshooting

Use this folder for file server troubleshooting notes.

Record symptoms, affected share or user, permission checks, connectivity checks, root cause, fix, validation, prevention, and interview relevance.

## Common Checks

```powershell
Test-NetConnection FILE01 -Port 445
Get-SmbShare
Get-SmbShareAccess -Name <ShareName>
Get-Acl "D:\Shares\<ShareName>"
whoami /groups
net use
```

## Evidence

- Affected user and group.
- Share permissions.
- NTFS permissions.
- Access denied message.
- Successful access after fix.

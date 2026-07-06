# File Server PowerShell

Use this folder for file share and permission scripts.

Useful commands:

```powershell
Get-SmbShare
Get-SmbShareAccess -Name <ShareName>
Get-Acl "D:\Shares\<ShareName>"
Test-NetConnection FILE01 -Port 445
```

Prefer group-based permissions and record before/after ACL summaries.

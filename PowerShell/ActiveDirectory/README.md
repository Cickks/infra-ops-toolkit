# Active Directory PowerShell

Use this folder for AD administration scripts and command notes.

Useful commands:

```powershell
Get-ADUser -Filter *
Get-ADGroup -Filter *
Get-ADOrganizationalUnit -Filter *
Disable-ADAccount -Identity <SamAccountName>
Enable-ADAccount -Identity <SamAccountName>
Get-ADPrincipalGroupMembership <SamAccountName>
```

Do not store passwords or live credentials in scripts.

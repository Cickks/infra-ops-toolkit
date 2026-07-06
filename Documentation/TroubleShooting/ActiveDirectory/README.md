# Active Directory Troubleshooting

Use this folder for Active Directory troubleshooting notes.

Record symptoms, affected systems, checks performed, root cause, fix, validation, prevention, and
interview relevance.

## Common Checks

```powershell
Get-ADDomain
Get-ADUser <SamAccountName> -Properties Enabled, LockedOut, LastLogonDate
Get-ADPrincipalGroupMembership <SamAccountName>
dcdiag /v
repadmin /replsummary
nltest /dsgetdc:corp.local
```

## Evidence

- Error message.
- User or computer affected.
- AD object status.
- DNS/domain controller validation.
- Fix applied.
- Successful login or access test.

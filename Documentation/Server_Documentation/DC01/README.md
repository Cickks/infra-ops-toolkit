# DC01

Role: Active Directory Domain Services, DNS, Kerberos, identity baseline, OUs, users, groups, and
domain authentication.

## Portfolio Status

| Item           | Status                                                                                                 |
| -------------- | ------------------------------------------------------------------------------------------------------ |
| Phase          | 1 and 2                                                                                                |
| Area           | Windows Server and Active Directory                                                                    |
| Evidence state | Documented baseline; add live command output and screenshots when available                            |
| Related docs   | `../../../docs/SERVER_INVENTORY.md`, `../../../Documentation/HomeLab/Architecture/NETWORK_BASELINE.md` |

## Notes

- `DC01` is the primary identity and DNS anchor for `corp.local`.
- Domain DNS should point clients to `192.168.50.10`.
- AD changes should be group-based, documented, and validated before closing a ticket.
- Never delete users for normal offboarding; disable accounts and preserve audit history.

## Useful Commands

Run on `DC01` or from an admin workstation with RSAT:

```powershell
Get-ADDomain
Get-ADForest
Get-ADDomainController -Filter *
Get-ADOrganizationalUnit -Filter * | Select-Object Name, DistinguishedName
Get-ADUser -Filter * -Properties Enabled, LastLogonDate | Select-Object Name, SamAccountName, Enabled, LastLogonDate
Get-ADGroup -Filter * | Select-Object Name, GroupScope, GroupCategory
Get-DnsServerZone
Resolve-DnsName DC01.corp.local
dcdiag /v
repadmin /replsummary
```

## Validation Checklist

- Confirm `DC01` has a static IP of `192.168.50.10`.
- Confirm clients use `DC01` for DNS.
- Confirm `corp.local` resolves from a domain client.
- Confirm a test user can authenticate.
- Confirm OUs, users, and groups match the documented admin scenarios.
- Confirm no passwords, recovery keys, or private identifiers appear in screenshots.

## Evidence To Capture

- `Get-ADDomain` summary.
- OU structure screenshot or command summary.
- User lifecycle evidence for offboarding and rehire.
- Group membership validation.
- DNS zone summary.
- Domain client login validation.

## Rollback

- Revert accidental user/group changes from documented prior state.
- Restore deleted objects from AD Recycle Bin if enabled.
- Revert DNS record changes.
- Restore from VM snapshot only when configuration rollback is not enough.

## Interview Relevance

This proves Active Directory administration, DNS awareness, identity lifecycle handling, and
production-minded validation.

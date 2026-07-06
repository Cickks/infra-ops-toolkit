# Client Workstation Evidence

Use this folder for domain-joined client workstation documentation.

Record one note per meaningful client scenario, such as:

- New PC deployment.
- Domain join validation.
- User login validation.
- Group policy validation.
- Shared drive or printer access.
- Help desk ticket evidence.

Each client note should include the client hostname, assigned user or test account, objective, steps performed, validation result, screenshots or command summaries, problems encountered, and lessons learned.

## Standard Client Commands

Run on a Windows client:

```powershell
hostname
whoami
whoami /groups
ipconfig /all
Test-Connection DC01
Resolve-DnsName DC01.corp.local
gpresult /r
net use
```

Domain join validation:

```powershell
Get-ComputerInfo | Select-Object CsName, CsDomain, CsPartOfDomain
nltest /dsgetdc:corp.local
```

## Evidence Checklist

- Hostname.
- IP configuration.
- DNS points to `DC01`.
- Domain join result.
- Domain user login.
- Group Policy result.
- Share or printer access.
- Ticket number or scenario.
- Problems encountered and fix.
- Interview relevance.

## Example Scenario Notes

| Scenario | Evidence |
| --- | --- |
| New PC deployment | Client build, domain join, user login, mapped drive, GPO result |
| Offboarding validation | Disabled account cannot log in |
| Rehire validation | Re-enabled account can log in and access required resources |

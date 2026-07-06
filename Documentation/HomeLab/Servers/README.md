# Server Documentation

Use this folder for homelab server evidence and cross-server notes.

Core systems:

| Host | Role |
| --- | --- |
| `DC01` | Active Directory Domain Services, DNS, Kerberos |
| `DHCP01` | DHCP server |
| `FILE01` | File server |
| `PRINT01` | Print server |
| `LINUX01` | Linux administration host |
| `INFRA01` | Future infrastructure services |

Server-specific notes may also live under `../../Server_Documentation/` when a folder already exists for the host.

For each server, record objective, configuration steps, validation commands, screenshots or command-output summaries, problems encountered, rollback plan, lessons learned, and interview relevance.

## Server Command Routing

| Host | Documentation |
| --- | --- |
| `DC01` | `../../Server_Documentation/DC01/README.md` |
| `DHCP01` | `../../Server_Documentation/DHCP01/README.md` |
| `FILE01` | `../../Server_Documentation/FILE01/README.md` |
| `PRINT01` | `../../Server_Documentation/PRINT01/README.md` |
| `LINUX01` | `../../Server_Documentation/LINUX01/README.md` |
| `INFRA01` | `../../Server_Documentation/INFRA01/README.md` |

## Cross-Server Commands

PowerShell Remoting validation:

```powershell
Invoke-Command -ComputerName FILE01,PRINT01,DHCP01 -ScriptBlock { hostname }
Invoke-Command -ComputerName FILE01,PRINT01,DHCP01 -ScriptBlock {
    Get-ComputerInfo | Select-Object WindowsProductName, WindowsVersion, OsBuildNumber
}
```

Basic reachability:

```powershell
Test-Connection DC01
Test-Connection DHCP01
Test-Connection FILE01
Test-Connection PRINT01
Resolve-DnsName DC01.corp.local
```

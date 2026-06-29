# Server And Client Inventory

This inventory captures known systems from the homelab master plan. Update it when hosts are added, renamed, rebuilt, or retired.

## Core Domain

| Item | Value |
| --- | --- |
| Domain | `corp.local` |
| Subnet | `192.168.50.0/24` |
| Gateway | `192.168.50.1` |
| Primary DNS | `192.168.50.10` |

## Servers

| Host | IP | Role | Status | Notes |
| --- | --- | --- | --- | --- |
| `DC01` | `192.168.50.10` | Active Directory, DNS, Kerberos | Active | Domain foundation |
| `DHCP01` | TBD | DHCP server | Active/Planned | Serves client scope `192.168.50.100-199` |
| `FILE01` | TBD | File server | Active/Planned | Used in PowerShell Remoting validation |
| `PRINT01` | TBD | Print server | Active/Planned | Used in PowerShell Remoting validation |
| `LINUX01` | TBD | Linux administration host | In Progress | Current Phase 11 focus |
| `INFRA01` | TBD | Infrastructure services | Planned/Unknown | Confirm role before documenting |

## Clients

| Host | Purpose | Status | Notes |
| --- | --- | --- | --- |
| `CLIENT04` | New PC deployment evidence | Complete | Joined to `corp.local`; used for Ticket `#008` |
| `CLIENTxx` | Domain workstations | Ongoing | Add each client as it becomes portfolio evidence |

## User And Group Evidence

| Account | Scenario | Evidence |
| --- | --- | --- |
| `finance.emily` | Offboarding and rehire | Disabled, login denied, re-enabled, group membership verified |
| `sales.jason` | New PC deployment | Created, Sales permissions assigned, login and share access verified |

## Maintenance Rules

- Keep IPs aligned with `docs/IP_ADDRESSING.md`.
- Record whether systems are active, planned, retired, or rebuilt.
- Include validation evidence before marking a host complete.
- Do not store passwords or recovery keys in this inventory.

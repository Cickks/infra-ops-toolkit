# Server And Client Inventory

This inventory captures known systems from the homelab master plan. Update it when hosts are added,
renamed, rebuilt, or retired.

## Core Domain

| Item        | Value             |
| ----------- | ----------------- |
| Domain      | `corp.local`      |
| Subnet      | `192.168.50.0/24` |
| Gateway     | `192.168.50.1`    |
| Primary DNS | `192.168.50.10`   |

## Servers

| Host      | IP                                                             | Role                                                                    | Status         | Notes                                                                                            |
| --------- | -------------------------------------------------------------- | ----------------------------------------------------------------------- | -------------- | ------------------------------------------------------------------------------------------------ |
| `DC01`    | `192.168.50.10`                                                | Active Directory, DNS, Kerberos                                         | Active         | Domain foundation                                                                                |
| `DHCP01`  | TBD                                                            | DHCP server                                                             | Active/Planned | Serves client scope `192.168.50.100-199`                                                         |
| `FILE01`  | TBD                                                            | File server                                                             | Active/Planned | Used in PowerShell Remoting validation                                                           |
| `PRINT01` | TBD                                                            | Print server                                                            | Active/Planned | Used in PowerShell Remoting validation                                                           |
| `LINUX01` | Mgmt: `192.168.56.50`; Prod: `192.168.50.50`; NAT: `10.0.3.15` | Linux administration, Docker, Portainer, and Phase 12 self-hosting host | In Progress    | Phase 12 kickoff active; shared services and backup baseline next                                |
| `INFRA01` | Staging Wi-Fi: `192.168.1.133`; Future prod: `192.168.50.60`   | Raspberry Pi infrastructure services host                               | Active/Staging | Phase 11.8 prep complete; SSH validated; microSD storage; future SSD before write-heavy services |

## Clients

| Host       | Purpose                    | Status   | Notes                                            |
| ---------- | -------------------------- | -------- | ------------------------------------------------ |
| `CLIENT04` | New PC deployment evidence | Complete | Joined to `corp.local`; used for Ticket `#008`   |
| `CLIENTxx` | Domain workstations        | Ongoing  | Add each client as it becomes portfolio evidence |

## User And Group Evidence

| Account         | Scenario               | Evidence                                                             |
| --------------- | ---------------------- | -------------------------------------------------------------------- |
| `finance.emily` | Offboarding and rehire | Disabled, login denied, re-enabled, group membership verified        |
| `sales.jason`   | New PC deployment      | Created, Sales permissions assigned, login and share access verified |

## Maintenance Rules

- Keep IPs aligned with `docs/IP_ADDRESSING.md`.
- Record whether systems are active, planned, retired, or rebuilt.
- Include validation evidence before marking a host complete.
- Do not store passwords or recovery keys in this inventory.

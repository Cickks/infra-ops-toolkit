# Network Baseline

## Domain

| Item | Value |
| --- | --- |
| Domain | `corp.local` |
| Subnet | `192.168.50.0/24` |
| Default gateway | `192.168.50.1` |
| Primary DNS | `192.168.50.10` (`DC01`) |

## Addressing Strategy

| Range | Purpose |
| --- | --- |
| `192.168.50.1-9` | Network infrastructure, gateway, switches, and future appliances |
| `192.168.50.10-99` | Enterprise servers and infrastructure |
| `192.168.50.100-199` | Client workstations |
| `192.168.50.200-254` | Future expansion and lab growth |

## Core Hosts

| Host | Role | Status |
| --- | --- | --- |
| `DC01` | Active Directory Domain Services, DNS, Kerberos | Active |
| `DHCP01` | DHCP scope and address leasing | Active/Planned |
| `FILE01` | File services and shared storage | Active/Planned |
| `PRINT01` | Print services | Active/Planned |
| `LINUX01` | Linux administration fundamentals | In Progress |
| `INFRA01` | Raspberry Pi infrastructure services staging host | Active/Staging |

## Current Network Validation Notes

Date validated: 2026-06-29

`LINUX01` currently has a confirmed management path:

| Network | Address | Status | Notes |
| --- | --- | --- | --- |
| Management | `192.168.56.50` | Working | Ping and TCP `22` reachable from Windows source `192.168.56.1` |
| Production | `192.168.50.50` | Working internally | Reachable VM-to-VM from DC01; not directly reachable from physical host by design |
| NAT/Internet | `10.0.3.15` | Present | Shown in Ubuntu login banner for interface `enp0s8` |

Phase 11.5 validated adapter mapping, Netplan configuration, routing, DNS, and separate production versus management naming.

## Operating Rule

Before joining clients or adding new services, validate IP address, DNS, gateway, and domain resolution.

## Phase 11.5 Validated Network Design

Date validated: 2026-06-29

| Plane | Subnet | Access Model | Notes |
| --- | --- | --- | --- |
| Production | `192.168.50.0/24` | VM-to-VM server traffic | Production DNS names resolve here, such as `DC01.corp.local -> 192.168.50.10` and `LINUX01.corp.local -> 192.168.50.50` |
| Management | `192.168.56.0/24` | Physical host to servers | Management DNS names resolve here, such as `dc01-mgmt.corp.local -> 192.168.56.10` and `linux01-mgmt.corp.local -> 192.168.56.50` |
| NAT/Internet | `10.0.3.0/24` | Internet/package access | LINUX01 uses DHCP NAT for updates while internal DNS remains scoped to DC01 |

LINUX01 interface mapping:

| Interface | Address | Plane |
| --- | --- | --- |
| `enp0s3` | `192.168.50.50/24` | Production |
| `enp0s8` | `10.0.3.15/24` | NAT/Internet |
| `enp0s9` | `192.168.56.50/24` | Management |

Validated management records:

| Name | Address |
| --- | --- |
| `dc01-mgmt.corp.local` | `192.168.56.10` |
| `print01-mgmt.corp.local` | `192.168.56.20` |
| `dhcp01-mgmt.corp.local` | `192.168.56.30` |
| `file01-mgmt.corp.local` | `192.168.56.40` |
| `linux01-mgmt.corp.local` | `192.168.56.50` |

DNS cleanup completed:

- `LINUX01.corp.local` corrected to `192.168.50.50`.
- Incorrect `LINUX01 -> 192.168.50.60` removed.
- `DC01.corp.local` corrected to `192.168.50.10` for IPv4.
- Incorrect `DC01 -> 10.0.3.15` and `DC01 -> 192.168.56.10` records removed.
- IPv6 AAAA record for DC01 remains present but IPv4 is the operating standard for this phase.

## Phase 11.9 Management DNS Revalidation

Date validated: 2026-06-30

Production names should resolve only to production server IPs:

| Name | Address |
| --- | --- |
| `DC01.corp.local` | `192.168.50.10` |
| `PRINT01.corp.local` | `192.168.50.20` |
| `DHCP01.corp.local` | `192.168.50.30` |
| `FILE01.corp.local` | `192.168.50.40` |
| `LINUX01.corp.local` | `192.168.50.50` |

Management names should resolve only to management server IPs:

| Name | Address |
| --- | --- |
| `dc01-mgmt.corp.local` | `192.168.56.10` |
| `print01-mgmt.corp.local` | `192.168.56.20` |
| `dhcp01-mgmt.corp.local` | `192.168.56.30` |
| `file01-mgmt.corp.local` | `192.168.56.40` |
| `linux01-mgmt.corp.local` | `192.168.56.50` |

Management WinRM validation from physical workstation:

| Host | Result |
| --- | --- |
| `DC01` | `Invoke-Command` returned `DC01` using `dc01-mgmt.corp.local` |
| `PRINT01` | `Invoke-Command` returned `PRINT01` using `print01-mgmt.corp.local` |
| `DHCP01` | `Invoke-Command` returned `DHCP01` using `dhcp01-mgmt.corp.local` |
| `FILE01` | `Invoke-Command` returned `FILE01` using `file01-mgmt.corp.local` |

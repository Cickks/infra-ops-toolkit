# IP Addressing Standard

## Domain Information

| Item               | Value                    |
| ------------------ | ------------------------ |
| Domain             | `corp.local`             |
| Network subnet     | `192.168.50.0/24`        |
| Default gateway    | `192.168.50.1`           |
| Primary DNS server | `192.168.50.10` (`DC01`) |

## Enterprise IP Allocation Strategy

| Range                | Purpose                                                      |
| -------------------- | ------------------------------------------------------------ |
| `192.168.50.1-9`     | Network infrastructure, gateway, switches, future appliances |
| `192.168.50.10-99`   | Enterprise servers and infrastructure                        |
| `192.168.50.100-199` | Client workstations                                          |
| `192.168.50.200-254` | Future expansion and lab growth                              |

## DHCP Scope

| Item          | Value                           |
| ------------- | ------------------------------- |
| DHCP server   | `DHCP01`                        |
| Dynamic scope | `192.168.50.100-192.168.50.199` |

Reserved IP addresses should be excluded from DHCP.

## Operational Notes

- DNS is critical for Active Directory.
- Validate IP, DNS, and gateway before joining clients to the domain.
- Keep server IP assignments documented before adding new services.

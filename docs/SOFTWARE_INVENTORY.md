# Software Inventory

This inventory tracks software needed for the enterprise homelab master plan.

Large binaries are stored locally for lab use but ignored by Git. Commit this inventory, not the binaries.

## Downloaded Local Installers

| Tool | Version | Purpose | Folder | Source | SHA256 |
| --- | --- | --- | --- | --- | --- |
| Terraform | 1.15.7 Windows AMD64 | Future cloud, automation, and infrastructure-as-code phases | `Automation/Terraform/` | `https://releases.hashicorp.com/terraform/1.15.7/terraform_1.15.7_windows_amd64.zip` | `1644891F1D02DEA989DAED9A39C564EBDC80E13C9A7E42E713FBA84D7F53B8F6` |
| Sysinternals Suite | Current Microsoft download | Windows troubleshooting, security, and admin operations | `Windows/Sysinternals/` | `https://download.sysinternals.com/files/SysinternalsSuite.zip` | `A1EB712AC33FB10CEB01974DFADBC0E0079C18142BBFBBC49432FD3F0B40999C` |
| Windows Admin Center | Current Microsoft download | Server administration and Windows infrastructure management | `Windows/AdminCenter/` | `https://aka.ms/WACdownload` | `3E213FBEF3186A268CABDAF3974AA7A9EE00976BCE9EA6C865B7035151309AD9` |

## Existing Local Toolkit Software

| Tool | Folder | Purpose |
| --- | --- | --- |
| Rufus | `Documentation/Downloads/` | Bootable USB creation |
| Ventoy | `Documentation/Downloads/ventoy-1.1.12-windows/` | Multi-ISO boot media |
| Ubuntu Server ISO | `ISOs/Linux/` | `LINUX01` and Linux administration fundamentals |
| Debian Netinst ISO | `ISOs/Linux/` | Linux administration practice |
| Kali Linux ISO | `ISOs/Linux/` | Cybersecurity and security tooling practice |
| pfSense installer | `ISOs/Networking/`, `Networking/pfSense/` | Firewall and networking phase |
| OPNsense image | `ISOs/Networking/`, `Networking/OPNsense/` | Firewall and networking phase |
| Nmap installer | `Networking/Nmap/` | Network discovery and validation |
| Wireshark installer | `Networking/Wireshark/` | Packet capture and network troubleshooting |
| PuTTY installer | `Networking/Putty/` | SSH client for Linux and network administration |
| Cisco Packet Tracer installer | `Networking/PacketTracer/` | Network design and simulation |
| Raspberry Pi Imager | `Linux/RaspberryPi/` | Raspberry Pi and edge lab work |

## Installed On Workstation

These tools were detected on the workstation and do not need duplicate local installer downloads yet:

| Tool | Detected Version | Notes |
| --- | --- | --- |
| Git | 2.52.0.windows.1 | Repository and portfolio workflow |
| PowerShell | 7.6.3 | Admin scripting and automation |
| Azure CLI | 2.80.0 | Cloud phase; workstation reports available updates |
| Docker Desktop / Docker CLI | 29.5.3 | Workstation local container development; active context `desktop-linux` |

## Installed On LINUX01

| Tool | Detected Version | Notes |
| --- | --- | --- |
| Docker Engine | 29.6.1 | Server-side container runtime installed from Docker official Ubuntu Noble repository |
| Docker Compose plugin | v5.2.0 | Compose workflow support on `LINUX01` |

## Download Rules

- Download from official vendor sources only.
- Store installers in the folder that matches the phase or technology area.
- Record version, source URL, date, purpose, and SHA256.
- Do not commit large binaries unless explicitly approved.
- Update `README.md`, `SETUP.md`, and this inventory when adding new software.

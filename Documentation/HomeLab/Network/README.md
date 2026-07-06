# Network Documentation

Use this folder for homelab network evidence.

Recommended topics:

- IP addressing.
- DNS.
- DHCP.
- Gateway and routing.
- Firewall rules.
- Packet captures.
- Network diagrams.
- Nmap discovery.
- pfSense or OPNsense configuration.

Keep baseline architecture in `../Architecture/NETWORK_BASELINE.md` and place detailed
implementation evidence here.

## Standard Network Commands

Windows client or server:

```powershell
ipconfig /all
Get-NetIPConfiguration
Get-DnsClientServerAddress
Test-Connection DC01
Test-NetConnection DC01 -Port 53
Resolve-DnsName DC01.corp.local
tracert 192.168.50.1
```

Linux host:

```bash
ip addr
ip route
resolvectl status
ping -c 4 192.168.50.1
ping -c 4 192.168.50.10
```

Discovery and troubleshooting:

```powershell
nmap -sn 192.168.50.0/24
nmap -sV 192.168.50.10
```

## Evidence Checklist

- Subnet and gateway validation.
- DNS server validation.
- DHCP lease or static IP proof.
- Domain controller reachability.
- Firewall or appliance notes.
- Nmap discovery summary.
- Packet capture notes when using Wireshark.

# IT Engineer Toolkit

Documentation-first portfolio for an enterprise homelab built to simulate a realistic small-to-medium business IT environment.

The project demonstrates hands-on systems administration, infrastructure engineering, networking, cybersecurity, automation, cloud, Linux, and AI operations skills. It is organized as a living professional portfolio: every phase should produce evidence, notes, diagrams, screenshots, runbooks, and lessons learned that can be reviewed by future employers or AI coding assistants.

## Current Focus

- Enterprise homelab progression toward Systems Administrator, IT Support Engineer, Infrastructure Engineer, and Cybersecurity Analyst roles.
- Windows Server and Active Directory foundation.
- Linux administration fundamentals on `LINUX01`.
- Documentation, troubleshooting, and operational discipline.
- Future AI Steve platform after the infrastructure foundation is complete.

## Core Environment

- Domain: `corp.local`
- Subnet: `192.168.50.0/24`
- Gateway: `192.168.50.1`
- Primary DNS: `192.168.50.10` (`DC01`)

## Major Areas

- `Documentation/` - homelab notes, architecture, SOPs, troubleshooting, and server documentation.
- `PowerShell/` - administration, reporting, monitoring, and test scripts.
- `Windows/` - Windows administration tools such as Windows Admin Center and Sysinternals.
- `Linux/` - Linux administration, SSH, Docker, Portainer, and Raspberry Pi work.
- `Networking/` - tools and documentation for Nmap, Wireshark, pfSense, OPNsense, PuTTY, and Packet Tracer.
- `Security/` - hardening, vulnerability scanning, Wazuh, and security documentation.
- `Automation/` - Terraform, automation tooling, and future infrastructure-as-code work.
- `Certifications/` - certification notes and study artifacts.

## Documentation Index

- [Architecture](ARCHITECTURE.md)
- [Homelab Documentation](Documentation/HomeLab/README.md)
- [Homelab Master Plan](Documentation/HomeLab/Architecture/MASTER_PLAN.md)
- [Homelab Network Baseline](Documentation/HomeLab/Architecture/NETWORK_BASELINE.md)
- [API](API.md)
- [Setup](SETUP.md)
- [Roadmap](docs/ROADMAP.md)
- [Phase Tracker](docs/PHASE_TRACKER.md)
- [IP Addressing Standard](docs/IP_ADDRESSING.md)
- [Server And Client Inventory](docs/SERVER_INVENTORY.md)
- [Operations Runbook](docs/OPERATIONS_RUNBOOK.md)
- [Troubleshooting](docs/TROUBLESHOOTING.md)
- [Change Management](docs/CHANGE_MANAGEMENT.md)
- [Evidence Standards](docs/EVIDENCE_STANDARDS.md)
- [Software Inventory](docs/SOFTWARE_INVENTORY.md)
- [Project Readiness](docs/PROJECT_READINESS.md)
- [Codex Workstation Setup](docs/CODEX_SETUP.md)
- [Interview Prep](docs/INTERVIEW_PREP.md)
- [AI Prompting](docs/AI_PROMPTING.md)
- [Contributing](CONTRIBUTING.md)
- [Security](SECURITY.md)

## Repository Policy

Large binaries such as ISOs, installers, compressed appliance images, and VM exports are intentionally ignored by Git. Keep checksums, download sources, versions, and installation notes in Markdown instead of committing the binaries themselves.

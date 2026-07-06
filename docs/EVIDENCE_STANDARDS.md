# Evidence Standards

Portfolio evidence should prove real work without exposing secrets or creating noisy Git history.

## Evidence Types

| Evidence | Use For | Git Policy |
| --- | --- | --- |
| Markdown notes | Architecture, process, lessons learned | Commit |
| Screenshots | Validation and visual proof | Commit only curated screenshots |
| Command summaries | Verification and troubleshooting | Commit after redaction |
| Diagrams | Network and system architecture | Commit |
| Installer/ISO inventory | Tool versions and sources | Commit as text metadata |
| ISOs/installers/VM exports | Local toolkit storage | Do not commit |
| Software inventory | Versions, source URLs, checksums, purpose | Commit |

## Folder Placement

| Evidence | Folder |
| --- | --- |
| Master plan and architecture | `../Documentation/HomeLab/Architecture/` |
| Server notes | `../Documentation/Server_Documentation/<HOST>/` |
| Client notes | `../Documentation/HomeLab/Clients/` |
| Network notes | `../Documentation/HomeLab/Network/` |
| Diagrams | `../Documentation/Network_Diagrams/` |
| SOPs | `../Documentation/HomeLab/SOPs/` or `../Documentation/SOPs/` |
| Troubleshooting | `../Documentation/TroubleShooting/<AREA>/` |
| Screenshots | Relevant evidence folder, using descriptive filenames |
| Software metadata | `SOFTWARE_INVENTORY.md` |

## Screenshot Naming

Use descriptive filenames:

```text
YYYY-MM-DD_phase-area_system_action-result.png
```

Examples:

```text
2026-06-29_phase11-linux01_hostnamectl.png
2026-06-29_phase03-client04-domain-join-success.png
```

## Redaction Checklist

Before committing evidence, check for:

- Passwords.
- API keys or tokens.
- Private keys.
- Recovery keys.
- Real addresses or phone numbers.
- Student IDs or private account identifiers.
- Unneeded personal email addresses.
- License keys.

## Command Output Rules

- Prefer summaries over raw dumps.
- Keep commands reproducible.
- Include expected output shape.
- Redact secrets and private identifiers.
- Include the host where the command ran.

## Binary Storage Rules

Do not commit:

- ISO images.
- VM exports.
- Installers.
- Compressed appliance images.
- Driver packages.
- Tool archives.

Instead, document:

- Tool name.
- Version.
- Source URL.
- Download date.
- Checksum when practical.
- Why the tool exists in the local toolkit.

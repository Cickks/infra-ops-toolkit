# Security

## Secret Handling

Never commit:

- Passwords
- API keys
- Tokens
- Private keys
- Recovery keys
- Publish settings
- Real credentials
- Sensitive personal information

Use `.env.example` for placeholder configuration only.

## Security Checks

Run before committing:

```powershell
gitleaks detect --no-git --source .
```

For container or filesystem vulnerability checks, use Trivy when there is a relevant target:

```powershell
trivy fs .
```

## Hardening Principles

- Use least privilege.
- Prefer group-based access control.
- Keep administrative accounts separate from standard users.
- Document firewall, DNS, DHCP, and identity changes.
- Keep rollback procedures for infrastructure changes.

## Portfolio Redaction

Before publishing publicly, review screenshots and documents for:

- Email addresses
- Internal passwords
- License keys
- Private IPs if not intended for publication
- Hostnames that reveal personal infrastructure beyond the lab

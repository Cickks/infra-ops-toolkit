# Homelab SOPs

Use this folder for repeatable standard operating procedures.

Good SOP topics:

- Join a Windows client to `corp.local`.
- Create and validate an Active Directory user.
- Disable and re-enable a user account.
- Validate DNS and DHCP.
- Test PowerShell Remoting.
- Capture Linux baseline evidence on `LINUX01`.
- Export or restore a VM.

Each SOP should include purpose, prerequisites, steps, validation, rollback, and evidence location.

## SOP Template

```markdown
# SOP - Title

## Purpose

## Prerequisites

## Systems Affected

## Procedure

## Validation

## Rollback

## Evidence Location

## Interview Relevance
```

## Priority SOPs To Create

| SOP | Status | Notes |
| --- | --- | --- |
| Join Windows client to `corp.local` | Needed | Use client commands from `../Clients/README.md` |
| Create and validate AD user | Needed | Include group assignment and login validation |
| Disable and re-enable AD user | Needed | Supports offboarding and rehire evidence |
| Validate DHCP and DNS | Needed | Supports domain join troubleshooting |
| Capture `LINUX01` baseline | Needed | Supports Phase 11 evidence |
| Test PowerShell Remoting | Needed | Supports Phase 10.2 |

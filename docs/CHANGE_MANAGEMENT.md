# Change Management

Treat homelab changes like production changes. This makes the portfolio more credible and makes troubleshooting easier.

## Change Record Template

```markdown
## YYYY-MM-DD - Short Change Title

### Objective

### Systems Affected

### Risk

### Pre-Change Validation

### Implementation Steps

### Post-Change Validation

### Rollback Plan

### Result

### Lessons Learned
```

## Risk Levels

| Level | Meaning | Examples |
| --- | --- | --- |
| Low | Documentation or reversible configuration | Markdown update, screenshot rename |
| Medium | Service or host configuration change | DHCP scope update, GPO change |
| High | Identity, network, security, or data availability impact | AD change, firewall rule, server rebuild |

## Required Validation

Before high-impact changes:

- Confirm backup or rollback state.
- Confirm current configuration.
- Record affected systems.
- Define success criteria.

After changes:

- Test the specific business outcome.
- Record command or screenshot evidence.
- Update relevant documentation.
- Add lessons learned.

## Example: New PC Deployment

Objective:

- Deploy a new workstation and join it to `corp.local`.

Validation:

- IP check.
- DNS check.
- Ping `DC01`.
- `nslookup DC01`.
- Domain join.
- Reboot.
- Domain user login.
- Drive mapping verification.
- GPO verification.

Rollback:

- Remove failed computer account from Active Directory.
- Revert VM snapshot if available.
- Rebuild client if domain trust cannot be repaired.

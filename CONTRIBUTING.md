# Contributing

## Standards

- Keep documentation factual and evidence-based.
- Explain why each task matters in a real enterprise environment.
- Prefer reusable runbooks over one-off notes.
- Include validation and rollback guidance for operational procedures.
- Do not commit secrets or large binary artifacts.

## Commit Hygiene

- Use descriptive commit messages.
- Keep unrelated changes separate.
- Update `CHANGELOG.md` for meaningful project milestones.
- Run `gitleaks detect --no-git --source .` before committing.

## Documentation Template

Use this shape for new operational docs:

```markdown
# Title

## Objective

## Prerequisites

## Procedure

## Validation

## Troubleshooting

## Rollback

## Lessons Learned

## Interview Relevance
```

## Update Rules

When a change affects project organization or evidence, update every related file that needs to stay
accurate:

- `README.md` for navigation changes.
- `ARCHITECTURE.md` for system design or folder-routing changes.
- `docs/ROADMAP.md` for sequencing or master-plan changes.
- `docs/PHASE_TRACKER.md` for phase status or evidence targets.
- `docs/SERVER_INVENTORY.md` for host, role, IP, or status changes.
- `docs/EVIDENCE_STANDARDS.md` for evidence location or quality changes.
- `docs/SOFTWARE_INVENTORY.md` for installer, ISO, archive, version, source, or checksum changes.
- `CHANGELOG.md` for meaningful milestones.

Do not leave placeholder folders blank. Add a README that explains the folder purpose and what
evidence belongs there.

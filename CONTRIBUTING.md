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

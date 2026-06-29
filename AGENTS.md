# AI Agent Instructions

This repository is a documentation-first enterprise homelab portfolio. Treat it as a professional infrastructure portfolio, not a throwaway notes folder.

## Mission

Help build a realistic SMB-style IT environment and portfolio that demonstrates production-minded systems administration, infrastructure engineering, cybersecurity, networking, cloud, automation, and future AI operations skills.

## Architecture

- Preserve the homelab domain model: `corp.local` on `192.168.50.0/24`.
- Keep server and client documentation aligned with the IP addressing standard.
- Prefer diagrams, tables, runbooks, and evidence logs over vague prose.
- Do not move large assets, ISOs, installers, or screenshots without explicit user approval.
- When proposing architecture changes, explain operational impact, rollback, security risk, and interview relevance.

## Testing And Validation

- For PowerShell scripts, prefer Pester tests when scripts become reusable.
- Validate commands against the intended host type before documenting them.
- For remote administration notes, distinguish local workstation commands from remote server commands.
- Every runbook should include verification steps and rollback guidance where possible.

## Documentation

- Use clear Markdown headings and tables.
- Document the why, not just the command.
- Capture:
  - objective
  - prerequisites
  - steps
  - validation
  - troubleshooting
  - rollback
  - lessons learned
  - interview relevance
- Keep generated docs concise enough to maintain manually.

## Security

- Never commit secrets, private keys, passwords, recovery keys, tokens, publish settings, or live credentials.
- Redact personal identifiers that are not necessary for portfolio review.
- Prefer references to secret storage locations instead of secret values.
- Use least privilege, group-based access, and auditable change procedures.
- Run `gitleaks detect --no-git --source .` before committing.

## Accessibility And UI/UX

If this repository gains a portfolio website:

- Keep navigation simple and keyboard accessible.
- Use semantic HTML, landmarks, alt text, and visible focus states.
- Support mobile layouts and dark mode.
- Make project evidence easy to scan for recruiters and interviewers.

## Performance

If this repository gains a site or app:

- Optimize images before committing.
- Avoid shipping large binaries through the website bundle.
- Prefer static content generation for documentation pages.
- Track bundle size once a frontend stack exists.

## Logging And Operations

- Keep change logs for meaningful homelab milestones.
- Include evidence for completed phases, such as screenshots, command output summaries, or validation checklists.
- Use dates for operational journal entries.

## AI Prompt Engineering

- Keep reusable AI prompts in docs or prompt files, not buried inside chat history.
- Version major prompt changes.
- State role, context, current phase, constraints, expected output, and verification requirements.
- Ask future AI agents to preserve production standards and explain real-world relevance.

## Git

- Do not work directly on `main` once the repository has meaningful history.
- Create feature branches for documentation or automation changes.
- Keep commits small and descriptive.
- Do not add ignored binary artifacts with `git add -f` unless the user explicitly approves.

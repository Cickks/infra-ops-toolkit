# PowerShell Scripts

Use this folder for general reusable administration scripts.

Each script should include:

- Purpose.
- Required permissions.
- Example command.
- Expected output.
- Validation steps.
- Rollback or safety notes.

Run scripts in a lab-safe context before documenting them as portfolio-ready.

## Available Scripts

| Script                       | Purpose                                                       | Safety Notes                                                     |
| ---------------------------- | ------------------------------------------------------------- | ---------------------------------------------------------------- |
| `Sync-PortfolioToLinux.ps1`  | Syncs `C:\Portfilio` to Linux hosts over SSH.                 | Remote deletes require explicit `-DeleteRemote`.                 |
| `Sync-PortfolioToLabUsb.ps1` | Copies `C:\Portfilio` to the USB drive labeled `LAB STUFF`.   | USB deletes are disabled by default; `-Mirror` must be explicit. |
| `Test-MarkdownFormat.ps1`    | Runs the same Prettier Markdown check used by GitHub Actions. | Use `-Write` to format Markdown files before pushing.            |

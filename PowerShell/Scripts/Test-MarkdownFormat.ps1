<#
.SYNOPSIS
Runs the same Markdown formatting check used by GitHub Actions.

.DESCRIPTION
Uses Prettier through npx to check all Markdown files in the repository. Run
this before pushing documentation changes so the PR Markdown Format Check does
not fail in CI.

.EXAMPLE
.\PowerShell\Scripts\Test-MarkdownFormat.ps1

Checks Markdown formatting.

.EXAMPLE
.\PowerShell\Scripts\Test-MarkdownFormat.ps1 -Write

Formats Markdown files in place.
#>

[CmdletBinding()]
param(
    [switch]$Write
)

$ErrorActionPreference = "Stop"

$repoRoot = Resolve-Path (Join-Path $PSScriptRoot "..\..")
Push-Location $repoRoot

try {
    $mode = if ($Write) { "--write" } else { "--check" }
    & npx --yes prettier $mode "**/*.md"

    if ($LASTEXITCODE -ne 0) {
        throw "Prettier Markdown format check failed with exit code $LASTEXITCODE."
    }
}
finally {
    Pop-Location
}

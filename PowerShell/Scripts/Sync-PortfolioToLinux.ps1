<#
.SYNOPSIS
Safely syncs the Windows Portfolio folder to Linux hosts over SSH.

.DESCRIPTION
Uses rsync when available for a full mirror sync, including deletion of remote
files that no longer exist locally. If rsync is not installed, falls back to a
tar/scp upload that creates and updates remote files only.

The sync excludes noisy or heavy development folders, caches, build outputs,
logs, archives, installers, ISO files, and VM images.

.EXAMPLE
.\Scripts\Sync-PortfolioToLinux.ps1

Sync to LINUX01 using the ssh alias linux01.

.EXAMPLE
.\Scripts\Sync-PortfolioToLinux.ps1 -IncludeInfra01

Sync to LINUX01 and INFRA01.

.EXAMPLE
.\Scripts\Sync-PortfolioToLinux.ps1 -IncludeInfra01 -UseRsync -DeleteRemote

Force rsync mirror mode and delete remote files that no longer exist locally.
#>

[CmdletBinding()]
param(
    [string]$SourcePath = "C:\Portfilio",
    [string]$RemotePath = "/home/michael/Portfolio",
    [string[]]$Targets = @("linux01"),
    [switch]$IncludeInfra01,
    [switch]$StageOnly,
    [switch]$UseRsync,
    [switch]$DeleteRemote
)

$ErrorActionPreference = "Stop"

if ($IncludeInfra01 -and ($Targets -notcontains "michael@192.168.1.133")) {
    $Targets += "michael@192.168.1.133"
}

if (-not (Test-Path -LiteralPath $SourcePath -PathType Container)) {
    throw "Source path not found: $SourcePath"
}

$excludeDirs = @(
    ".git",
    ".hg",
    ".svn",
    "node_modules",
    ".venv",
    "venv",
    "__pycache__",
    ".pytest_cache",
    ".mypy_cache",
    ".ruff_cache",
    ".cache",
    ".next",
    ".nuxt",
    ".vite",
    "dist",
    "build",
    "coverage",
    ".turbo"
)

$excludeFiles = @(
    "*.log",
    "*.tmp",
    "*.temp",
    "*.iso",
    "*.img",
    "*.ova",
    "*.ovf",
    "*.vdi",
    "*.vmdk",
    "*.vhd",
    "*.vhdx",
    "*.exe",
    "*.msi",
    "*.zip",
    "*.7z",
    "*.rar",
    "*.gz",
    "*.bz2",
    "*.xz",
    "*.tar",
    "~$*",
    ".DS_Store",
    "Thumbs.db",
    "desktop.ini"
)

function Test-RequiredCommand {
    param([Parameter(Mandatory)][string]$Name)

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required tool not found in PATH: $Name"
    }
}

function Convert-ToRsyncPath {
    param([Parameter(Mandatory)][string]$Path)

    $resolved = (Resolve-Path -LiteralPath $Path).Path
    $drive = $resolved.Substring(0, 1).ToLowerInvariant()
    $rest = $resolved.Substring(2).Replace("\", "/")
    return "/cygdrive/$drive$rest/"
}

function Convert-ToCygwinPath {
    param([Parameter(Mandatory)][string]$Path)

    $fullPath = [System.IO.Path]::GetFullPath($Path)
    $drive = $fullPath.Substring(0, 1).ToLowerInvariant()
    $rest = $fullPath.Substring(2).Replace("\", "/")
    return "/cygdrive/$drive$rest"
}

function Resolve-RsyncTarget {
    param([Parameter(Mandatory)][string]$Target)

    if ($Target -eq "linux01") {
        return "michael@192.168.56.50"
    }

    return $Target
}

Test-RequiredCommand "ssh.exe"

$rsyncCommand = Get-Command "rsync.exe" -ErrorAction SilentlyContinue
if ($UseRsync -and -not $rsyncCommand) {
    throw "UseRsync requested, but rsync.exe was not found in PATH."
}

$shouldUseRsync = [bool]$rsyncCommand

if ($shouldUseRsync) {
    Write-Host "Using rsync: $($rsyncCommand.Source)"

    $sourceRsyncPath = Convert-ToRsyncPath -Path $SourcePath
    $rsyncSshPath = "ssh"
    $packagedSshPath = "C:\ProgramData\chocolatey\lib\rsync\tools\bin\ssh.exe"

    if (Test-Path -LiteralPath $packagedSshPath -PathType Leaf) {
        $rsyncSshPath = Convert-ToCygwinPath -Path $packagedSshPath
    }

    $sshOptions = @($rsyncSshPath)
    $identityPath = "$env:USERPROFILE\.ssh\id_ed25519"
    $knownHostsPath = "$env:USERPROFILE\.ssh\known_hosts"

    if (Test-Path -LiteralPath $identityPath -PathType Leaf) {
        $sshOptions += @("-i", (Convert-ToCygwinPath -Path $identityPath))
    }

    if (Test-Path -LiteralPath $knownHostsPath -PathType Leaf) {
        $sshOptions += @("-o", "UserKnownHostsFile=$(Convert-ToCygwinPath -Path $knownHostsPath)")
    }

    $rsyncRemoteShell = $sshOptions -join " "

    foreach ($target in $Targets) {
        $rsyncTarget = Resolve-RsyncTarget -Target $target
        Write-Host "Syncing to ${target}:$RemotePath with rsync"

        & ssh.exe $target "mkdir -p '$RemotePath'"
        if ($LASTEXITCODE -ne 0) {
            throw "Failed to create remote path on $target"
        }

        $rsyncArgs = @(
            "-avz",
            "--human-readable",
            "--itemize-changes"
        )

        $rsyncArgs += @("-e", $rsyncRemoteShell)

        if ($DeleteRemote) {
            $rsyncArgs += "--delete"
            Write-Host "DeleteRemote enabled. Remote files not present locally may be deleted on $target."
        }

        foreach ($dir in $excludeDirs) {
            $rsyncArgs += "--exclude=$dir/"
        }

        foreach ($file in $excludeFiles) {
            $rsyncArgs += "--exclude=$file"
        }

        $rsyncArgs += @(
            $sourceRsyncPath,
            "${rsyncTarget}:$RemotePath/"
        )

        & rsync.exe @rsyncArgs
        if ($LASTEXITCODE -ne 0) {
            throw "rsync failed for $target with exit code $LASTEXITCODE"
        }

        & ssh.exe $target "echo SYNC_COMPLETE && du -sh '$RemotePath'"
        if ($LASTEXITCODE -ne 0) {
            throw "Remote validation failed for $target"
        }
    }

    Write-Host "Portfolio rsync completed."
    return
}

foreach ($tool in @("scp.exe", "tar.exe", "robocopy.exe")) {
    Test-RequiredCommand $tool
}

$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$workRoot = Join-Path $env:TEMP "portfolio-sync"
$stagePath = Join-Path $workRoot "Portfolio-Staging-$timestamp"
$archivePath = Join-Path $workRoot "portfolio-sync-$timestamp.tar"

New-Item -ItemType Directory -Force -Path $stagePath | Out-Null

Write-Host "rsync.exe not found. Falling back to tar/scp create-update mode."
Write-Host "Staging Portfolio from $SourcePath"
Write-Host "Stage path: $stagePath"

$robocopyArgs = @(
    $SourcePath,
    $stagePath,
    "/E",
    "/R:1",
    "/W:1",
    "/NP",
    "/NFL",
    "/NDL",
    "/XD"
) + $excludeDirs + @("/XF") + $excludeFiles

& robocopy @robocopyArgs | Out-Host
$robocopyExit = $LASTEXITCODE

if ($robocopyExit -gt 7) {
    throw "Robocopy failed with exit code $robocopyExit"
}

Write-Host "Creating archive: $archivePath"
& tar.exe -cf $archivePath -C $stagePath .

if (-not (Test-Path -LiteralPath $archivePath -PathType Leaf)) {
    throw "Archive was not created: $archivePath"
}

$archiveSize = (Get-Item -LiteralPath $archivePath).Length
Write-Host ("Archive size: {0:N2} MB" -f ($archiveSize / 1MB))

if ($StageOnly) {
    Write-Host "StageOnly requested. No remote upload performed."
    Write-Host "Archive ready at: $archivePath"
    return
}

foreach ($target in $Targets) {
    Write-Host "Syncing to ${target}:$RemotePath"

    & ssh.exe $target "mkdir -p '$RemotePath'"
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to create remote path on $target"
    }

    $remoteArchive = "${target}:/tmp/portfolio-sync-$timestamp.tar"
    & scp.exe $archivePath $remoteArchive
    if ($LASTEXITCODE -ne 0) {
        throw "SCP upload failed for $target"
    }

    $extractCommand = "tar -xf '/tmp/portfolio-sync-$timestamp.tar' -C '$RemotePath' && rm '/tmp/portfolio-sync-$timestamp.tar' && echo SYNC_COMPLETE && du -sh '$RemotePath'"
    & ssh.exe $target $extractCommand
    if ($LASTEXITCODE -ne 0) {
        throw "Remote extraction failed for $target"
    }
}

Write-Host "Portfolio sync completed. Remote destination files were created/updated only; no remote delete operation was performed."

<#
.SYNOPSIS
Safely copies the Windows Portfolio workspace to the Lab Stuff USB drive.

.DESCRIPTION
Uses robocopy to copy C:\Portfilio to a USB drive identified by volume label.
The default mode creates and updates files only. It does not delete files from
the USB destination unless -Mirror is explicitly provided.

The sync excludes noisy development folders, caches, build outputs, logs,
archives, installers, ISO files, and virtual machine disk/export files.

.PARAMETER SourcePath
Local Portfolio workspace path. Defaults to C:\Portfilio.

.PARAMETER UsbLabel
Volume label used to identify the USB drive. Defaults to LAB STUFF.

.PARAMETER DestinationFolder
Folder created on the USB drive. Defaults to Portfolio.

.PARAMETER Mirror
Use robocopy /MIR to mirror the destination. This can delete files on the USB
that no longer exist in the source. Use only after verifying the destination.

.PARAMETER WhatIf
Show what would be copied without changing the USB destination.

.EXAMPLE
.\Sync-PortfolioToLabUsb.ps1

Copies C:\Portfilio to the USB drive labeled LAB STUFF under \Portfolio.

.EXAMPLE
.\Sync-PortfolioToLabUsb.ps1 -UsbLabel "LABSTUFF" -DestinationFolder "Portfolio-Backup"

Copies to a custom-labeled USB and destination folder.

.EXAMPLE
.\Sync-PortfolioToLabUsb.ps1 -WhatIf

Performs a dry run and logs what robocopy would copy.
#>

[CmdletBinding(SupportsShouldProcess = $true)]
param(
    [string]$SourcePath = "C:\Portfilio",
    [string]$UsbLabel = "LAB STUFF",
    [string]$DestinationFolder = "Portfolio",
    [switch]$Mirror
)

$ErrorActionPreference = "Stop"

function Test-RequiredCommand {
    param([Parameter(Mandatory)][string]$Name)

    if (-not (Get-Command $Name -ErrorAction SilentlyContinue)) {
        throw "Required tool not found in PATH: $Name"
    }
}

function Get-UsbDriveByLabel {
    param([Parameter(Mandatory)][string]$Label)

    $volumes = Get-Volume -ErrorAction Stop |
        Where-Object {
            $_.DriveLetter -and
            $_.FileSystemLabel -and
            ($_.FileSystemLabel -ieq $Label)
        }

    if (-not $volumes) {
        throw "No mounted volume found with label '$Label'. Connect the USB drive or check its label."
    }

    if (@($volumes).Count -gt 1) {
        $letters = ($volumes | ForEach-Object { "$($_.DriveLetter):" }) -join ", "
        throw "Multiple volumes found with label '$Label': $letters. Use a unique USB label before syncing."
    }

    return $volumes | Select-Object -First 1
}

Test-RequiredCommand "robocopy.exe"

if (-not (Test-Path -LiteralPath $SourcePath -PathType Container)) {
    throw "Source path not found: $SourcePath"
}

$usbVolume = Get-UsbDriveByLabel -Label $UsbLabel
$usbRoot = "$($usbVolume.DriveLetter):\"
$destinationPath = Join-Path $usbRoot $DestinationFolder
$logRoot = Join-Path $usbRoot "Sync-Logs"
$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$logPath = Join-Path $logRoot "portfolio-to-usb-$timestamp.log"

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

New-Item -ItemType Directory -Force -Path $destinationPath | Out-Null
New-Item -ItemType Directory -Force -Path $logRoot | Out-Null

Write-Host "Source:      $SourcePath"
Write-Host "USB label:   $UsbLabel"
Write-Host "Destination: $destinationPath"
Write-Host "Log:         $logPath"

if ($Mirror) {
    Write-Warning "Mirror mode enabled. Files on the USB destination may be deleted if they do not exist in the source."
}
else {
    Write-Host "Mode:        Copy/update only. No destination deletes."
}

$copyMode = if ($Mirror) { "/MIR" } else { "/E" }

$robocopyArgs = @(
    $SourcePath,
    $destinationPath,
    $copyMode,
    "/R:1",
    "/W:1",
    "/XJ",
    "/FFT",
    "/NP",
    "/TEE",
    "/LOG:$logPath",
    "/XD"
) + $excludeDirs + @("/XF") + $excludeFiles

if ($WhatIfPreference) {
    $robocopyArgs += "/L"
}

if ($PSCmdlet.ShouldProcess($destinationPath, "Sync Portfolio workspace to USB")) {
    & robocopy.exe @robocopyArgs
    $robocopyExit = $LASTEXITCODE

    if ($robocopyExit -gt 7) {
        throw "Robocopy failed with exit code $robocopyExit. Review log: $logPath"
    }

    Write-Host "Portfolio USB sync completed with robocopy exit code $robocopyExit."
    Write-Host "Review log: $logPath"
}

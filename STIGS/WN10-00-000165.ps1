 <#000
.SYNOPSIS
    The script disables the SMB1 protocol by setting its registry value to 0 and backs up any existing setting for safety.

.NOTES
    Author          : Mark Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-10-08
    Last Modified   : 2025-10-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000165

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-00-000165).ps1 
#>

# Run this as Administrator

# Disable SMB1 (server) via registry
# HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters\SMB1 = 0 (DWORD)

# Require elevation
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)) {
    throw "Run this script in an elevated PowerShell session (Run as administrator)."
}

$regPath = 'HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters'
$name    = 'SMB1'
$value   = 0

# Ensure key exists
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Backup existing value (if any)
$existing = (Get-ItemProperty -Path $regPath -Name $name -ErrorAction SilentlyContinue).$name
if ($null -ne $existing) {
    Write-Host "Current SMB1 value: $existing (backing up to SMB1_Backup)"
    New-ItemProperty -Path $regPath -Name "${name}_Backup" -Value $existing -PropertyType DWord -Force | Out-Null
}

# Set to 0 (disabled)
New-ItemProperty -Path $regPath -Name $name -Value $value -PropertyType DWord -Force | Out-Null

# Verify
$setValue = (Get-ItemProperty -Path $regPath -Name $name).$name
Write-Host "SMB1 is now set to: $setValue (0 = disabled)"
 

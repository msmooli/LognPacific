  <#
.SYNOPSIS
    This PowerShell script adds a setting to the Windows registry that allows the computer to stay connected to the network while in sleep mode on battery power by setting DCSettingIndex to 1. 

.NOTES
    Author          : Mark Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-18-07
    Last Modified   : 2025-18-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000145

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000145).ps1 
#>

# Define the target registry path
$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Power\PowerSettings\0e796bdb-100d-47d6-a2d5-f7d2daa51f51'

# If the key doesn’t exist, create it
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Create or update the DCSettingIndex DWORD to 1
New-ItemProperty `
    -Path $regPath `
    -Name 'DCSettingIndex' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

Write-Host "DCSettingIndex set to 1 under $regPath"
 

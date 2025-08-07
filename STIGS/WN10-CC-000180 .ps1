 <#000
.SYNOPSIS
    The script turns off AutoPlay for devices that don’t have storage by adding a setting to the Windows registry.

.NOTES
    Author          : Mark Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-07-08
    Last Modified   : 2025-07-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000180

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000180).ps1 
#>

# Run this as Administrator
# Variables
$regPath  = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Explorer'
$valueName = 'NoAutoplayfornonVolume'
$valueData = 1

# Create the key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path 'HKLM:\SOFTWARE\Policies\Microsoft\Windows' -Name 'Explorer' -Force | Out-Null
}

# Create or update the DWORD value
New-ItemProperty -Path $regPath `
                -Name $valueName `
                -PropertyType DWORD `
                -Value $valueData `
                -Force | Out-Null

Write-Host "Registry value '$valueName' set to $valueData under $regPath"
 

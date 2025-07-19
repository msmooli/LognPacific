 <#
.SYNOPSIS
    This PowerShell script disables User Account Control (UAC) prompts for standard users by setting a registry value, streamlining user experience where elevated permissions are centrally managed.

.NOTES
    Author          : Mark Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-19-07
    Last Modified   : 2025-19-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000255

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-SO-000255).ps1 
#>

$regPath  = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$valueName = "ConsentPromptBehaviorUser"
$valueData = 0

# Create the key if it doesn't already exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Create or overwrite the DWORD value
New-ItemProperty `
    -Path $regPath `
    -Name $valueName `
    -PropertyType DWord `
    -Value $valueData `
    -Force | Out-Null

Write-Output "Set $valueName = $valueData at $regPath"
 

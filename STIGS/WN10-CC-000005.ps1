 <#
.SYNOPSIS
    The script disables the camera on the Windows lock screen by setting the NoLockScreenCamera policy to prevent unauthorized access. 

.NOTES
    Author          : Mark Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-06-08
    Last Modified   : 2025-06-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000005).ps1 
#>

# Run this as Administrator
# Define the registry path
$regPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Personalization'

# Create the key if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the NoLockScreenCamera DWORD to 1
New-ItemProperty `
    -Path $regPath `
    -Name 'NoLockScreenCamera' `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null
 

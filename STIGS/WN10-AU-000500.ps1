 <#
.SYNOPSIS
    This PowerShell script ensures that the maximum size of the Windows Application event log is at least 32768 KB (32 MB).

.NOTES
    Author          : Makr Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-17-07
    Last Modified   : 2025-17-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000500

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AU-000500).ps1 
#>

# Define the registry path and value
$regPath   = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'
$valueName = 'MaxSize'
$valueData = 0x8000  # hex for 32768

# Create the key if needed
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set the DWORD value
Set-ItemProperty -Path $regPath -Name $valueName -Value $valueData -Type DWord

# Verify
Get-ItemProperty -Path $regPath -Name $valueName
 

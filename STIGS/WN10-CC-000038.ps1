 <#
.SYNOPSIS
  The script disables WDigest authentication and sets the UseLogonCredential DWORD to 0.

.NOTES
    Author          : Mark Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-08-08
    Last Modified   : 2025-08-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000038 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000038).ps1
#>
Write-Host "Disabling WDigest authentication (STIG: WN10-CC-000038)..." -ForegroundColor Cyan

# Registry path for WDigest
$wdigestPath = 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders\WDigest'
$dwordName   = 'UseLogonCredential'
$dwordValue  = 0

try {
    # Ensure WDigest key exists
    if (!(Test-Path $wdigestPath)) {
        New-Item -Path 'HKLM:\SYSTEM\CurrentControlSet\Control\SecurityProviders' -Name 'WDigest' -Force | Out-Null
        Write-Host "Created the WDigest registry key."
    }

    # Create/update UseLogonCredential = 0 (DWORD)
    New-ItemProperty -Path $wdigestPath -Name $dwordName -PropertyType DWORD -Value $dwordValue -Force | Out-Null
    Write-Host "Successfully set $dwordName to $dwordValue (disabled)."
}
catch {
    Write-Error "Failed to set $dwordName. Error: $_"
}

Write-Host "A reboot is recommended to fully apply the change." -ForegroundColor Yellow

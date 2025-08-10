 <#
.SYNOPSIS
  The script configures Windows Data Execution Prevention (DEP) for the current boot entry to “OptOut” mode,
  enabling DEP for all processes except those explicitly opted out.

.NOTES
    Author          : Mark Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-08-08
    Last Modified   : 2025-08-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000145 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-00-000145).ps1 
#>

# Run this as Administrator
Write-Host "Configuring DEP to 'OptOut'..." -ForegroundColor Cyan

try {
    # Set DEP to OptOut
    # Use single quotes around {current} to avoid escape issues
    bcdedit /set '{current}' nx OptOut

    Write-Host "DEP successfully set to 'OptOut'. Please reboot now." -ForegroundColor Green
}
catch {
    Write-Warning "Failed to set DEP: $($_.Exception.Message)"
} 

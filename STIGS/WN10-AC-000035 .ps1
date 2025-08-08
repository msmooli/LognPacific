 <#
.SYNOPSIS
  The script sets the local “Minimum password length” to 14 characters.

.NOTES
    Author          : Mark Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-08-08
    Last Modified   : 2025-08-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000035).ps1 
#>

# Run this as Administrator

# 1. Elevation check
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Warning "Please re-run this script as Administrator."
    exit 1
}

# 2. Set minimum password length to 14
Write-Host "Setting minimum password length to 14..."
try {
    net accounts /minpwlen:14 2>&1 | ForEach-Object { Write-Host $_ }
}
catch {
    Write-Error "Failed to set minimum password length: $($_.Exception.Message)"
    exit 1
}

# 3. Force policy refresh
Write-Host "Refreshing Group Policy..."
gpupdate.exe /force | Out-Null

# 4. Verify the change
$result = net accounts | Select-String 'Minimum password length'
Write-Host "`nVerification:`n$result"
 

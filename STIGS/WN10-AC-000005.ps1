 <#
.SYNOPSIS
    This PowerShell script checks how long an account stays locked after failed logins and, if it’s shorter, updates the lockout duration to 15 minutes. 

.NOTES
    Author          : Makr Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-18-07
    Last Modified   : 2025-18-07
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000005).ps1 
#>

# Run this as Administrator

# 1. Read the current lockout duration (in minutes)
$current = [int](
    [regex]::Match(
        (net accounts), 
        'Lockout duration.*?(\d+)'
    ).Groups[1].Value
)

Write-Output "Current lockout duration: $current minute(s)"

# 2. If it isn’t already 15, set it to 15 minutes
if ($current -ne 15) {
    Write-Warning "Setting lockout duration to 15 minutes..."
    net accounts /lockoutduration:15

    # 3. Verify immediately
    $new = [regex]::Match((net accounts), 'Lockout duration.*?(\d+)').Groups[1].Value
    Write-Output "New lockout duration: $new minute(s)"
}
else {
    Write-Output "Lockout duration is already 15 minutes. No change needed."

}

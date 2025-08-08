 <#
.SYNOPSIS
  This script enables the local Windows “Password must meet complexity requirements” policy by setting PasswordComplexity = 1.

.NOTES
    Author          : Mark Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-08-08
    Last Modified   : 2025-08-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000040 

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-AC-000040).ps1 
#>

# Run this as Administrator
Write-Host "Enforcing password complexity requirement (Enabled)..."

# Ensure C:\Temp exists
if (!(Test-Path 'C:\Temp')) {
    Write-Host "Creating C:\Temp directory..."
    New-Item -ItemType Directory -Path 'C:\Temp' -Force | Out-Null
}

# 1) Export current local security policy
secedit /export /cfg "C:\Temp\policy-old.ini" /areas SECURITYPOLICY

# 2) Replace or insert the line for PasswordComplexity = 1
(gc "C:\Temp\policy-old.ini") `
    -replace 'PasswordComplexity\s*=\s*\d+', 'PasswordComplexity = 1' `
    | Out-File "C:\Temp\policy-new.ini" -Encoding Unicode

# 3) Re-import the updated policy
secedit /configure /db "C:\Windows\Security\Local.sdb" /cfg "C:\Temp\policy-new.ini" /areas SECURITYPOLICY

Write-Host "✅ Password complexity requirement set to Enabled."
Write-Host "Run `gpupdate /force` or reboot to apply immediately."

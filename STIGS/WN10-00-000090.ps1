 <#000
.SYNOPSIS
    This script enables password expiration for every enabled local user account by turning off their “Password never expires” setting

.NOTES
    Author          : Mark Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-07-08
    Last Modified   : 2025-07-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-00-000090

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-00-000090).ps1 
#>

# Run this as Administrator
# Configure all enabled local users to have passwords expire
#    (requires PS 5+; Microsoft.PowerShell.LocalAccounts is built-in on Win10)
Import-Module Microsoft.PowerShell.LocalAccounts

Get-LocalUser |
  Where-Object { $_.Enabled -eq $true } |
  ForEach-Object {
    # unset the "Password never expires" flag
    Set-LocalUser -Name $_.Name -PasswordNeverExpires $false
    Write-Host "• Password expiration enabled for user: $($_.Name)"
  }

Write-Host "✅ All enabled local accounts set to expire passwords"
 

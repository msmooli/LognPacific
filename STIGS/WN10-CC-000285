 <#000
.SYNOPSIS
    The script makes sure Windows is set to encrypt RPC traffic by creating or updating a registry setting.

.NOTES
    Author          : Mark Mooli
    LinkedIn        : linkedin.com/in/markmooli/
    GitHub          : github.com/msmooli
    Date Created    : 2025-10-08
    Last Modified   : 2025-10-08
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000285

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG-ID-WN10-CC-000285).ps1 
#>

# Run this as Administrator

# Define the registry path and value
$RegPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$ValueName = "fEncryptRPCTraffic"
$ValueData = 1

# Ensure the registry key exists
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set the registry value
Set-ItemProperty -Path $RegPath -Name $ValueName -Value $ValueData -Type DWord

Write-Host "Registry value '$ValueName' set to $ValueData at $RegPath" -ForegroundColor Green
 

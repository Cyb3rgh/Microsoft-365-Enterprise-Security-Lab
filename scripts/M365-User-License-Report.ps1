Connect-MgGraph -Scopes "User.Read.All"

$Users = Get-MgUser -All -Property DisplayName,UserPrincipalName,AccountEnabled,AssignedLicenses

$Report = foreach ($User in $Users) {
    [PSCustomObject]@{
        DisplayName       = $User.DisplayName
        UserPrincipalName = $User.UserPrincipalName
        AccountEnabled    = $User.AccountEnabled
        Licensed          = ($User.AssignedLicenses.Count -gt 0)
        LicenseCount      = $User.AssignedLicenses.Count
    }
}

$Report | Export-Csv "$env:USERPROFILE\Desktop\M365-User-License-Report.csv" -NoTypeInformation

Write-Host "Report exported successfully."
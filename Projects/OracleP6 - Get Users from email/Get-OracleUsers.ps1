$P6Users= (Get-Content "C:\PowerShell\Projects\OracleP6 - Get Users from email\users.txt")

$P6Users | ForEach-Object -Process {
    Get-ADUser -Filter * -Properties ExtensionAttribute10, ExtensionAttribute11, ExtensionAttribute13, Name, UserPrincipalName | `
    Where-Object UserPrincipalName -eq $_ | Select-Object Name, UserPrincipalName,ExtensionAttribute10, ExtensionAttribute11, ExtensionAttribute13} | `

    Export-Csv -Path "C:\PowerShell\Projects\OracleP6 - Get Users from email\users.csv" -NoTypeInformation
$GetUsers= Get-Content ("C:\PowerShell\Projects\EnergyGuage - Add users to AD Group\EnergyGauge_UserList.txt") | Get-ADUser | Select-Object UserPrincipalName

$GetUsers #| ForEach-Object -Process {Add-ADGroupMember -Members $_.SamAccountName -Identity "XenApp EnergyGuage Users"

#}
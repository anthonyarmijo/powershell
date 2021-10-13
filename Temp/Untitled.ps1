$GetUsers= Get-Content ("Projects\AD - Add users to AD Group\EnergyGauge_UserList.txt") | Get-ADUser | Select-Object SamAccountName

$GetUsers | ForEach-Object -Process {Add-ADGroupMember -Members $_.SamAccountName -Identity "XenApp EnergyGuage Users"

}
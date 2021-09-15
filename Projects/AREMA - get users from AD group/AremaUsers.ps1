$AremaList= (Get-ADGroupMember -Identity SG-Arema  | Select-Object -ExpandProperty SamAccountName);

$AremaList | ForEach-Object -Process {
    Get-ADUser -Identity $_ -Properties ExtensionAttribute13, Name, UserPrincipalName | Select ExtensionAttribute13, Name, UserPrincipalName} | 

    Export-Csv .\AremaUsers.csv -NoTypeInformation
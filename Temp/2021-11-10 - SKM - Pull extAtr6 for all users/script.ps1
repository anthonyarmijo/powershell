
$SKMUsers= Get-ADGroupMember -Identity "SKM-Users" | Select-Object SamAccountName 


$SKMUsers | ForEach-Object -Process {
    Get-ADUser -Identity $_.SamAccountName -Properties Name, ExtensionAttribute6, Enabled, UserPrincipalName |
        Where-Object {$_.Enabled -like "True"} |
        Where-Object {$_.extensionAttribute6 -notlike "|31|SS|A|ITS*"} | 
        Where-Object {$_.extensionAttribute6 -ne $null} | 

    Select-Object Name, UserPrincipalName, SamAccountName, ExtensionAttribute6, Enabled |
    
Export-Csv -Path .\output.csv -NoTypeInformation -Append -Force }
Invoke-Item -Path .\output.csv

#Import-Csv -Path .\output.csv |
 #   Select-Object -Property *,
  #      @


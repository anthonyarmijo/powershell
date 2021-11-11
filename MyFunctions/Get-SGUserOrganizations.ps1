function Get-SGUserOrganizations {
    [CmdletBinding()]
    <#
    .SYNOPSIS
       This function allows you to export a list of users from an AD security group, along with their specific organization (ExtensionAttribute6).
       This is especially useful for procurement tracking purposes, utilizing existing EXP Citrix AD access groups.
 
       Any IT user accounts in the security groups will be automatically removed for the CSV export, in order to better facilitate procurement tracking.

    .NOTES
        Anthony Armijo
        Anthony.Armijo@icloud.com
 
        VERSION HISTORY
        1.0 2021/11/11 Initial Version

    .PARAMETER ADSecurityGroup
        Specify an AD Security Group source to generate the required list of users and their respective organizations.

    .EXAMPLE
        Get-SGUserOrganizations -ADSecurityGroup 'SKM-Users'
    .LINK
        https://github.com/anthonyarmijo/PowerShell
    #>
    
    param (
            [Parameter()]
            [String]
            $ADSecurityGroup = '.*'

        )

    Process{
        $AD_SecurityGroup = 'SKM-Users'
        #Set the specific AD group above.
        
        $Users= (Get-ADGroupMember -Identity $AD_SecurityGroup | Select-Object -ExpandProperty SamAccountName)

        $Users | ForEach-Object -Process {
            Get-ADUser -Identity $_ -Properties Name, ExtensionAttribute6, Enabled, UserPrincipalName | 
                Where-Object {$_.Enabled -like "True"} |
                Where-Object {$_.extensionAttribute6 -cnotmatch "SS|A|ITS"} | 
                Where-Object {$_.extensionAttribute6 -ne $null} | 
        
            Select-Object Name, UserPrincipalName, ExtensionAttribute6, Enabled |
            Export-Csv -Path .\output.csv -NoTypeInformation -Append -Force }
        
            Invoke-Item -Path .\output.csv

    }

}
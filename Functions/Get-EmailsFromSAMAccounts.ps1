function Get-EmailsfromSAMAccounts {
    [CmdletBinding()]
    <#
    .SYNOPSIS
        This function parses through a list of SAM-Account-Name attributes and returns the user's email addresses. A future functionality to be included is
        the ability to return different values, including office, sector, discipline, practice, etc. 
 
    .NOTES
        Anthony Armijo
        Anthony.Armijo@icloud.com
 
        VERSION HISTORY
        1.0 2021/10/13 Initial Version

    .PARAMETER UserListPath
        Specify a text file source from where to pull the SAM-Account-Name attributes.

    .EXAMPLE
        Get-EmailsfromSAMAccounts -UserListPath C:\Temp\AD_account_list.txt
    .LINK
        https://github.com/anthonyarmijo/PowerShell
    #>
    
    param (
            [Parameter()]
            [String]
            $UserListPath = '.*',

            [Parameter()]
            [String]
            $AppName = '.*'
        )
    
    Begin{

        $CurrentDate = Get-Date
        $CurrentDate = $CurrentDate.ToString('yyyy-MM-dd')
    }

    Process{
       $EmailList = Get-Content ($UserListPath) |
            ForEach-Object -Process {
                Get-ADUser -Identity $_ -Properties UserPrincipalName |
                Select-Object UserPrincipalName
        }

        $EmailList | Export-Csv -Path C:\GIT\PowerShell\Input-Output\"$CurrentDate"_ExportedEmails_$AppName.csv

    }

}
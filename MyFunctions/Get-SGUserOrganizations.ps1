function Get-SGUserOrganizations {
    [CmdletBinding()]
    <#
    .SYNOPSIS
       This function allows you to export a list of users from an AD security group or a custom list, into an along with their specific organization (ExtensionAttribute6).
       This is especially useful for procurement tracking purposes, utilizing existing EXP Citrix AD access groups.
 
       Any IT user accounts in the security groups will be automatically removed for the CSV export, in order to better facilitate procurement tracking.

    .NOTES
        Anthony Armijo
        Anthony.Armijo@icloud.com
 
        VERSION HISTORY
        1.0 2021/11/11 Initial Version

    .PARAMETER ADSecurityGroup
        Specify an AD Security Group source to be used to generate the user/organization output.

    .PARAMETER UserListPath
        Specify a source path (.txt) for a list of SAM-Account-Names to be used to generate the user/organization output.

    .EXAMPLE
        Get-SGUserOrganizations -ADSecurityGroup 'SKM-Users'
    .LINK
        https://github.com/anthonyarmijo/PowerShell
    #>
    
    param (
            [Parameter()]
            [String]
            $ADSecurityGroup = '',

            [Parameter()]
            [String]
            $UserListPath = ''
        )
        
    Begin{

            $CurrentDate = Get-Date -Format "yyyy-MM-dd T HH.mm.ss"
            $ExportPath = "C:\GIT\PowerShell\Input-Output\$CurrentDate.csv"
        }

    Process{
        
        if ($ADSecurityGroup) {
    
        $Users= (Get-ADGroupMember -Identity $ADSecurityGroup | Select-Object -ExpandProperty SamAccountName)
            $Users | ForEach-Object -Process {
                Get-ADUser -Identity $_ -Properties Name, ExtensionAttribute6, Enabled, UserPrincipalName | 
                    Where-Object {$_.Enabled -like "True"} |
                    Where-Object {$_.extensionAttribute6 -cnotlike "*SS|A|ITS*"} | 
                    Where-Object {$_.extensionAttribute6 -ne $null} | 

                    ### Above criteria removes IT staff and disabled users.

                Select-Object Name, UserPrincipalName, ExtensionAttribute6, Enabled |

                Export-Csv -Path $ExportPath -NoTypeInformation -Append -Force
            } #BREAK LOOP
        }
        
        if ($UserListPath) {

            Get-Content -Path $UserListPath | 
            ForEach-Object -Process {
                Get-ADUser -Identity $_ -Properties Name, ExtensionAttribute6, Enabled, UserPrincipalName | 
                Where-Object {$_.Enabled -like "True"} |
                Where-Object {$_.extensionAttribute6 -cnotlike "*SS|A|ITS*"} | 
                Where-Object {$_.extensionAttribute6 -ne $null} | 

                    ### Above criteria removes IT staff and disabled users.

            Select-Object Name, UserPrincipalName, ExtensionAttribute6, Enabled |
            Export-Csv -Path $ExportPath -NoTypeInformation -Append -Force
            }
        } #BREAK LOOP
        Invoke-Item -Path $ExportPath
    }

    }

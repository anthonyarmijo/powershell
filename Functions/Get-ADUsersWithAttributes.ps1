function Get-ADUsersWithAttributes {
    [CmdletBinding()]
    param (
        
        [Parameter()]
        [String[]] #adding the [] tells PS that you can accept 1 or more values
        $ExtensionAttribute10 = '.*',

        [Parameter()]
        [String[]]
        $ExtensionAttribute11 = '.*',

        [Parameter()]
        [String[]]
        $ExtensionAttribute13 = '.*',

        [Parameter()]
        [String[]]
        $Division = '.*',

        [Parameter()]
        [String[]]
        $Title = '.*'
    
    )
    
    begin {
        
    }
    
    process {

        $ExtensionAttribute10 = $ExtensionAttribute10 -join '|'
        $ExtensionAttribute11 = $ExtensionAttribute11 -join '|'
        $ExtensionAttribute13 = $ExtensionAttribute13 -join '|'
        $Division = $Division -join '|'
        $Title = $Title -join '|'

        $AllUsers = Get-ADUser -Filter 'Enabled -eq "true"' -Properties Title, extensionattribute10, extensionattribute11, extensionattribute13, Division, whenCreated

$AllUsers | Where-Object {
    ($_.extensionattribute10 -Match $ExtensionAttribute10) -and
    ($_.extensionattribute11 -Match $ExtensionAttribute11) -and
    ($_.extensionattribute13 -Match $ExtensionAttribute13) -and
    ($_.division -Match $Division)                         -and
    ($_.title -Match $Title) } | 
    
    Select-Object Name, ExtensionAttribute10, ExtensionAttribute11, ExtensionAttribute13, Division, Title, whenCreated| 
    Sort-Object -Descending -Property whenCreated, ExtensionAttribute10, ExtensionAttribute11, ExtensionAttribute13 ####|
    ####Export-CSV -Path C:\Temp\output.csv -NoTypeInformation



    }
    
    end {
        
    }
}
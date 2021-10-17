function Invoke-VSCodiumUpdateCheck {
    <#
        .SYNOPSIS
            Checks your local version against the latest
        .DESCRIPTION
            Gets the file version and compares it to the latest GitHub Version
        .PARAMETER VSCodiumEXEPath
            Path to installed VSCodium
        .EXAMPLE
            Invoke-VSCodiumUpdateCheck -VSCodiumEXEPath "C:\Temp\VSCodium\VSCodium.exe"
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)][string]$VSCodiumEXEPath
    ) 
    BEGIN { 
        $CurrentVersion = (Get-Item $VSCodiumEXEPath).VersionInfo.ProductVersion

        $LiveVSCodium = invoke-restmethod 'https://api.github.com/repos/VSCodium/vscodium/releases/latest'
        $LiveVersion = $LiveVSCodium.tag_name
    } #BEGIN

    PROCESS {
        if ($LiveVersion -gt $CurrentVersion) {
            $VSCodiumUpdateCheck = @{
                LiveVersion    = $LiveVersion
                CurrentVersion = $CurrentVersion
                Status         = 'Outdated'
            } 
        }

        if ($LiveVersion -le $CurrentVersion) {
            $VSCodiumUpdateCheck = @{
                LiveVersion    = $LiveVersion
                CurrentVersion = $CurrentVersion
                Status         = 'Current'
            } 
        }
    } #PROCESS

    END { 
        $VSCodiumUpdateCheck
    } #END

} #FUNCTION
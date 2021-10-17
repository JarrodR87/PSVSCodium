function Invoke-VSCodiumDL {
    <#
        .SYNOPSIS
            Downloads the latest release of VSCodium from GitHub
        .DESCRIPTION
            Downloads the Zipped version of the latest release of VSCodium from GitHub
        .PARAMETER Path
            Path to save the Zip file to
        .EXAMPLE
            Invoke-VSCodiumDL -Path 'C:\Temp'
    #>
    [CmdletBinding()]
    Param(
        
        [Parameter(Mandatory = $true)]$Path
    )
    BEGIN {        
        $Path = $Path.Trimend('\')
        $Path = $Path + '\'


        $VSCodium = invoke-restmethod 'https://api.github.com/repos/VSCodium/vscodium/releases/latest'
        $VSCodiumW64Zip = $VSCodium.assets | Where-Object -FilterScript { $_.name -like '*win32*x64*zip' }
        $DownloadLink = $VSCodiumW64Zip.browser_download_url
        $DLPath = $Path + $VSCodiumW64Zip.name
    } #BEGIN


    PROCESS {
        Invoke-WebRequest $DownloadLink -OutFile $DLPath
    } #PROCESS

    END { 
        $DLPath
    } #END

} #FUNCTION
function Invoke-VSCodiumUpdate {
    <#
        .SYNOPSIS
            Updates Local Copy of VSCodium if an update is available
        .DESCRIPTION
            Checks your Local versus GitHub Version and will update if needed
        .PARAMETER VSCodiumEXEPath
            Path to installed VSCodium
        .PARAMETER VSCodiumTempPath
            Path to Download VSCodium
        .EXAMPLE
            Invoke-VSCodiumUpdate -VSCodiumEXEPath "C:\Temp\VSCodium\VSCodium.exe" -VSCodiumTempPath "C:\Temp\"
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)][string]$VSCodiumEXEPath,
        [Parameter(Mandatory = $true)][string]$VSCodiumTempPath
    ) 
    BEGIN { 
        $UpdateCheck = Invoke-VSCodiumUpdateCheck -VSCodiumEXEPath $VSCodiumEXEPath
        $UpdateCheckStatus = $UpdateCheck.Status

        $LocalVSCodiumPath = (Get-Item $VSCodiumEXEPath).Directory.FullName
    } #BEGIN

    PROCESS {
        if ($UpdateCheckStatus -eq 'Outdated') {
            $TempDownload = Invoke-VSCodiumDL -Path $VSCodiumTempPath
            Remove-LocalVSCodiumFiles -VSCodiumEXEPath $VSCodiumEXEPath
            Expand-Archive -LiteralPath $TempDownload -DestinationPath $LocalVSCodiumPath
            Remove-Item $TempDownload -Force
        }
        if ($UpdateCheckStatus -eq 'Current') {
            Write-Host 'Version Running Locally is Current'
        }
    } #PROCESS

    END { 
        $LocalVSCodiumPath
    } #END

} #FUNCTION
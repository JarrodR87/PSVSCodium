function Remove-LocalVSCodiumFiles {
    <#
        .SYNOPSIS
            Clears all Files and Folders excluding the Data Folder
        .DESCRIPTION
            Removes all Files and Folders in prepearation to replace them with an Update
        .PARAMETER VSCodiumEXEPath
            Path to installed VSCodium
        .EXAMPLE
            Remove-LocalVSCodiumFiles -VSCodiumEXEPath "C:\Temp\VSCodium\VSCodium.exe"
    #>
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory = $true)][string]$VSCodiumEXEPath
    ) 
    BEGIN { 
        $LocalVSCodiumPath = (Get-Item $VSCodiumEXEPath).Directory.FullName
    } #BEGIN

    PROCESS {
        $LocalVSCodiumDirectories = (Get-ChildItem -Path  $LocalVSCodiumPath -Exclude 'Data' -Directory)
        foreach ($LocalVSCodiumDirectory in $LocalVSCodiumDirectories) {
            Get-ChildItem $LocalVSCodiumDirectory -Recurse | Remove-Item -Recurse -Force
            Get-Item $LocalVSCodiumDirectory | Remove-Item -Recurse -Force
        }

        $LocalVSCodiumFiles = (Get-ChildItem -Path  $LocalVSCodiumPath -File)
        foreach ($LocalVSCodiumFile in $LocalVSCodiumFiles) {
            Get-Item $LocalVSCodiumFile | Remove-Item -Recurse -Force
        }
    } #PROCESS

    END { 

    } #END

} #FUNCTION
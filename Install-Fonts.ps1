function New-TemporaryDirectory {
    $parent = [System.IO.Path]::GetTempPath()
    $name = [System.IO.Path]::GetRandomFileName()
    New-Item -ItemType Directory -Path (Join-Path $parent $name)
}

function Install-Fonts {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        [System.IO.FileInfo[]]
        $FontFiles
    )
    
    # Based on https://github.com/powerline/fonts/blob/master/install.ps1
    $shellApp = New-Object -ComObject shell.application
    # ssfFONTS (0x14): Virtual folder that contains installed fonts. A typical path is C:\Windows\Fonts.
    $fonts = $shellApp.NameSpace(0x14)
    # Copy fonts to temp. dir to install them all at once
    $tempDir = New-TemporaryDirectory
    $tempDirShell = $shellApp.NameSpace($tempDir.FullName)

    foreach ($fontFile in $FontFiles) {
        if ($PSCmdlet.ShouldProcess($fontFile.Name, "Install Font")) {
            Copy-Item -Path $fontFile -Destination $tempDir
        }
    }
    $fonts.CopyHere($tempDirShell.Items())
    Remove-Item -Force -Recurse $tempDir
}
$config = Join-Path $PSScriptRoot "alacritty.yml" | Get-Item
$configDir = Join-Path $env:APPDATA "alacritty"
$firaCodeDownloadUri = "https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip"

function Install-All {
    [CmdletBinding()]
    param ()
    
    Write-Verbose "Alacritty: Checking for Alacritty"
    # Installing alacrity if necassary
    if ($null -eq (Get-Command alacritty -ErrorAction SilentlyContinue)) {
        scoop install alacritty
    }

    Write-Verbose "Alacritty: Checking for Fira Code"
    # Downlaod and install Fira Code
    if (!(Test-Path fira-code)) {
        Invoke-WebRequest -Uri $firaCodeDownloadUri -OutFile "FiraCode_2.zip"
        Expand-Archive -Path "FiraCode_2.zip" -DestinationPath "fira-code"
        $fonts = Get-ChildItem .\fira-code\ttf
        Install-Fonts -FontFiles $fonts

        Remove-Item "FiraCode_2.zip"
    }

    Write-Verbose "Alacritty: Linking configs"
    Write-Verbose "Alacritty: Linking: '$configDir\alacritty.yml' to '$($config.FullName)'"
    # Create alacritty dir
    New-Item -Force -Path $configDir -ItemType Directory > $null
    New-Item -Force -Path "$configDir\alacritty.yml" -ItemType SymbolicLink -Value ($config.FullName) > $null
}

function Uninstall-All {
    [CmdletBinding()]
    param ()
    
    # Uninstalling alacrity if necassary
    if ($null -eq (Get-Command alacritty -ErrorAction SilentlyContinue)) {
        scoop uninstall alacritty
    }

    if (Test-Path $configDir) {
        Remove-Item -Recurse $configDir
    }
}

Export-ModuleMember -Function Install-All,Uninstall-All
function Install-All {
    [CmdletBinding()]
    param ()

    # Installing alacrity if necassary
    if ($null -eq (Get-Command alacritty -ErrorAction SilentlyContinue)) {
        scoop install alacritty
    }
}

function Uninstall-All {
    [CmdletBinding()]
    param ()
    
    # Uninstalling alacrity if necassary
    if ($null -eq (Get-Command alacritty -ErrorAction SilentlyContinue)) {
        scoop uninstall alacritty
    }
}
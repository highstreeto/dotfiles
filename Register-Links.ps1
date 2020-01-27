#Requires -RunAsAdministrator

$pwshProfile = Get-Item .\pwsh\profile.ps1
$alacrittyConfig = Get-Item .\alacritty\alacritty.yml
$vsCodeConfig = Get-Item .\vscode\settings.json
$windowsTerminalConfig = Get-Item .\windows-terminal\profiles.json
$starshipConfig = Get-Item .\starship\starship.toml

. .\ColorPrompts.ps1

# Use symbolic links as they are as easily broken as hard links
# But symbolic links require elevation

# pwsh
Write-Starter -Prefix "Creating links for " -Item "pwsh" -OneLine
New-Item -Force -Path ($profile.CurrentUserAllHosts) -ItemType SymbolicLink -Value ($pwshProfile.FullName) > $null
Write-Finisher -OneLine

# alacritty
Write-Starter -Prefix "Creating links for " -Item "alacritty" -OneLine
# Create alacritty dir
New-Item -Force -Path "$env:APPDATA\alacritty" -ItemType Directory > $null
New-Item -Force -Path "$env:APPDATA\alacritty\alacritty.yml" -ItemType SymbolicLink -Value ($alacrittyConfig.FullName) > $null
Write-Finisher -OneLine

# starship
Write-Starter -Prefix "Creating links for " -Item "starship" -OneLine
# Create starship dir
New-Item -Force -Path "~\.config" -ItemType Directory > $null
New-Item -Force -Path "~\.config\starship.toml" -ItemType SymbolicLink -Value ($starshipConfig.FullName) > $null
Write-Finisher -OneLine

# vscode
$vscodeCurrentConfig = "$env:APPDATA\Code\User\settings.json"

Write-Starter -Prefix "Creating links for " -Item "VS Code" -OneLine
# Create config dir
New-Item -Force -Path "$env:APPDATA\Code\User" -ItemType Directory > $null
New-Item -Force -Path $vscodeCurrentConfig -ItemType SymbolicLink -Value ($vsCodeConfig.FullName) > $null
Write-Finisher -OneLine

# windows-terminal
$windowsTerminalCurrentConfig = "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json"

Write-Starter -Prefix "Creating links for " -Item "Windows Terminal" -OneLine
# Create config dir
New-Item -Force -Path "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -ItemType Directory > $null
New-Item -Force -Path $windowsTerminalCurrentConfig -ItemType SymbolicLink -Value ($windowsTerminalConfig.FullName) > $null
Write-Finisher -OneLine
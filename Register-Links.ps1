#Requires -RunAsAdministrator

$pwshProfile = Get-Item .\pwsh\profile.ps1
$psGitConfig = Get-Item .\pwsh\psgit-config.psd1
$powerlineConfig = Get-Item .\pwsh\powerline-config.psd1
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
Write-Finisher

# alacritty
Write-Starter -Prefix "Creating links for " -Item "alacritty" -OneLine
# Create alacritty dir
New-Item -Force -Path "$env:APPDATA\alacritty" -ItemType Directory > $null
New-Item -Force -Path "$env:APPDATA\alacritty\alacritty.yml" -ItemType SymbolicLink -Value ($alacrittyConfig.FullName) > $null
Write-Finisher

# starship
Write-Starter -Prefix "Creating links for " -Item "starship" -OneLine
# Create starship dir
New-Item -Force -Path "~\.config" -ItemType Directory > $null
New-Item -Force -Path "~\.config\starship.toml" -ItemType SymbolicLink -Value ($starshipConfig.FullName) > $null
Write-Finisher

# psgit
$psGitCurrentConfig = "$env:APPDATA\powershell\PoshCode\PSGit\Configuration.psd1"

Write-Starter -Prefix "Creating links for " -Item "PSGit" -OneLine
# Create config dir
New-Item -Force -Path "$env:APPDATA\powershell\PoshCode\PSGit" -ItemType Directory > $null
New-Item -Force -Path $psGitCurrentConfig -ItemType SymbolicLink -Value ($psGitConfig.FullName) > $null
Write-Finisher

# powerline
$powerlineCurrentConfig = "$env:APPDATA\powershell\HuddledMasses.org\PowerLine\Configuration.psd1"

Write-Starter -Prefix "Creating links for " -Item "PowerLine" -OneLine
# Create config dir
New-Item -Force -Path "$env:APPDATA\powershell\HuddledMasses.org\PowerLine" -ItemType Directory > $null
New-Item -Force -Path $powerlineCurrentConfig -ItemType SymbolicLink -Value ($powerlineConfig.FullName) > $null
Write-Finisher

# vscode
$vscodeCurrentConfig = "$env:APPDATA\Code\User\settings.json"

Write-Starter -Prefix "Creating links for " -Item "VS Code" -OneLine
# Create config dir
New-Item -Force -Path "$env:APPDATA\Code\User" -ItemType Directory > $null
New-Item -Force -Path $vscodeCurrentConfig -ItemType SymbolicLink -Value ($vsCodeConfig.FullName) > $null
Write-Finisher

# windows-terminal
$windowsTerminalCurrentConfig = "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json"

Write-Starter -Prefix "Creating links for " -Item "Windows Terminal" -OneLine
# Create config dir
New-Item -Force -Path "$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -ItemType Directory > $null
New-Item -Force -Path $windowsTerminalCurrentConfig -ItemType SymbolicLink -Value ($windowsTerminalConfig.FullName) > $null
Write-Finisher
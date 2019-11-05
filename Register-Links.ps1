$pwshProfile = Get-Item .\pwsh\profile.ps1
$psGitConfig = Get-Item .\pwsh\psgit-config.psd1
$alacrittyConfig = Get-Item .\alacritty\alacritty.yml

. .\ColorPrompts.ps1

# Use HardLinks as they do not require elevation
# See https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.management/new-item?view=powershell-6

# pwsh
Write-Starter -Prefix "Creating links for " -Item "pwsh" -OneLine
New-Item -Force -Path ($profile.CurrentUserAllHosts) -ItemType HardLink -Value ($pwshProfile.FullName) > $null
Write-Finisher

# alacritty
Write-Starter -Prefix "Creating links for " -Item "alacritty" -OneLine
New-Item -Force -Path "$env:APPDATA\alacritty" -ItemType Directory > $null
New-Item -Force -Path "$env:APPDATA\alacritty\alacritty.yml" -ItemType HardLink -Value ($alacrittyConfig.FullName) > $null
Write-Finisher

# psgit
Write-Starter -Prefix "Creating links for " -Item "PSGit" -OneLine
New-Item -Force -Path "$env:APPDATA\powershell\PoshCode\PSGit" -ItemType Directory > $null
$psGitCurrentConfig = "$env:APPDATA\powershell\PoshCode\PSGit\Configuration.psd1"
New-Item -Force -Path $psGitCurrentConfig -ItemType HardLink -Value ($psGitConfig.FullName) > $null
Write-Finisher
. .\ColorPrompts.ps1

if ($null -eq (Get-Command pwsh -ErrorAction SilentlyContinue)) {
    Write-Error "PowerShell Core must be installed!"
}

Install-Module Pansies -AllowClobber
Install-Module PowerLine
Install-Package PSGit

# Installing scoop if necassary
if ($null -eq (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Starter -Prefix "Installing " -Item "scoop"
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
    Write-Finisher
}

# Installing alacrity if necassary
if ($null -eq (Get-Command alacritty -ErrorAction SilentlyContinue)) {
    Write-Starter -Prefix "Installing " -Item "alacritty"
    scoop install alacritty
    Write-Finisher
}

# Clone Powerline fonts
if (!(Test-Path powerline-fonts)) {
    Write-Starter -Prefix "Cloning and installing " -Item "powerline-fonts"
    git clone https://github.com/powerline/fonts.git powerline-fonts
    .\powerline-fonts\install.ps1 "DejaVu Sans Mono*"
    Write-Finisher
}

Write-Host -NoNewline "All Done! Use "
Write-Host -NoNewline -ForegroundColor Cyan "Register-Links.ps1"
Write-Host " to hook-up the configs."
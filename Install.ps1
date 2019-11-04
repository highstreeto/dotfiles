. .\ColorPrompts.ps1

Install-Module Pansies -AllowClobber
Install-Module PowerLine
Install-Package PSGit

# Installing scoop
if ($null -eq (Get-Command scoop -ErrorAction SilentlyContinue)) {
    Write-Starter -Prefix "Installing " -Item "scoop"
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
    Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
}

scoop install sudo
scoop install alacritty
sudo sudo scoop install -g pwsh

# Clone Powerline fonts
if (!(Test-Path powerline_fonts)) {
    Write-Starter -Prefix "Cloning and installing " -Item "powerline_fonts"
    git clone https://github.com/powerline/fonts.git powerline_fonts
    .\powerline_fonts\install.ps1 "DejaVu Sans Mono*"
    Write-Finisher
}

Write-Host -NoNewline "All Done! Use "
Write-Host -NoNewline -ForegroundColor Cyan "Register-Links.ps1"
Write-Host " to hook-up the configs."
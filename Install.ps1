. .\ColorPrompts.ps1
. .\Install-Fonts.ps1

$firaCodeDownloadUri = "https://github.com/tonsky/FiraCode/releases/download/2/FiraCode_2.zip"
$nerdFontsDejaVuSansMono = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/DejaVuSansMono.zip"
# Nerd Fonts Fira Code is a bit weird - so just use standard fira code
# $nerdFontsFiraCodeDownloadUri = "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.0.0/FiraCode.zip"

if ($null -eq (Get-Command pwsh -ErrorAction SilentlyContinue)) {
    Write-Error "PowerShell Core must be installed!"
}

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

# Installing starship if necassary
if ($null -eq (Get-Command starship -ErrorAction SilentlyContinue)) {
    Write-Starter -Prefix "Installing " -Item "starship"
    scoop install starship
    Write-Finisher
}

# Downlaod and install Fira Code
if (!(Test-Path fira-code)) {
    Write-Starter -Prefix "Downloading and installing " -Item "Fira Code" -OneLine
    Invoke-WebRequest -Uri $firaCodeDownloadUri -OutFile "FiraCode_2.zip"
    Expand-Archive -Path "FiraCode_2.zip" -DestinationPath "fira-code"
    $fonts = Get-ChildItem .\fira-code\ttf
    Install-Fonts -FontFiles $fonts

    Remove-Item "FiraCode_2.zip"
    Write-Finisher
}

# Downlaod and install Nerd Fonts DejaVu Sans Mono
if (!(Test-Path nerd-fonts-dejavu)) {
    Write-Starter -Prefix "Downloading and installing " -Item "Nerd Fonts DejaVu Sans Mono" -OneLine
    Invoke-WebRequest -Uri $nerdFontsDejaVuSansMono -OutFile "NFDejaVuSansMono.zip"
    Expand-Archive -Path "NFDejaVuSansMono.zip" -DestinationPath "nerd-fonts-dejavu"
    $fonts = Get-ChildItem ".\nerd-fonts-dejavu\*Complete Windows Compatible.ttf"
    Install-Fonts -FontFiles $fonts

    Remove-Item "NFDejaVuSansMono.zip"
    Write-Finisher
}

Write-Host -NoNewline "All Done! Use "
Write-Host -NoNewline -ForegroundColor Cyan "Register-Links.ps1"
Write-Host " (run as admin) to hook-up the configs."
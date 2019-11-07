# .dotfiles

My dotfiles for Windows

* Uses [Powershell Core](https://github.com/powershell/powershell)
* Includes [Powerline](https://github.com/Jaykul/PowerLine) support
  * Currently basic infos. and git status are displayed

## Initial Setup 

`./Install.ps1`

## Register Links 

`./Register-Links.ps1`

## Location of configuration files (on Windows)

* Alacritty
  * `$env:APPDATA\alacritty\alacritty.yml`
* PSGit
  * `$env:APPDATA\powershell\PoshCode\PSGit\Configuration.psd1`
* Windows Terminal
  * `$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json`

## TODOs

* [ ] Replace DejaVu Sans Mono for Powerline with [nerd_fonts](https://github.com/ryanoasis/nerd-fonts)
* [ ] Replace `Set-PowerLinePrompt` with loading of configuration (similar to PSGit)
  * Could be faster, investigate!

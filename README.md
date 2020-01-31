# .dotfiles

My dotfiles for Windows

* Uses [Powershell Core](https://github.com/powershell/powershell)
* ~~Includes [PowerLine](https://github.com/Jaykul/PowerLine) support~~
  * ~~Shortened current path~~
  * ~~Git status (provided by [PSGit](https://github.com/PoshCode/PSGit))~~
  * ~~Battery level~~
  * ~~Currently running jobs~~
  * Currently not included, as the current solution takes too long
    * Seconds before pwsh is ready
* Configs for
  * [Visual Studio Code](https://github.com/Microsoft/vscode)
  * [Alacritty](https://github.com/jwilm/alacritty)
  * [Windows Terminal](https://github.com/Microsoft/Terminal)

## Initial Setup

`./Install.ps1`

## Register Links

`./Register-Links.ps1` (needs admin because of symbolic links)

## Location of configuration files (on Windows)

* Alacritty
  * `$env:APPDATA\alacritty\alacritty.yml`
* PSGit
  * `$env:APPDATA\powershell\PoshCode\PSGit\Configuration.psd1`
* PowerLine
  * `$env:APPDATA\powershell\HuddledMasses.org\PowerLine\Configuration.psd1`
* Windows Terminal
  * `$env:LocalAppData\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\profiles.json`

## TODOs

* [x] Replace DejaVu Sans Mono for PowerLine with [nerd_fonts](https://github.com/ryanoasis/nerd-fonts)
* [x] Replace `Set-PowerLinePrompt` with loading of configuration (similar to PSGit)
  * Could be faster, investigate!
  * Loading takes 43ms with `Import-Module`, with `Set-PowerLinePrompt` it takes 90ms
* [ ] Use `Get-ConfigurationPath` for Powershell module config lookup
  * Works cross-plattform (tested on [mcr.microsoft.com/powershell:alpine-3.8](https://hub.docker.com/_/microsoft-powershell))
* [ ] Generalize linking of config. files
  * Currently Copy-Paste => function would be better!
  * Input could be hash table with source and destination file
* [ ] Add CPU and RAM usage indicators to prompt
  * Not easily done in a cross-plattform way
* [ ] Adapt PSGit color scheme
  * Currently PowerLine provided colors => change to better fitting colors
* [ ] Look into [Starship](https://github.com/starship/starship) (works now on Windows)
* [ ] Add Git config
  * User and mail, autoclrf, editor

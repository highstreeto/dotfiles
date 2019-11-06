#requires -Modules @{ ModuleName='Pansies'; ModuleVersion='1.2.1' }
#requires -Modules @{ ModuleName='PowerLine'; ModuleVersion='3.1.2' }
#Requires -Modules @{ ModuleName='PSGit'; ModuleVersion='2.1.0' }

Import-Module PSGit

function Get-PowerLineLocation () {
    [CmdletBinding()]
    param (
        [Parameter()]
        [int]
        $MaxSegmentCount = 5
    )
    $dirs = (Get-Location).ProviderPath.Split([System.IO.Path]::DirectorySeparatorChar)
    if ($dirs.Count -gt $MaxSegmentCount) {
        New-PromptText -Bg "#083FA0" -Fg White "..."
        foreach ($dir in $dirs | Select-Object -Last $MaxSegmentCount) {
            New-PromptText -Bg "#083FA0" -Fg White $dir
        }
    } else {
        foreach ($dir in $dirs) {
            New-PromptText -Bg "#083FA0" -Fg White $dir
        }
    }
}

Set-PowerLinePrompt -SetCurrentDirectory -RestoreVirtualTerminal -PowerLineFont -FullColor -Prompt @(
    { New-PromptText -Bg "#196DFF" -ElevatedBackgroundColor "#FF5D00" -Fg White $MyInvocation.HistoryId }
    { Get-PowerLineLocation }
    { Get-GitStatusPowerLine }
    { "`t" }
    { New-PromptText -Fg White (Get-Elapsed) }
    { New-PromptText -Fg White (Get-Date -f "T") }
    { "`n" }
    { New-PromptText -Fg Green -EFg Red -Bg Black "❯" }
) -Colors Blue, DarkBlue, DarkBlue, Blue
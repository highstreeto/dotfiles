#Requires -Modules @{ ModuleName='Pansies'; ModuleVersion='1.2.1' }
#Requires -Modules @{ ModuleName='PowerLine'; ModuleVersion='3.1.2' }
#Requires -Modules @{ ModuleName='PSGit'; ModuleVersion='2.1.0' }

# $VerbosePreference = "Continue"

$timer = [System.Diagnostics.Stopwatch]::StartNew()

function Get-LocationPowerLine () {
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
    }
    else {
        foreach ($dir in $dirs) {
            New-PromptText -Bg "#083FA0" -Fg White $dir
        }
    }
}

function Get-BatteryStatusPowerLine {
    $battery = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue
    if ($battery) {
        $remainingCharge = $battery.EstimatedChargeRemaining
        if ($remainingCharge -ge 95) {
            New-PromptText -Bg Black -Fg DarkGreen "  "
        } elseif ($remainingCharge -ge 80) {
            New-PromptText -Bg Black -Fg DarkGreen "  "
        } elseif ($remainingCharge -ge 50 ) {
            New-PromptText -Bg Black -Fg DarkGreen "  "
        } elseif ($remainingCharge -ge 20) {
            New-PromptText -Bg Black -Fg DarkGreen "  "
        } else {
            New-PromptText -Bg Black -Fg DarkGreen "  "
        }
    }
}


[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8
Import-Module PSGit
Import-Module PowerLine

$timer.Stop()
"Loading of profile took {0:F2}ms" -f $timer.Elapsed.TotalMilliseconds | Write-Verbose
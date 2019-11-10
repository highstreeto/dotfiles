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
    $icons = @(
        @{level = 97; icon = ""}
        @{level = 90; icon = ""}
        @{level = 80; icon = ""}
        @{level = 70; icon = ""}
        @{level = 60; icon = ""}
        @{level = 50; icon = ""}
        @{level = 40; icon = ""}
        @{level = 30; icon = ""}
        @{level = 20; icon = ""}
        @{level = 10; icon = ""}
        @{level = 0; icon = ""}
    )
    
    $battery = Get-CimInstance Win32_Battery -ErrorAction SilentlyContinue
    if ($battery) {
        $remainingCharge = $battery.EstimatedChargeRemaining
        New-PromptText -Bg Black -Fg DarkGreen (
            $icons | Where-Object {$_.level -le $remainingCharge} | Select-Object -First 1
        )
    }
}


[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8
Import-Module PSGit
Import-Module PowerLine

$timer.Stop()
"Loading of profile took {0:F2}ms" -f $timer.Elapsed.TotalMilliseconds | Write-Verbose
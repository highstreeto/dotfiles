# $VerbosePreference = "Continue"

$timer = [System.Diagnostics.Stopwatch]::StartNew()

[Console]::OutputEncoding = [Text.UTF8Encoding]::UTF8

$timer.Stop()
"Loading of profile took {0:F2}ms" -f $timer.Elapsed.TotalMilliseconds | Write-Verbose
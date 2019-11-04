function Write-Starter {
    param (
        [string]$Prefix,
        [string]$Item,
        [switch]$OneLine
    )
    Write-Host -NoNewline $Prefix
    Write-Host -NoNewline -ForegroundColor Cyan $Item

    if ($OneLine) { Write-Host -NoNewline  " ..." }
    else { Write-Host " ..." }
}

function Write-Finisher {
    param (
        [switch]$OneLine
    )
    if ($OneLine) { Write-Host -ForegroundColor Green  " Done" }
    else { Write-Host -ForegroundColor Green "Done!" }
}

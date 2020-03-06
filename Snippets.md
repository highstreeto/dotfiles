# Useful PowersShell snippets

## Get child processes of current shell

```powershell
$childProcs = Get-Process | Where-Object { $_.Parent.Id -eq $PID }
if ($childProcs) {
    "`n"
    $childProcs |
        Select-Object -ExpandProperty Name |
        Join-String -OutputPrefix "Childs: " -Separator ", " |
        New-PromptText -Bg "#333333" -Fg Gray
}
```

## Kill and remove all Docker containers

```powershell
docker ps -q -a | foreach { docker kill $_ *>&1 > $null; docker rm $_ }
```
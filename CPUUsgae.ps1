#Requires -Module @{ ModuleName = 'Graphical'; ModuleVersion = '1.0.2' }

function Get-SumOfCpuUsage() {
    $sum = [timespan]::Zero;
    foreach ($proc in Get-Process) {
        if ($proc.TotalProcessorTime) {
            $sum += $proc.TotalProcessorTime;
        } elseif ($proc.Id -eq 0) {
            # Ignore Idle process
        } else {
           Write-Warning "Could not CPU of $proc!"
        }
    }
    $sum
}

$cpus = [System.Environment]::ProcessorCount
$data = @()
while ($true) {
    $startTime = Get-Date
    $startCpu = Get-SumOfCpuUsage

    Start-Sleep -Seconds 2

    $endTime = Get-Date
    $endCpu = Get-SumOfCpuUsage
    $cpuUsedMs = ($endCpu - $startCpu).TotalMilliseconds
    $timeMs = ($endTime - $startTime).TotalMilliseconds

    $cpuUsage = $cpuUsedMs / ($cpus * $timeMs) * 100
    $data += $cpuUsage

    Clear-Host
    Show-Graph -Datapoints $data -GraphTitle "CPU Usage" -XAxisTitle "Time" -YAxisTitle "CPU %" -YAxisStep 10
}
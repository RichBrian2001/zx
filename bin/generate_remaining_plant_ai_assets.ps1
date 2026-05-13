param(
    [string]$ApiKey = $env:ZHIPU_API_KEY,
    [double]$SleepSeconds = 1,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'

$repoRoot = Split-Path -Parent $PSScriptRoot
$pythonExe = Join-Path $repoRoot '.venv\Scripts\python.exe'

if (-not (Test-Path $pythonExe)) {
    throw "Python executable not found: $pythonExe"
}

if (-not $ApiKey) {
    throw 'Missing API key. Pass -ApiKey or set ZHIPU_API_KEY.'
}

$remainingPlantIds = @(
    1007,1008,1009,1010,1011,1012,
    1017,1018,1019,1020,1021,1022,1023,
    1028,1029,1030,1031,1032,1033,1034,1035,
    1040,1041,1042,1043,1044,1045,1046
) -join ','

$arguments = @(
    'bin/generate_plant_ai_assets.py',
    '--overwrite',
    '--sleep-seconds', $SleepSeconds,
    '--plant-ids', $remainingPlantIds,
    '--api-key', $ApiKey
)

if ($DryRun) {
    $arguments += '--dry-run'
}

Push-Location $repoRoot
try {
    & $pythonExe @arguments
}
finally {
    Pop-Location
}
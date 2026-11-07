# At a session's start on Windows without Git Bash: an esteem on the PATH is left alone; otherwise the published
# installer, which verifies its SHA-256. A PowerShell hook has no CLAUDE_ENV_FILE, so this session is told the path.
$ErrorActionPreference = 'Stop'
if (Get-Command esteem -ErrorAction SilentlyContinue) { exit 0 }
$dir = if ($env:ESTEEM_INSTALL_DIR) { $env:ESTEEM_INSTALL_DIR } else { "$env:LOCALAPPDATA\Programs\esteem" }
$distHost = if ($env:ESTEEM_DIST_HOST) { $env:ESTEEM_DIST_HOST } else { 'https://cli.esteem.team' }
if (-not (Test-Path "$dir\esteem.exe")) { Invoke-RestMethod "$distHost/install.ps1" | Invoke-Expression | Out-Null }
Write-Output "The esteem command is at $dir\esteem.exe until the next session: run it by that path."

@echo off
REM The esteem CLI for Claude Code's PowerShell and cmd on Windows: runs the installed binary, and
REM installs it on first use with the published installer, which verifies its SHA-256.
setlocal
if not defined ESTEEM_DIST_HOST set "ESTEEM_DIST_HOST=https://cli.esteem.team"
if not defined ESTEEM_INSTALL_DIR set "ESTEEM_INSTALL_DIR=%LOCALAPPDATA%\Programs\esteem"
if not exist "%ESTEEM_INSTALL_DIR%\esteem.exe" (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "irm $env:ESTEEM_DIST_HOST/install.ps1 | iex" 1>nul || exit /b 1
)
"%ESTEEM_INSTALL_DIR%\esteem.exe" %*
exit /b %ERRORLEVEL%

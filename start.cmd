@echo off
chcp 65001 > nul
setlocal

if not exist .env (
    echo .env not found.
    exit /b 1
)

for /f "usebackq tokens=1,2 delims==" %%a in (".env") do (
    if not "%%a"=="" set "%%a=%%b
)

if "%OPENCODE_GO_API_KEY%"=="" (
    echo OPENCODE_GO_API_KEY is not set in .env
    exit /b 1
)

if "%PROXY_PORT%"=="" set "PROXY_PORT=4000"

echo Starting claude-to-opencode bridge on :%PROXY_PORT%
echo   Set ANTHROPIC_BASE_URL=http://localhost:%PROXY_PORT% in Claude Code
echo.

bridge.exe

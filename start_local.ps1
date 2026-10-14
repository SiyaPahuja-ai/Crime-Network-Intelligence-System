# Crime Network Intelligence System (CNIS) - Local Launch Script
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
Set-Location $ScriptDir

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host " Starting Crime Network Intelligence System (CNIS) " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# Start FastAPI Backend
Write-Host "Starting FastAPI Backend on http://127.0.0.1:8000 ..." -ForegroundColor Green
$BackendProcess = Start-Process -FilePath "$ScriptDir\.venv\Scripts\python.exe" -ArgumentList "-m uvicorn server.main:app --host 127.0.0.1 --port 8000" -WorkingDirectory $ScriptDir -PassThru

# Start Vite Frontend
Write-Host "Starting Vite Frontend on http://127.0.0.1:5173 ..." -ForegroundColor Green
$FrontendProcess = Start-Process -FilePath "npm.cmd" -ArgumentList "run dev -- --host 127.0.0.1 --port 5173" -WorkingDirectory "$ScriptDir\frontend" -PassThru

Start-Sleep -Seconds 3

# Open Browser
Write-Host "Opening Application in browser ..." -ForegroundColor Yellow
Start-Process "http://127.0.0.1:5173"

Write-Host "CNIS is running!" -ForegroundColor Cyan
Write-Host "Backend PID: $($BackendProcess.Id) | Frontend PID: $($FrontendProcess.Id)" -ForegroundColor Cyan

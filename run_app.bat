@echo off
cd /d "%~dp0"

echo Building React frontend...
cd frontend
call npm run build
if errorlevel 1 (
    echo Frontend build failed.
    pause
    exit /b 1
)

cd /d "%~dp0"
echo Starting Python backend and serving React at http://127.0.0.1:8000
call run_backend.bat

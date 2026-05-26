@echo off
cd /d "%~dp0frontend"
call npm run build
call npm run preview -- --host 127.0.0.1 --port 5173

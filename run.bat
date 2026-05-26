@echo off
set "BUNDLED_PYTHON=C:\Users\SAI KEERTHI\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"

if exist "%BUNDLED_PYTHON%" (
    "%BUNDLED_PYTHON%" "%~dp0app.py" %*
) else (
    python "%~dp0app.py" %*
)

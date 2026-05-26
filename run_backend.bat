@echo off
set "BUNDLED_PYTHON=C:\Users\SAI KEERTHI\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe"

if exist "%BUNDLED_PYTHON%" (
    "%BUNDLED_PYTHON%" -m uvicorn backend.main:app --host 127.0.0.1 --port 8000
) else (
    python -m uvicorn backend.main:app --host 127.0.0.1 --port 8000
)

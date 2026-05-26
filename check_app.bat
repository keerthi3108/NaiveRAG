@echo off
powershell -NoProfile -ExecutionPolicy Bypass -Command ^
  "try { $backend = Invoke-WebRequest -Uri 'http://127.0.0.1:8000/api/health' -UseBasicParsing -TimeoutSec 5; Write-Host ('Backend OK: ' + $backend.Content) } catch { Write-Host 'Backend NOT running' }; try { $frontend = Invoke-WebRequest -Uri 'http://127.0.0.1:8000' -UseBasicParsing -TimeoutSec 5; Write-Host ('Frontend OK on backend: HTTP ' + $frontend.StatusCode) } catch { Write-Host 'Frontend NOT reachable from backend' }"

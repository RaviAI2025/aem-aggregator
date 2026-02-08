@echo off
REM Sync all submodules to latest from their respective remotes
REM Usage: scripts\sync-all.bat [module-name]

setlocal enabledelayedexpansion

set "REPO_ROOT=%~dp0.."
cd /d "%REPO_ROOT%"

if not "%~1"=="" (
    call :sync_module %~1
    goto :check_changes
)

call :sync_module aem-marketing
call :sync_module aem-advise
call :sync_module aem-lifeportal

:check_changes
git diff --cached --quiet
if errorlevel 1 (
    echo.
    echo Changes detected. Committing...
    git commit -m "sync: update submodule references"
    echo Done. Run 'git push' to push to remote.
) else (
    echo.
    echo All submodules already up to date.
)
goto :eof

:sync_module
echo --- Syncing %~1 ---
cd /d "%REPO_ROOT%\%~1"
git fetch origin
git checkout master
git pull origin master
cd /d "%REPO_ROOT%"
git add "%~1"
goto :eof

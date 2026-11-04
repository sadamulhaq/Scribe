@echo off
setlocal EnableExtensions EnableDelayedExpansion

cd /d "%~dp0"
set "SCRIBE_PYTHON=%CD%\.venv\Scripts\python.exe"
set "SCRIBE_PREPARED=0"
set "SCRIBE_RESTART=0"

:parse_options
if /I "%~1"=="--prepared" (
    set "SCRIBE_PREPARED=1"
    shift
    goto :parse_options
)
if /I "%~1"=="--restart" (
    set "SCRIBE_RESTART=1"
    shift
    goto :parse_options
)
if not "%~1"=="" (
    echo ERROR: Unknown option: %~1
    exit /b 2
)

if not exist "%SCRIBE_PYTHON%" (
    echo ERROR: Scribe is not installed. Run install-update.bat first.
    pause
    exit /b 1
)

if "%SCRIBE_PREPARED%"=="0" (
    "%SCRIBE_PYTHON%" -m scribe.updater prepare --interactive --force
    set "SCRIBE_CHECK_CODE=!ERRORLEVEL!"
    if "!SCRIBE_CHECK_CODE!"=="0" (
        pause
        exit /b 0
    )
    if not "!SCRIBE_CHECK_CODE!"=="10" (
        echo.
        echo The update could not be prepared.
        pause
        exit /b !SCRIBE_CHECK_CODE!
    )
)

set "SCRIBE_RESTART_SWITCH="
if "%SCRIBE_RESTART%"=="1" set "SCRIBE_RESTART_SWITCH=-Restart"
powershell.exe -NoLogo -NoProfile -ExecutionPolicy Bypass -File ".\update.ps1" %SCRIBE_RESTART_SWITCH%
set "SCRIBE_UPDATE_CODE=%ERRORLEVEL%"

if not "%SCRIBE_UPDATE_CODE%"=="0" (
    echo.
    echo Scribe was not updated. Existing data and settings were not modified.
    pause
    exit /b %SCRIBE_UPDATE_CODE%
)

if "%SCRIBE_RESTART%"=="0" pause
exit /b 0

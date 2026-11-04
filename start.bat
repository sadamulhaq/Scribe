@echo off
setlocal EnableExtensions EnableDelayedExpansion

cd /d "%~dp0"
set "SCRIBE_PYTHON=%CD%\.venv\Scripts\python.exe"

if not exist "%SCRIBE_PYTHON%" (
    echo.
    echo Scribe is not installed yet.
    echo Run install.ps1 first from PowerShell:
    echo   Set-ExecutionPolicy -Scope Process Bypass
    echo   .\install.ps1
    echo.
    pause
    exit /b 1
)

echo.
echo Scribe local server
echo The browser will not open automatically.
echo The exact local address will be shown below when the server is ready.
echo Press Ctrl+C in this window to stop Scribe.
echo.

if /I not "%M2N_SKIP_UPDATE_CHECK%"=="1" (
    "%SCRIBE_PYTHON%" -m scribe.updater check --interactive -- %*
    set "SCRIBE_UPDATE_CHECK_CODE=!ERRORLEVEL!"
    if "!SCRIBE_UPDATE_CHECK_CODE!"=="10" (
        echo Starting the safe updater in a separate window...
        start "Scribe Update" cmd.exe /c ""%CD%\update.bat" --prepared --restart"
        exit /b 0
    )
)

"%SCRIBE_PYTHON%" -m scribe --no-browser %*
set "SCRIBE_EXIT_CODE=%ERRORLEVEL%"

if not "%SCRIBE_EXIT_CODE%"=="0" (
    echo.
    echo Scribe stopped with exit code %SCRIBE_EXIT_CODE%.
)

echo.
echo Scribe has stopped. This window will stay open so you can read the log.
pause

exit /b %SCRIBE_EXIT_CODE%

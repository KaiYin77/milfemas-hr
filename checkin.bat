@echo off
REM FemasHR Check-in Batch Wrapper for Windows
REM This calls the bash script using Git Bash

SET SCRIPT_DIR=%~dp0
SET LOG_FILE=%TEMP%\femas_checkin.log

echo ========================================
echo    Femas Cloud - CHECK-IN Process
echo ========================================
echo Time: %date% %time%
echo Log: %LOG_FILE%
echo ========================================
echo.

echo [%date% %time%] Starting Femas check-in...
echo [%date% %time%] Starting Femas check-in... >> "%LOG_FILE%"

REM Try to find bash in PATH first
where bash >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    bash "%SCRIPT_DIR%femas_checkin.sh"
    goto :check_result
)

REM Check Git Bash in common locations
if exist "C:\Program Files\Git\bin\bash.exe" (
    "C:\Program Files\Git\bin\bash.exe" "%SCRIPT_DIR%femas_checkin.sh"
    goto :check_result
)

if exist "C:\Program Files (x86)\Git\bin\bash.exe" (
    "C:\Program Files (x86)\Git\bin\bash.exe" "%SCRIPT_DIR%femas_checkin.sh"
    goto :check_result
)

REM Check WSL
where wsl >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    wsl bash "%SCRIPT_DIR%femas_checkin.sh"
    goto :check_result
)

REM If we get here, bash wasn't found
echo [ERROR] Bash not found! Please install Git for Windows or WSL.
echo [ERROR] Download Git: https://git-scm.com/download/win
echo [%date% %time%] ERROR: Bash not found >> "%LOG_FILE%"
exit /b 1

:check_result
if %ERRORLEVEL% EQU 0 (
    echo.
    echo [SUCCESS] Check-in completed successfully!
    echo [%date% %time%] Check-in completed successfully >> "%LOG_FILE%"
) else (
    echo.
    echo [ERROR] Check-in failed with error code %ERRORLEVEL%
    echo [%date% %time%] Check-in failed with error code %ERRORLEVEL% >> "%LOG_FILE%"
)

echo.
echo ========================================

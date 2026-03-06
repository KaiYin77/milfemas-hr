@echo off
REM FemasHR Check-out Batch Wrapper for Windows
REM Simplified version that changes to script directory first

SET SCRIPT_DIR=%~dp0
SET LOG_FILE=%TEMP%\femas_checkout.log

echo ========================================
echo    Femas Cloud - CHECK-OUT Process
echo ========================================
echo Time: %date% %time%
echo Log: %LOG_FILE%
echo ========================================
echo.

echo [%date% %time%] Starting Femas check-out...
echo [%date% %time%] Starting Femas check-out... >> "%LOG_FILE%"

REM Change to the script directory first
cd /d "%SCRIPT_DIR%"

echo Running check-out process...
echo.

REM Find bash and run the script with a relative path
SET BASH_FOUND=0

REM Try MSYS2 bash first (user has this)
if exist "C:\msys64\usr\bin\bash.exe" (
    "C:\msys64\usr\bin\bash.exe" -c "SKIP_DELAY=%SKIP_DELAY% ./femas_checkout.sh"
    SET BASH_FOUND=1
    goto :check_result
)

REM Try Git Bash in common locations
if exist "C:\Program Files\Git\bin\bash.exe" (
    "C:\Program Files\Git\bin\bash.exe" -c "SKIP_DELAY=%SKIP_DELAY% ./femas_checkout.sh"
    SET BASH_FOUND=1
    goto :check_result
)

if exist "C:\Program Files (x86)\Git\bin\bash.exe" (
    "C:\Program Files (x86)\Git\bin\bash.exe" -c "SKIP_DELAY=%SKIP_DELAY% ./femas_checkout.sh"
    SET BASH_FOUND=1
    goto :check_result
)

REM Check Local AppData Git installation (user-specific)
if exist "%LOCALAPPDATA%\Programs\Git\bin\bash.exe" (
    "%LOCALAPPDATA%\Programs\Git\bin\bash.exe" -c "SKIP_DELAY=%SKIP_DELAY% ./femas_checkout.sh"
    SET BASH_FOUND=1
    goto :check_result
)

REM Try bash from PATH (might be WSL or Git Bash)
where bash >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    bash -c "SKIP_DELAY=%SKIP_DELAY% ./femas_checkout.sh"
    SET BASH_FOUND=1
    goto :check_result
)

REM If we get here, bash wasn't found
echo [ERROR] Bash not found!
echo.
echo Please install Git for Windows: https://git-scm.com/download/win
echo [%date% %time%] ERROR: Bash not found >> "%LOG_FILE%"
goto :end

:check_result
if %ERRORLEVEL% EQU 0 (
    echo.
    echo [SUCCESS] Check-out completed successfully!
    echo [%date% %time%] Check-out completed successfully >> "%LOG_FILE%"
) else (
    echo.
    echo [ERROR] Check-out failed with error code %ERRORLEVEL%
    echo [%date% %time%] Check-out failed with error code %ERRORLEVEL% >> "%LOG_FILE%"
)

:end
echo.
echo ========================================
echo.
pause
exit /b %ERRORLEVEL%

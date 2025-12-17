@echo off
echo ========================================
echo Testing Bash Installation on Windows
echo ========================================
echo.

REM Test 1: Check if bash is in PATH
echo [Test 1] Checking if bash is in PATH...
where bash >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] bash found in PATH
    for /f "delims=" %%i in ('where bash') do echo      Location: %%i
    echo.
    goto :test_version
) else (
    echo [FAIL] bash not found in PATH
    echo.
)

REM Test 2: Check Git Bash
echo [Test 2] Checking for Git Bash...
if exist "C:\Program Files\Git\bin\bash.exe" (
    echo [OK] Git Bash found at: C:\Program Files\Git\bin\bash.exe
    echo.
    set BASH_PATH="C:\Program Files\Git\bin\bash.exe"
    goto :test_version
)
if exist "C:\Program Files (x86)\Git\bin\bash.exe" (
    echo [OK] Git Bash found at: C:\Program Files (x86)\Git\bin\bash.exe
    echo.
    set BASH_PATH="C:\Program Files (x86)\Git\bin\bash.exe"
    goto :test_version
)
echo [FAIL] Git Bash not found
echo.

REM Test 3: Check WSL
echo [Test 3] Checking for WSL...
where wsl >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo [OK] WSL found
    wsl bash --version
    echo.
    goto :success
) else (
    echo [FAIL] WSL not found
    echo.
)

goto :failure

:test_version
echo [Test 4] Checking bash version...
if defined BASH_PATH (
    %BASH_PATH% --version
) else (
    bash --version
)
echo.
goto :success

:success
echo ========================================
echo SUCCESS! Bash is properly installed.
echo You can now run the .bat scripts.
echo ========================================
pause
exit /b 0

:failure
echo ========================================
echo ERROR: No bash installation found!
echo.
echo Please install one of the following:
echo 1. Git for Windows: https://git-scm.com/download/win
echo 2. WSL: Run 'wsl --install' in PowerShell as Admin
echo ========================================
pause
exit /b 1

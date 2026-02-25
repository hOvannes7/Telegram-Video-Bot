@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ============================================
echo    Telegram Video Bot - Quick Start
echo ============================================
echo.

REM Check if .env exists
if not exist ".env" (
    echo [ERROR] Configuration file .env not found!
    echo.
    echo Please follow these steps:
    echo   1. Run INSTALL.bat first
    echo   2. Edit .env file with your bot settings
    echo.
    pause
    exit /b 1
)

REM Check if venv exists
if not exist "venv" (
    echo [INFO] Virtual environment not found. Creating...
    python -m venv venv
    if errorlevel 1 (
        echo [ERROR] Failed to create virtual environment!
        echo        Make sure Python 3.9+ is installed.
        pause
        exit /b 1
    )
)

echo [1/4] Activating virtual environment...
call venv\Scripts\activate.bat

echo [2/4] Installing/updating dependencies...
pip install -r requirements.txt -q

echo [3/4] Setting up FFmpeg path...
set "FFMPEG_BIN=%~dp0ffmpeg\bin"
if exist "%FFMPEG_BIN%\ffmpeg.exe" (
    set "PATH=%FFMPEG_BIN%;%PATH%"
    echo [OK] FFmpeg found
) else (
    echo [WARNING] FFmpeg not found in local folder
    echo          Please run install_ffmpeg.bat first
    pause
)

echo [4/4] Starting bot...
echo.
echo ============================================
echo    Bot is starting...
echo    Press Ctrl+C to stop
echo ============================================
echo.

python main.py

pause

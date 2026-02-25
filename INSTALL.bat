@echo off
chcp 65001 >nul
cd /d "%~dp0"

echo ============================================
echo    Telegram Video Bot - Installation
echo ============================================
echo.
echo This script will set up everything you need
echo to run the bot. This may take a few minutes.
echo.
pause

echo.
echo ============================================
echo    Step 1: Checking Python installation
echo ============================================
echo.

python --version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] Python is not installed or not in PATH!
    echo.
    echo Please install Python 3.9 or higher from:
    echo https://www.python.org/downloads/
    echo.
    echo Make sure to check "Add Python to PATH" during installation!
    pause
    exit /b 1
)

python --version
echo [OK] Python is installed!
echo.

echo ============================================
echo    Step 2: Creating virtual environment
echo ============================================
echo.

if exist "venv" (
    echo [INFO] Virtual environment already exists, skipping...
) else (
    echo Creating virtual environment...
    python -m venv venv
    if errorlevel 1 (
        echo [ERROR] Failed to create virtual environment!
        pause
        exit /b 1
    )
    echo [OK] Virtual environment created!
)
echo.

echo ============================================
echo    Step 3: Installing Python dependencies
echo ============================================
echo.

call venv\Scripts\activate.bat
pip install --upgrade pip -q
echo Installing dependencies from requirements.txt...
pip install -r requirements.txt
if errorlevel 1 (
    echo [ERROR] Failed to install dependencies!
    pause
    exit /b 1
)
echo [OK] Dependencies installed!
echo.

echo ============================================
echo    Step 4: Installing FFmpeg
echo ============================================
echo.

if exist "ffmpeg\bin\ffmpeg.exe" (
    echo [INFO] FFmpeg is already installed, skipping...
) else (
    echo Installing FFmpeg...
    call install_ffmpeg.bat
    if errorlevel 1 (
        echo [ERROR] Failed to install FFmpeg!
        pause
        exit /b 1
    )
)
echo.

echo ============================================
echo    Step 5: Creating configuration file
echo ============================================
echo.

if exist ".env" (
    echo [INFO] .env file already exists, skipping...
) else (
    echo Creating .env file from template...
    copy .env.example .env >nul
    echo [OK] .env file created!
    echo.
    echo ============================================
    echo    IMPORTANT: Configure your bot!
    echo ============================================
    echo.
    echo The .env file has been created. You need to edit it
    echo with your bot settings before running the bot.
    echo.
    echo Open .env file and fill in:
    echo   - BOT_TOKEN (from @BotFather)
    echo   - STICKER_ID (sticker for waiting message)
    echo   - ADMIN_ID (your Telegram user ID)
    echo   - DEV_LINK (your Telegram username, optional)
    echo.
)

echo.
echo ============================================
echo    Installation Complete!
echo ============================================
echo.
echo Next steps:
echo   1. Edit .env file with your bot settings
echo   2. Run run_bot.bat to start the bot
echo.
echo ============================================
echo.
pause

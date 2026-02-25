@echo off
chcp 65001 >nul

echo ============================================
echo    Setting up FFmpeg Path
echo ============================================
echo.

set "FFMPEG_BIN=%~dp0ffmpeg\bin"

echo Adding FFmpeg to PATH for this session...
set "PATH=%FFMPEG_BIN%;%PATH%"

echo Testing FFmpeg...
"%FFMPEG_BIN%\ffmpeg.exe" -version >nul 2>&1
if errorlevel 1 (
    echo [ERROR] FFmpeg not found!
    echo        Please run install_ffmpeg.bat first
    pause
    exit /b 1
)

echo [OK] FFmpeg is working!
echo.
echo FFmpeg path configured successfully!
echo.

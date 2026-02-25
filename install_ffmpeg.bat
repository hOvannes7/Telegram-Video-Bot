@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

echo ============================================
echo    FFmpeg Installer for Telegram Video Bot
echo ============================================
echo.

set "FFMPEG_VERSION=2024-12-09"
set "FFMPEG_URL=https://www.gyan.dev/ffmpeg/builds/ffmpeg-release-essentials.zip"
set "INSTALL_DIR=%~dp0ffmpeg"

echo [1/5] Checking if FFmpeg is already installed...
if exist "%INSTALL_DIR%\bin\ffmpeg.exe" (
    echo [OK] FFmpeg is already installed!
    "%INSTALL_DIR%\bin\ffmpeg.exe" -version
    echo.
    echo FFmpeg is ready to use!
    pause
    exit /b 0
)

echo [1/5] Downloading FFmpeg...
echo       This may take a few minutes depending on your connection.
echo.

set "ZIP_FILE=%TEMP%\ffmpeg.zip"

powershell -Command "& { ^
    $ProgressPreference = 'SilentlyContinue'; ^
    Write-Host '[2/5] Downloading FFmpeg from gyan.dev...'; ^
    Invoke-WebRequest -Uri '%FFMPEG_URL%' -OutFile '%ZIP_FILE%'; ^
    Write-Host '[3/5] Download complete!'; ^
}"

if errorlevel 1 (
    echo [ERROR] Failed to download FFmpeg!
    echo        Please download manually from: https://www.gyan.dev/ffmpeg/builds/
    pause
    exit /b 1
)

echo [4/5] Extracting FFmpeg...

if exist "%INSTALL_DIR%" (
    rmdir /s /q "%INSTALL_DIR%"
)

powershell -Command "& { ^
    Expand-Archive -Path '%ZIP_FILE%' -DestinationPath '%INSTALL_DIR%' -Force; ^
}"

if errorlevel 1 (
    echo [ERROR] Failed to extract FFmpeg!
    pause
    exit /b 1
)

echo [5/5] Setting up FFmpeg directory...

for /d %%i in ("%INSTALL_DIR%\ffmpeg-release-essentials-*") do (
    if exist "%%i\bin" (
        move "%%i\bin" "%INSTALL_DIR%\bin_temp" >nul
        rmdir /s /q "%%i"
        move "%INSTALL_DIR%\bin_temp" "%INSTALL_DIR%\bin" >nul
    )
)

del /q "%ZIP_FILE%" 2>nul

echo.
echo ============================================
echo    FFmpeg installed successfully!
echo ============================================
echo    Location: %INSTALL_DIR%
echo.

"%INSTALL_DIR%\bin\ffmpeg.exe" -version

echo.
echo Installation complete!
pause

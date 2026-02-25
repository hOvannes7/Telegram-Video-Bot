<h1 align="center">📱 Telegram Video Bot</h1>

<p align="center">
  <b>Convert regular videos into round video messages (circle videos) for Telegram</b>
</p>

<p align="center">
  <a href="README_RU.md">🇷🇺 Читать на русском языке</a>
</p>

---

<h3 align="center">

[![Python 3.9+](https://img.shields.io/badge/Python-3.9+-blue.svg)](https://www.python.org)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

</h3>

---

## 🚀 Quick Start (Windows)

### For New Users

**Everything included! Just follow these steps:**

1. **Download the repository** (ZIP archive or via Git)

2. **Run the installer:**
   ```
   Double-click INSTALL.bat
   ```
   This will automatically install:
   - Python virtual environment
   - All required libraries
   - FFmpeg (for video processing)
   - Configuration file template

3. **Configure the bot:**
   - Open `.env` file in any text editor
   - Fill in your settings (see [Configuration](#-configuration) below)

4. **Start the bot:**
   ```
   Double-click run_bot.bat
   ```

That's it! 🎉

---

## 📝 Configuration

Before running the bot, edit the `.env` file:

| Variable | Description | How to get |
|----------|-------------|------------|
| `BOT_TOKEN` | Your Telegram bot token | [@BotFather](https://t.me/BotFather) → `/newbot` command |
| `STICKER_ID` | Sticker ID for "processing" screen | [@GetIDbot](https://t.me/GetIDbot) → send a sticker |
| `ADMIN_ID` | Your Telegram user ID | [@userinfobot](https://t.me/userinfobot) → `/start` command |
| `DEV_LINK` | Developer link (optional) | Your Telegram profile link |

### Example `.env` file:
```env
BOT_TOKEN=1234567890:ABCdefGHIjklMNOpqrsTUVwxyz
STICKER_ID=CAACAgUAAxkBAAEQlwtocj_Q_CiaECLztzRraBu0CmwPRQACxQQAAmtnGFRD00nwm6LHDjYE
ADMIN_ID=5616264938
DEV_LINK=https://t.me/your_username
```

---

## 🛠️ Manual Installation (Advanced)

### Prerequisites
- **Python 3.9+** — [Download](https://www.python.org/downloads/)
- **FFmpeg** — Auto-downloaded by `install_ffmpeg.bat` or install manually:
  ```bash
  # Windows (Chocolatey)
  choco install ffmpeg

  # Ubuntu/Debian
  sudo apt-get install ffmpeg

  # macOS
  brew install ffmpeg
  ```

### Steps
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/Telegram-Video-Bot.git
   cd Telegram-Video-Bot
   ```

2. Create virtual environment and install dependencies:
   ```bash
   python -m venv venv
   venv\Scripts\activate  # Windows
   pip install -r requirements.txt
   ```

3. Configure `.env` file (see [Configuration](#-configuration))

4. Run the bot:
   ```bash
   python main.py
   ```

---

## 📱 How to Use the Bot

1. **Start the bot** with `/start` command
2. **Send any video** as a file
3. **Wait for processing** (you'll see a sticker)
4. **Receive the round video**
5. **Forward to any chat**

---

## 📋 Video Requirements

| Parameter | Value |
|-----------|-------|
| **Format** | MP4 (recommended) |
| **Duration** | Up to 60 seconds |
| **Size** | Maximum 20 MB |
| **Quality** | 480p recommended |
| **Aspect Ratio** | Square videos work best |

---

## 🎯 Features

- 🎥 Convert any video to round video message
- ⚡ Fast processing with optimized settings
- 📐 Automatic resizing and cropping to 240x240
- 🔄 Simple and intuitive interface
- 📊 Admin statistics dashboard
- 🔍 Error tracking system
- 📦 Portable — everything works out of the box!
- 🛡️ Automatic retry on network errors

---

## 📁 Project Structure

```
Telegram-Video-Bot/
├── INSTALL.bat           # One-click installer
├── run_bot.bat           # Quick start script
├── install_ffmpeg.bat    # FFmpeg downloader
├── main.py               # Bot entry point
├── requirements.txt      # Python dependencies
├── .env.example          # Configuration template
├── .env                  # Your config (create from .env.example)
├── bot/                  # Bot modules
│   ├── handlers.py       # Message handlers (video processing)
│   ├── router.py         # Router setup
│   ├── database.py       # Database functions
│   ├── adm/              # Admin panel
│   └── design/           # UI elements (commands, keyboards)
├── data/                 # Data files
│   ├── cfg.py            # Configuration loader
│   └── database.db       # SQLite database (auto-created)
├── cache/                # Temporary files (auto-created)
└── ffmpeg/               # FFmpeg binaries (auto-downloaded)
```

---

## 🔧 Tech Stack

- **Python 3.9+**
- **aiogram 3.17+** — Telegram Bot API framework
- **moviepy 1.0+** — Video processing
- **FFmpeg** — Video encoding (libx264, AAC)
- **SQLite** — Local database

---

## ❓ Troubleshooting

### Bot doesn't start
- Make sure you filled in `.env` file correctly
- Check if all required variables are set
- Verify your bot token is valid

### FFmpeg not found
- Run `install_ffmpeg.bat` manually
- Check if `ffmpeg` folder exists in project directory

### Video not converting
- Check video size (max 20MB)
- Ensure video duration is under 60 seconds
- Try with different video formats

### Output video is too large (>12MB)
- The bot automatically falls back to sending as regular video
- Try with shorter or lower quality input video

---

## 🤝 Contributing

Contributions are welcome! Feel free to:
- Report bugs
- Suggest new features
- Submit pull requests
- Improve documentation

---

## 📝 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.

---

## 🌟 Support

If you find this project useful:

- Give it a star ⭐
- Share with others 🔄
- Consider contributing 🛠️

---

<div align="center">
    <h4>Built with ❤️ for Telegram</h4>
</div>

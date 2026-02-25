""" SETTINGS """
import os
from pathlib import Path

from dotenv import load_dotenv

# Load environment variables from .env file
env_path = Path(__file__).parent.parent / '.env'
load_dotenv(env_path)

# BOT SETTINGS
TOKEN = os.getenv('BOT_TOKEN', '')
STICKER = os.getenv('STICKER_ID', '')

# LINKS
DEV = os.getenv('DEV_LINK', '')

# OTHER
try:
    ADMIN_ID = int(os.getenv('ADMIN_ID', '0'))
except (ValueError, TypeError):
    ADMIN_ID = 0

DATABASE = 'data/database.db'

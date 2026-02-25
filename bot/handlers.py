# -*- coding: utf-8 -*-
# bot/handlers.py

# MONKEY-PATCH for Pillow ≥10
from PIL import Image
if not hasattr(Image, "ANTIALIAS"):
    Image.ANTIALIAS = Image.Resampling.LANCZOS

import logging
import sys
import asyncio
from datetime import datetime
from pathlib import Path

import moviepy.config as mp_config
from aiogram.exceptions import TelegramEntityTooLarge, TelegramNetworkError
from aiogram.types import Message, FSInputFile
from moviepy.editor import VideoFileClip

from bot.database import error, usage
from data.cfg import STICKER


# Suppress MoviePy logs
mp_config.LOGGER = logging.getLogger('moviepy')
mp_config.LOGGER.setLevel(logging.ERROR)
logging.getLogger().setLevel(logging.INFO)


class NullWriter:
    def write(self, text): pass
    def flush(self): pass


def cleanup_temp_files(user_id: int, *paths: Path) -> None:
    temp_dir = Path("cache")
    if not temp_dir.exists():
        return

    for path in paths:
        try:
            if path.exists():
                path.unlink()
        except OSError:
            pass

    for file in temp_dir.glob(f"*[{user_id}]*"):
        try:
            file.unlink()
        except OSError:
            pass


async def video(message: Message):
    """
    Convert incoming video to a circular video note (<=12MB)
    or fallback to standard video.
    """

    user_id = message.from_user.id
    username = message.from_user.username or "None"
    timestamp = datetime.now().strftime("%Y%m%d-%H%M%S")

    cache = Path("cache")
    cache.mkdir(exist_ok=True)

    input_path = cache / f"in_{user_id}_{timestamp}.mp4"
    output_path = cache / f"out_{user_id}_{timestamp}.mp4"

    try:
        await message.delete()

        file = await message.bot.get_file(message.video.file_id)
        processing = await message.answer_sticker(sticker=STICKER)

        await message.bot.download_file(file.file_path, input_path)

        size_mb = input_path.stat().st_size / (1024 * 1024)
        dur = message.video.duration or 0

        logging.info(f"[DEBUG] Input: size={size_mb:.2f}MB, duration={dur:.1f}s")

        if size_mb > 20:
            await message.answer("📦 Видео больше 20 МБ не поддерживается.")
            return

        # suppress moviepy stdout
        orig_stdout = sys.stdout
        sys.stdout = NullWriter()

        with VideoFileClip(str(input_path)) as clip:

            if dur > 60:
                clip = clip.subclip(0, 60)

            circle_px = 240

            w, h = clip.size
            ratio = w / h

            if w >= h:
                nw, nh = int(circle_px * ratio), circle_px
            else:
                nw, nh = circle_px, int(circle_px / ratio)

            vid = clip.resize((nw, nh)).crop(
                x_center=nw / 2,
                y_center=nh / 2,
                width=circle_px,
                height=circle_px
            )

            vid.write_videofile(
                str(output_path),
                codec="libx264",
                audio_codec="aac",
                bitrate="800k",
                verbose=False,
                logger=None
            )

            out_dur = vid.duration or clip.duration

        sys.stdout = orig_stdout

        out_size = output_path.stat().st_size
        limit = 12 * 1024 * 1024

        # ====== SEND WITH RETRY ======

        if out_size <= limit:

            for attempt in range(3):
                try:
                    await message.bot.send_video_note(
                        chat_id=message.chat.id,
                        video_note=FSInputFile(output_path),
                        duration=int(out_dur),
                        length=circle_px,
                        request_timeout=180
                    )
                    break
                except TelegramNetworkError:
                    logging.warning(f"Retry {attempt+1}/3 send_video_note")
                    await asyncio.sleep(2)

        else:
            await message.answer(
                "⚠️ Результат >12МБ, отправляю как обычное видео."
            )

            for attempt in range(3):
                try:
                    await message.bot.send_video(
                        chat_id=message.chat.id,
                        video=FSInputFile(output_path),
                        caption="Круглое видео",
                        request_timeout=180
                    )
                    break
                except TelegramNetworkError:
                    logging.warning(f"Retry {attempt+1}/3 send_video")
                    await asyncio.sleep(2)

        usage(user_id)
        await processing.delete()

    except TelegramEntityTooLarge:
        await message.answer("⚠️ Файл слишком большой. Пожалуйста, до 20МБ.")

    except Exception as exc:
        logging.exception(f"Error processing for {user_id}")
        await message.answer("❌ Ошибка обработки. Свяжитесь с разработчиком.")
        error(user_id, username, str(exc))

    finally:
        cleanup_temp_files(user_id, input_path, output_path)


async def handle_unknown_input(message: Message):
    await message.delete()
    await message.answer(
        "📹 Пожалуйста, отправьте видео или используйте команды:\n"
        "/start - старт\n"
        "/help - помощь"
    )

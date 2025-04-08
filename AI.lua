import requests
from hikkatl.types import Message
from .. import loader, utils

@loader.tds
class GeminiAIMod(loader.Module):
    """ИИ-ассистент через Gemini API"""
    strings = {
        "name": "GeminiAI",
        "no_args": "🚫 Укажите текст запроса после команды",
        "api_error": "⚠️ Ошибка подключения к API"
    }

    async def gemicmd(self, message: Message):
        """Задать вопрос ИИ. Использование: .gemi <вопрос>"""
        args = utils.get_args_raw(message)
        if not args:
            await utils.answer(message, self.strings["no_args"])
            return

        try:
            # Формируем URL с вопросом
            url = f"https://onlpark.pythonanywhere.com/gemini={requests.utils.quote(args)}"
            
            # Отправляем запрос
            response = requests.get(url)
            response.raise_for_status()
            
            # Получаем и отправляем ответ
            answer = response.text
            await utils.answer(message, f"🤖 <b>GeminiAI отвечает:</b>\n\n{answer}")
            
        except Exception as e:
            logging.exception("API error")
            await utils.answer(message, self.strings["api_error"])

    async def client_ready(self, client, db):
        self._client = client

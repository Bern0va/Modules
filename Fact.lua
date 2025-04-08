import random
from hikkatl.types import Message
from .. import loader, utils

@loader.tds
class RandomFactMod(loader.Module):
    """Модуль для отправки случайных интересных фактов"""
    strings = {"name": "RandomFact"}

    def __init__(self):
        self.config = loader.ModuleConfig(
            "FACTS_DB", 
            [
                "Крокодилы не могут высовывать язык.",
                "Сердце кита бьётся всего 9 раз в минуту.",
                "Венера — единственная планета, вращающаяся по часовой стрелке.",
                "Человеческая ДНК совпадает с ДНК банана на 50%.",
                "Осьминог имеет три сердца и девять мозгов."
            ],
            "База данных фактов (можно расширять)"
        )

    async def factcmd(self, message: Message):
        """Отправить случайный факт"""
        fact = random.choice(self.config["FACTS_DB"])
        await utils.answer(message, f"🔍 <b>Интересный факт:</b>\n\n{fact}")

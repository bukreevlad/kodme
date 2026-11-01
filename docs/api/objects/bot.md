# Bot — бот

Бот — пользователь с `is_bot: true`, зарегистрированный разработчиком через
раздел `[bot]` ([bots.md](../websocket/client-to-server/bots.md)).

## Метаданные бота

```json
{
  "id": "UUIDv7",
  "bio": null,
  "bot_created_user_id": "UUIDv7",
  "link": "my_bot",
  "apps": [
    { "id": "UUIDv7", "url": "https://example.com/app", "name": "…", "link": null }
  ]
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | `UUIDv7` | Id бота. |
| `bio` | `string \| null` | Описание. |
| `bot_created_user_id` | `UUIDv7` | Владелец бота. |
| `link` | `string` | Ссылка бота (всегда оканчивается на `_bot`). |
| `apps` | `array` | Мини-приложения бота. |

В `[search]: get bots` дополнительно есть поле `is_online: boolean`.

## Приватные данные владельца

`[bot]: get settings` дополнительно возвращает `bot_commands` (команды), полные
объекты `apps` (`id`, `url`, `name`, `link`, `about`, `created_at`) и секретный
поле `bot_token` (см. [bots.md](../websocket/client-to-server/bots.md)).
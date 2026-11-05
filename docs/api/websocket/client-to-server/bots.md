# bots — боты

События раздела `[bot]`. Бот — это пользователь с `is_bot: true`, управляемый разработчиком через этот раздел. События бота, поступающие пользователям — в [server-to-client](../server-to-client/README.md).

> Само **соединение бота** (серверная логика бота) использует отдельный роут
> `/api/v1/wss/bot` — см. [bots-to-server](../bots-to-server/README.md). Токен
> `bot_token` из `[bot]: get settings` ниже — это и есть параметр `token` для
> этого соединения.

## `[bot]: create` — создать бота

```json
{ "link": "my_bot", "bio": "Описание", "is_public": true }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `link` | `string` | — | Публичная ссылка бота, `^[a-z0-9_]{3,28}_bot$` (обязательно заканчивается на `_bot`). |
| `bio` | `string \| null` | `null` | Описание, до 255 символов. |
| `is_public` | `boolean` | `true` | Публичность. |

Ответ: `{ "bot_id": "UUIDv7" }`. Ошибка: `PUBLIC_NAME_TAKEN`.

## `[bot]: get info` — информация о боте

```json
{ "bot_id": "UUIDv7" }
```

Можно также передать `link` (вместо `bot_id`). Ответ:

```json
{
  "id": "UUIDv7",
  "bio": null,
  "bot_created_user_id": "UUIDv7",
  "link": "my_bot",
  "apps": [ { "id": "UUIDv7", "url": "https://...", "name": "...", "link": null } ]
}
```

Ошибка: `BOT_DATA_NOT_FOUND`.

## `[bot]: get settings` — настройки бота

```json
{ "bot_id": "UUIDv7" }
```

Можно также передать `link`. *Только владелец бота.*

Ответ — данные `[bot]: get info` + `bot_commands` (массив команд) + `apps`
(полные объекты приложений: `id`, `url`, `name`, `link`, `about`, `created_at`).
Также в ответе присутствует поле `bot_token` — секретный токен бота (используется при
подключении WebSocket-соединения самого бота). Храните его в безопасности и не логируйте.

## `[bot]: save settings` — изменить настройки

```json
{ "bot_id": "UUIDv7", "bio": "Новое описание", "commands": [ { "command": "/start", "description": "..." } ] }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `bio` | `string \| null` | Описание, до 255 символов. |
| `commands` | `array` | Команды бота. |

*Только владелец.* Ответ — пустой.

## `[bot]: save link` — сменить ссылку бота

```json
{ "bot_id": "UUIDv7", "link": "my_bot_v2" }
```

`link` — `^[a-z0-9_]{3,28}_bot$`; передайте `null`, чтобы удалить. *Только владелец.*
Ответ — пустой. Ошибки: `LINK_ALREADY_TAKEN`, `INVALID_LINK`.
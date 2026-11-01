# bots-apps — мини-приложения ботов

События раздела `[bots-apps]`. Приложение бота — веб-страница, запускаемая внутри
платформы (по аналогии с Web Apps). Все действия — только для владельца бота.

## `[bots-apps]: create` — создать приложение

```json
{ "bot_id": "UUIDv7", "name": "Моё приложение", "link": "my-app", "about": null, "url": "https://example.com/app" }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название, 2–64 символа (кириллица/латиница/общие символы). |
| `link` | `string \| null` | `null` | Короткая ссылка, `^[a-z0-9_]{1,32}$`. |
| `about` | `string \| null` | `null` | Описание, до 255 символов. |
| `url` | `string` | — | URL приложения, только `https`. |

Ответ: `{ "id": "UUIDv7" }`. Ошибки: `NAME_INVALID`, `ABOUT_INVALID`, `LINK_INVALID`, `URL_REQUIRED`, `URL_FORMAT_INVALID`.

## `[bots-apps]: edit` — изменить приложение

```json
{ "bot_app_id": "UUIDv7", "name": "...", "link": "...", "about": "...", "url": "https://..." }
```

*Только владелец бота.* Ответ — пустой.

## `[bots-apps]: remove` — удалить приложение

```json
{ "bot_app_id": "UUIDv7" }
```

*Только владелец бота.* Ответ — пустой.

## `[bots-apps]: generate init data` — данные авторизации для приложения

```json
{ "bot_app_id": "UUIDv7" }
```

Ответ:

```json
{
  "name": "Моё приложение",
  "url": "https://example.com/app",
  "hmac": "auth_date=1726913696&user=%7B...%7D&hash=..."
}
```

`hmac` — строка параметров в стиле Telegram WebApp: `auth_date`, `user`
(`{ id, first_name, last_name, link }`) и `hash` — HMAC-подпись. Приложение
передаёт её в свой backend для верификации запроса.

Ошибки: `BOT_DATA_FAILED`, `USER_DATA_FAILED`.
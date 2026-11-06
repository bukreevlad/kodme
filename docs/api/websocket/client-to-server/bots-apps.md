# bots-apps — мини-приложения ботов

События раздела `[bots-apps]`. Приложение бота — веб-страница, запускаемая внутри
платформы (по аналогии с Web Apps). Управление приложением (`create`/`edit`/`remove`)
— только для владельца бота; `generate init data` и `send data` инициирует
пользователь, открывший приложение (подпись и данные отправителя формируются
для него).

## `[bots-apps]: create` — создать приложение

```json
{ "bot_id": "UUIDv7", "name": "Моё приложение", "link": "my-app", "about": null, "url": "https://example.com/app" }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название, 2–64 символа (кириллица/латиница/общие символы). |
| `link` | `string \| null` | `null` | Короткая ссылка, `^[a-z0-9_]{1,32}$`. |
| `about` | `string \| null` | `null` | Описание, до 255 символов. |
| `url` | `string` | — | URL приложения: только `https`, без фрагмента (`#...`). |

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

Подпись выдаётся при каждом открытии приложения: на backend проверяйте
`hash` (алгоритм — в стиле Telegram Web App) и свежесть `auth_date`
(например, не старше 5–10 минут), чтобы исключить повторное использование.

Ошибки: `BOT_DATA_FAILED`, `USER_DATA_FAILED`.

## `[bots-apps]: send data` — данные приложения для бота

Отправляет данные WebApp-приложения (`web_app_send_data`) боту — в его
WebSocket-соединение.

```json
{ "bot_app_id": "UUIDv7", "data": "..." }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `bot_app_id` | `UUIDv7` | Id приложения бота. |
| `data` | `string` | Данные: непустая строка до 8000 символов. |

Ответ — пустой. Данные доставляются боту событием `[bot-app]: send data`
(см. [bot-app.md](../bots-to-server/bot-app.md)); если бот не подключён —
ошибка `BOT_NOT_IN_NETWORK`.

Ошибки: `BOT_APP_ID_REQUIRED`, `BOT_APP_ID_INVALID`, `BOT_DATA_FAILED`,
`DATA_REQUIRED`, `DATA_TOO_LONG`, `BOT_NOT_IN_NETWORK`.
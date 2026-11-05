# bots-to-server — события WebSocket-соединения бота

Раздел описывает события отдельного WebSocket-соединения **самого бота** — то есть
серверной логики бота, которую разработчик запускает у себя. Это не соединение обычного
пользователя, а выделенный роут `/api/v1/wss/bot`.

Через это соединение бот:

- управляет своими настройками (`[bot]`, `[broadcast]`), аватаром и меню;
- отправляет и редактирует сообщения с кнопками, ставит реакции (`[message]`);
- получает от сервера события о действиях пользователей (нажатия кнопок).

## Подключение и аутентификация

Адрес: `wss://kodme.ru/api/v1/wss/bot?token=<bot_token>&botId=<bot_id>`

| Параметр | Тип | Описание |
| --- | --- | --- |
| `token` | `string` | Секретный токен бота (`bot_token`). Выдаётся владельцу бота в ответе клиентского события `[bot]: get settings` (см. [bots.md](../client-to-server/bots.md)). Храните в безопасности, не логируйте. |
| `botId` | `UUIDv7` | Id бота. |

Если `token` или `botId` не переданы или токен неверный — WebSocket-соединение
не открывается (HTTP 401). Сразу после подключения сервер подписывает соединение
на персональный топик бота `bot::<bot_id>`.

## Кадры

Формат кадров и транспорт идентичны клиентскому соединению — см.
[connection.md](../../connection.md).

- Исходящие события (`C2S`): `{ "type": "event", "event": "[domain]: action", "data": { ... } }`.
- Ответы приходят **только при указании `callbackId`**: `{ "type": "callback", "callbackId": "...", "error": null, "data": { ... } }`.
- Ошибки: `{ "type": "callback", "callbackId": "...", "error": "...", ... }` / `appError`-формат (см. [errors.md](../../errors.md)).
- `[system]: ping` возвращает `pong` также только при указании `callbackId` (см. [system.md](./system.md)).

## Входящие события (сервер → бот)

Сервер доставляет боту события двумя способами:

1. **Публикация в топик `bot::<bot_id>`** — приходит на все активные соединения бота.
   Кадр содержит `type`, `event`, `data`, `timestamp`.
2. **Точечная отправка в соединение** — приходит только на соединение, выбранное
   сервером (у бота может быть одно активное соединение в момент действия).
   Кадр содержит `type`, `event`, `data` (без `timestamp`).

| Событие | Доставка | Описание |
| --- | --- | --- |
| `[message]: new` | топик `bot::<bot_id>` | Новое сообщение в канале с ботом (см. [messages.md](./messages.md)). |
| `[message]: update` | топик `bot::<bot_id>` | Изменение сообщения (см. [messages.md](./messages.md)). |
| `[message]: click button` | в соединение | Нажатие кнопки под сообщением (см. [messages.md](./messages.md)). |

Событие `[message]: new` не приходит автору: сообщение, отправленное ботом,
не дублируется ему самому.

## Исходящие события (бот → сервер)

| Раздел | События | Описание |
| --- | --- | --- |
| [bots](./bots.md) | `[bot]: get upload avatar url`, `[bot]: save avatar`, `[bot]: set avatar`, `[bot]: set menu` | Аватар и меню бота. |
| [broadcasts](./broadcasts.md) | `[broadcast]: create`, `get settings`, `get upload thumb url`, `save settings`, `save thumb`, `set thumb` | Трансляции. |
| [messages](./messages.md) | `[message]: send`, `get data`, `get upload attach url`, `update`, `remove`, `send reaction` | Сообщения, вложения, реакции. |
| [channels-members](./channels-members.md) | `[channel-member]: get info` | Информация об участнике канала. |
| [storage](./storage.md) | — | У ботов нет событий `[storage]`: файлы грузятся через события своих разделов. |
| [users](./users.md) | `[user]: get info` | Профили пользователей. |
| [system](./system.md) | `[system]: ping` | Проверка соединения. |

Все события, кроме `[system]: ping`, требуют `callbackId`; без него сервер
возвращает ошибку «Не передан: callback».
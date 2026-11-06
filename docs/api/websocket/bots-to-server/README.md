# bots-to-server — события WebSocket-соединения бота

Раздел описывает события отдельного WebSocket-соединения **самого бота** — то есть
серверной логики бота, которую разработчик запускает у себя. Это не соединение обычного
пользователя, а выделенный роут `/api/v1/wss/bot`.

Через это соединение бот:

- управляет своими настройками (`[bot]`, `[broadcast]`), аватаром и меню;
- отправляет и редактирует сообщения с кнопками, ставит реакции (`[message]`);
- получает от сервера события о действиях пользователей (нажатия кнопок,
  данные WebApp-приложений).

## Подключение и аутентификация

Адрес: `wss://kodme.ru/api/v1/wss/bot?botId=<bot_id>`

| Параметр | Тип | Описание |
| --- | --- | --- |
| `botId` | `UUIDv7` | Id бота. |
| `Sec-WebSocket-Protocol` | `string` | Заголовок handshake'а с секретным токеном бота (`bot_token`). Выдаётся владельцу бота в ответе клиентского события `[bot]: get settings` (см. [bots.md](../client-to-server/bots.md)). Храните в безопасности, не логируйте. Токен передаётся заголовком, а не query-параметром: query-строки попадают в access-логи, заголовок — нет. |

Токен также принимается в query `?token=` — устарело: используйте заголовок.

Если `botId` не передан или токен неверный — сервер закрывает соединение
(код 1008). Сразу после подключения сервер подписывает соединение
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
| `[message]: remove` | топик `bot::<bot_id>` | Удаление сообщения в канале, включая свои (см. [messages.md](./messages.md)). |
| `[bot-app]: send data` | в соединение | Данные WebApp-приложения бота (см. [bot-app.md](./bot-app.md)). |

Событие `[message]: new` не приходит автору: сообщение, отправленное ботом,
не дублируется ему самому.

## Исходящие события (бот → сервер)

| Раздел | События | Описание |
| --- | --- | --- |
| [bots](./bots.md) | `[bot]: get upload avatar url`, `[bot]: save avatar`, `[bot]: remove avatar`, `[bot]: set avatar`, `[bot]: set menu` | Аватар и меню бота. |
| [broadcasts](./broadcasts.md) | `[broadcast]: create`, `remove`, `get casts`, `get watch token`, `create invite`, `get settings`, `get upload thumb url`, `save settings`, `save thumb`, `set thumb` | Трансляции: создание, управление, токен просмотра, приглашения. |
| [meets](./meets.md) | `[meet]: create`, `remove`, `get meets`, `create invite`, `get settings`, `save settings`, `get upload thumb url`, `save thumb`, `remove thumb` | Конференции: создание, управление, приглашения. |
| [messages](./messages.md) | `[message]: send`, `get data`, `get upload attach url`, `save attach`, `update`, `remove`, `send reaction` | Сообщения, вложения, реакции. |
| [channels](./channels.md) | `[channel]: create`, `remove`, `get settings`, `save settings`, `save link`, `get upload avatar url`, `save avatar`, `remove avatar`, `create invite`, `get invites`, `get channels` | Сообщества: создание, управление, приглашения, список своих. |
| [groups](./groups.md) | `[group]: create`, `remove`, `get settings`, `save settings`, `save link`, аватар ×3, `get moderators`, `add moderator`, `get/save moderator settings` | Группы: создание, управление, модераторы. |
| [groups-topics](./groups-topics.md) | `[group-topic]: create`, `remove`, `get settings`, `save settings`, аватар ×3 | Темы групп: создание, управление. |
| [channels-members](./channels-members.md) | `[channel-member]: get info` | Информация об участнике канала. |
| [storage](./storage.md) | — | У ботов нет событий `[storage]`: файлы грузятся через события своих разделов. |
| [users](./users.md) | `[user]: get info` | Профили пользователей. |
| [system](./system.md) | `[system]: ping` | Проверка соединения. |

Все события, кроме `[system]: ping`, требуют `callbackId`; без него сервер
возвращает ошибку «Не передан: callback».
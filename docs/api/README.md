# API платформы «Код.me»

Документация публичного API сервера платформы **Код.me** (`kodme.ru`) для разработчиков кастомных клиентов (веб, десктоп, мобильные приложения).

API состоит из двух частей:

| Часть | Транспорт | Назначение |
| --- | --- | --- |
| **HTTP API** | `HTTPS` | Регистрация, вход, подтверждение кода, обновление токена, QR-авторизация, восстановление пароля, загрузка файлов. |
| **WebSocket API** | `WSS` | Основной канал обмена данными: все действия пользователя (events) и уведомления от сервера (push). |

## Базовые адреса

- HTTP API: `https://kodme.ru/api/v1`
- WebSocket (клиент): `wss://kodme.ru/api/v1/wss/client`

## Соглашения

- **Идентификаторы** (`id`, `user_id`, `channel_id`, `message_id`, ...) — **UUIDv7** строки.
- **Даты и время** (`created_at`, `timestamp`, ...) — строки **ISO 8601** (например `2026-09-21T12:34:56.789Z`).
- Названия событий и полей — в `snake_case`, переводятся дословно и не изменяются.
- Все значения по умолчанию, nullable/optional поля и ограничения перечислены в описании каждого метода.
- «Текущий авторизованный пользователь» — пользователь, от имени которого открыто WebSocket-соединение (или передан токен в HTTP-запросе).

## Структура документации

- [connection.md](./connection.md) — WebSocket-соединение: URL, кадры, callback, push, комнаты, heartbeat.
- [authentication.md](./authentication.md) — регистрация, вход, QR-авторизация, 2FA (TOTP), ключи доступа (Passkey), токены.
- [errors.md](./errors.md) — формат ошибок и общие коды.
- [websocket/](./websocket/README.md) — WebSocket API:
  - [client-to-server/](./websocket/client-to-server/README.md) — события от клиента (C2S) по доменам;
  - [server-to-client/](./websocket/server-to-client/README.md) — события сервера (S2C).
- [http/](./http/README.md) — HTTP API.
- [objects/](./objects/README.md) — общие объекты (User, Channel, Message, ...).
- [guides/](./guides/README.md) — руководства: пагинация, загрузка файлов, WebRTC-звонки, конференции.

## Основные понятия

- **Event** — именованное действие с данными. Клиент отправляет события вида `[domain]: action`; сервер может отправлять такие же события как уведомления (push).
- **C2S event** — событие от клиента серверу: `{ type: "event", event, data, callbackId? }`.
- **S2C event (push)** — уведомление сервера без запроса клиента: `{ type: "event", event, data, timestamp }`.
- **Callback** — ответ сервера на C2S event, если клиент передал `callbackId`.
- **Комната (room/topic)** — именованный канал подписки для доставки push событий (например `user::<id>`).

## Быстрый старт

1. Получите токены — см. [authentication.md](./authentication.md).
2. Откройте WebSocket-соединение — см. [connection.md](./connection.md).
3. Получите стартовые данные (`[user]: get settings`, `[channel]: get user conversations`).
4. Отправляйте события и обрабатывайте push — см. разделы `client-to-server/` и `server-to-client/`.
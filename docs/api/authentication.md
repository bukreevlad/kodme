# Авторизация и аутентификация

HTTP API — `/api/v1/auth/*`. Все запросы, кроме перечисленных ниже, требуют заголовок
`Authorization: Bearer <access_token>`. Без токена работают:

- `POST /api/v1/auth/reg`
- `POST /api/v1/auth/login`
- `POST /api/v1/auth/login/qrcode/gen-auth-session`
- `POST /api/v1/auth/login/qrcode/scanned`
- `POST /api/v1/auth/login/qrcode/confirm`
- `POST /api/v1/auth/login/qrcode/polling`
- `POST /api/v1/auth/confirm`
- `POST /api/v1/auth/passkey/login/begin`
- `POST /api/v1/auth/passkey/login/finish`
- `POST /api/v1/auth/refresh`
- `POST /api/v1/auth/forgot-password/send`
- `POST /api/v1/auth/forgot-password/confirm`
- `POST /api/v1/auth/forgot-password/set`

Ответы и ошибки HTTP API имеют тот же формат, что и WebSocket callback:

```json
{ "data": { ... }, "status": true, "timestamp": "2026-09-21T12:34:56.789Z" }
```

Ошибки — `{ "status": false, "message": "CODE :: number", "type": "error", "code": "number", "reason": null, "details": null, "timestamp": "..." }` (HTTP 400; при ошибках токена — 401).

## Токены

- Пара токенов **JWT (HS256)**: `access_token` (по умолчанию живёт 15 минут) и `refresh_token` (по умолчанию 90 дней).
- Клиент хранит оба токена; `access_token` используется для авторизации HTTP и WebSocket, `refresh_token` — для получения нового `access_token`.
- Payload обоих токенов: `{ user_id, session_id }`.

## Регистрация

`POST /api/v1/auth/reg`

```json
{
  "email": "user@example.com",
  "first_name": "Иван",
  "last_name": "Петров",
  "password": "secret123",
  "retry_password": "secret123"
}
```

Ответ:

```json
{ "user_id": "0191f0c9-...-UUIDv7" }
```

Ограничения и ошибки:

- `first_name` / `last_name` — `^[а-яеЁА-Яa-zA-Z]{2,64}$`.
- `password` и `retry_password` должны совпадать (`PASSWORDS_NOT_MATCH`).
- Email не должен быть занят (`EMAIL_ALREADY_TAKEN`); заблокированный аккаунт — `USER_BLOCKED`.
- Модуль регистрации может быть отключён на сервере (`MODULE_DISABLED`).

## Вход по почте

`POST /api/v1/auth/login`

```json
{
  "email": "user@example.com",
  "password": "secret123",
  "platform": "web",
  "user_agent": "Mozilla/5.0 ..."
}
```

Ответ:

```json
{ "session_id": "0191f0c9-...-UUIDv7" }
```

Если у пользователя включена двухфакторная авторизация TOTP, код на почту
не отправляется — в ответе дополнительно ставится `"totp_required": true`,
и на шаге 2 ожидается код из приложения-генератора. Иначе сервер отправляет
на почту (и push-уведомлением) **4-значный код** подтверждения.
Ошибки: `USER_NOT_FOUND`, `USER_BLOCKED`, `PASSWORD_MISMATCH`.

## Подтверждение входа

`POST /api/v1/auth/confirm`

```json
{ "code": "1234", "session_id": "0191f0c9-...-UUIDv7" }
```

- Без TOTP — **4-значный код** из письма (срок действия 5 минут,
  до 5 неудачных попыток — `TOO_MANY_ATTEMPTS`).
- При включённом TOTP — код из приложения-генератора (от 4 до 10 цифр,
  проверяется в окне ±1 шаг от текущего времени, повторное использование
  одного кода запрещено); срок действия на TOTP-код не действует.

Ответ:

```json
{
  "pair_token": {
    "accessToken": "...",
    "refreshToken": "...",
    "expiresAt": "2026-09-21T12:34:56.789Z"
  },
  "avatar_host_url": "0191f0c9-...-UUIDv7",
  "display_name": "Иван Петров"
}
```

- `pair_token` — пара JWT-токенов.
- `avatar_host_url` — id документа аватарки (сырой UUID) либо `null`.
- Ошибки: `SESSION_NOT_FOUND`.

## Начальные данные (check)

`POST /api/v1/auth/check` — заголовок `Authorization: Bearer <access_token>`.

Ответ:

```json
{
  "user_data": {
    "email": "...",
    "id": "...",
    "first_name": "...",
    "last_name": "...",
    "display_name": "...",
    "avatar": { "document_id": "...", "token": "..." },
    "bio": null,
    "link": null,
    "favorite_channel_id": "...",
    "roles": {
      "dialogs": true,
      "groups": true,
      "channels": true,
      "callers": true,
      "conferences": true,
      "broadcasts": true,
      "themes": true,
      "cloud": true,
      "stickers": true,
      "bots": true
    },
    "is_administrator": false,
    "main_folders": [],
    "is_pushes": null
  },
  "server_data": {
    "organisation": { "name": "...", "about": "..." },
    "web_push_public_key": "...",
    "web_rtc": {
      "bitrates": { ... },
      "ice_servers": [ { "urls": "...", "username": "...", "credential": "..." } ]
    },
    "modules": { ... }
  }
}
```

- `avatar` — токенизированный объект (null, если аватарки нет).
- `favorite_channel_id` — канал «Избранное» пользователя (type 5).
- `is_pushes` — тип активного push на текущей сессии: `"web"`, `"hms"`, `"fcm"` или `null`.
- `roles` могут переопределяться сервером (по умолчанию все перечисленные — `true`).
- Ошибки: `SESSION_NOT_FOUND`, `SESSION_NOT_CONFIRMED`, `USER_BLOCKED`.

## Обновление access-токена

`POST /api/v1/auth/refresh` — заголовок `Authorization: Bearer <refresh_token>`.

Ответ:

```json
{ "access_token": "..." }
```

Ошибки: `TOKEN_MISSING`, `TOKEN_INVALID` (HTTP 401).

## QR-авторизация

Используется для входа в веб-версию со смартфона.

### Шаг 1. Создание QR-сессии

`POST /api/v1/auth/login/qrcode/gen-auth-session` (используются заголовки `x-real-ip` и `user-agent`; необязательное тело с `platform`).

Ответ:

```json
{
  "qr_id": "...",
  "qr_image": "data:image/png;base64,...",
  "expires_at": 1726913696789
}
```

- `qr_image` — dataURL изображения QR-кода (PNG). Кодирует JSON `{"id":"<qr_id>","action":"auth"}`.
- Сессия живёт **1 минуту**.

### Шаг 2. Сканирование (со смартфона)

Приложение на смартфоне декодирует QR и отправляет:

`POST /api/v1/auth/login/qrcode/scanned`

```json
{ "qr_data": { "id": "<qr_id>", "action": "auth" } }
```

Ответ:

```json
{ "session_id": "...", "ip": "...", "user_agent": "..." }
```

### Шаг 3. Подтверждение (со смартфона)

`POST /api/v1/auth/login/qrcode/confirm` — заголовок `Authorization: Bearer <refresh_token>`.

```json
{ "qr_session_id": "<session_id из шага 2>" }
```

Ответ — пустой (`data: null`). Сервер создаёт пользовательскую сессию и токены для веба.

### Шаг 4. Поллинг статуса (веб)

`POST /api/v1/auth/login/qrcode/polling`

```json
{ "qr_id": "<qr_id>" }
```

Промежуточные ответы:

```json
{ "status": "PENDING" }
{ "status": "SCANNED" }
```

Финальный ответ (однократный, сессия после этого удаляется):

```json
{
  "status": "COMPLETED",
  "user_id": "...",
  "display_name": "...",
  "email": "...",
  "session_id": "...",
  "access_token": "...",
  "refresh_token": "..."
}
```

Ошибки: `SESSION_NOT_FOUND`, `EXPIRED`.

## Двухфакторная авторизация (TOTP)

Дополнительный фактор входа: код из приложения-генератора (Google
Authenticator, Yandex Key и т.п.) вместо кода из письма.

- **Включение** — через WebSocket-раздел `[security]` (см.
  [security.md](./websocket/client-to-server/security.md)): `totp setup`
  возвращает секрет/QR, `totp confirm` активирует его вводом актуального
  кода. До подтверждения TOTP вход не защищает (`setup_pending`).
- **Вход** — без изменений API: `POST /auth/login` отвечает
  `totp_required: true`, `POST /auth/confirm` принимает код приложения.
- **Отключение** — `[security]: totp disable` под действующий код.
- Для обычных пользователей регистрация секрета настраивается администратором
  сервера; включение из настроек доступно не всем (секция может отвечать
  `DISABLED`).

## Вход по ключу доступа (Passkey / WebAuthn)

Автономный вход без пароля и кода из почты: два публичных endpoint'а —
`POST /auth/passkey/login/begin` (challenge) и `POST /auth/passkey/login/finish`
(проверка ответа браузера → сразу пара токенов). Поля и форматы — в
[http/auth.md](./http/auth.md).

- Управление ключами (регистрация, список, переименование, удаление) —
  через WebSocket-раздел `[security]`
  ([security.md](./websocket/client-to-server/security.md)).
- Ключи — **discoverable**: вход возможен без указания email.
- Максимум **10** ключей на пользователя.

## WebSocket

- WebSocket-соединение открывается с `access_token` пользователя.
- При отключении сервер сам обрабатывает выход: закрытие соединения кодом **1008**
  означает принудительное завершение сессии (например, при `[session]: remove`).
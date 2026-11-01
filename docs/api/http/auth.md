# HTTP: авторизация

Все endpoint'ы — `POST`, базовый путь `/api/v1`. Ответы — стандартная обёртка
(см. [README](./README.md)), кроме отмеченных **legacy**-форматом.

## Регистрация

### `POST /auth/reg`

```json
{
  "email": "user@example.com",
  "first_name": "Иван",
  "last_name": "Петров",
  "password": "secret",
  "retry_password": "secret"
}
```

Ответ: `{ "user_id": "UUIDv7" }`.

Ошибки: `EMAIL_ALREADY_TAKEN`, `USER_BLOCKED`, валидация полей
(`INVALID_EMAIL`, `INVALID_FIRST_NAME`, `INVALID_LAST_NAME`, `PASSWORDS_NOT_MATCH`).

## Вход по паролю

### `POST /auth/login` — шаг 1: запрос кода

```json
{
  "email": "user@example.com",
  "password": "secret",
  "platform": "web",
  "user_agent": "Mozilla/5.0 ..."
}
```

- Валидный пароль → сервер создаёт сессию.
- Если у пользователя включена двухфакторная авторизация TOTP — код на почту
  не отправляется, в ответе ставится флаг `totp_required: true`, и на шаге 2
  ожидается код из приложения-генератора (см. [authentication.md](../authentication.md)).
- Ответ: `{ "session_id": "UUIDv7" }` (+ `totp_required: true` при включённом TOTP).
- Ошибки: `USER_NOT_FOUND`, `USER_BLOCKED`, `PASSWORD_MISMATCH`.

### `POST /auth/confirm` — шаг 2: подтверждение кодом

```json
{
  "code": "1234",
  "session_id": "UUIDv7"
}
```

- Без TOTP ожидается **4-значный код** из письма (срок действия — 5 минут).
- При включённом TOTP ожидается код из приложения-генератора (от 4 до 10 цифр;
  проверяется в окне ±1 шаг от текущего времени, повторное использование
  одного кода запрещено). Ограничение по времени на TOTP-код не действует.
- Попытки ввода ограничены (5 неудачных попыток — `TOO_MANY_ATTEMPTS`).

Ответ:

```json
{
  "pair_token": {
    "accessToken": "<JWT>",
    "refreshToken": "<JWT>",
    "expiresAt": "2026-09-21T12:34:56.789Z"
  },
  "avatar_host_url": null,
  "display_name": "Иван Петров"
}
```

- `accessToken` — доступ на 15 минут, `refreshToken` — на 90 дней.
- `avatar_host_url` — id документа аватара или `null`.

## Проверка токена

### `POST /auth/check`

Требует заголовок `Authorization: Bearer <accessToken>` (кроме того, токен можно
передать через `Sec-WebSocket-Protocol`, см. [authentication.md](../authentication.md)).

Ответ: `{ "user_data": { ... }, "server_data": { ... } }`.

- `user_data` — данные текущего пользователя (минимально: `id`, `email`,
  `first_name`, `last_name`, `display_name`, `link`, `bio`, `avatar` — полный
  объект [User](../objects/user.md) с доступными полями записи пользователя).
- `server_data`:

```json
{
  "organisation": {
    "name": "Код.me",
    "about": null
  },
  "web_push_public_key": "<ключ Web Push, может отсутствовать>",
  "web_rtc": {
    "bitrates": { "min": 200000, "max": 1500000 },
    "ice_servers": [ { "urls": ["stun:..."], "username": "...", "credential": "..." } ]
  },
  "locales": ["ru", "en"],
  "modules": { "calls": true, "broadcasts": true, "meets": true },
  "limits": {
    "files": { "max_size_bytes": 524288000, "max_files_per_message": 10, "max_file_name_length": 255, "max_metadata_bytes": 65536 },
    "messages": { "text_max_length": 4096, "max_buttons": 10, "max_buttons_per_row": 5, "max_button_text_length": 64 },
    "stickers": { "max_size_bytes": 524288, "max_dimension": 512, "max_per_pak": 100, "pak_name_max_length": 64, "pak_about_max_length": 255 },
    "media": { "thumbnail_sizes": [400, 800, 1200], "rendition_labels": ["360", "720", "1080"], "max_rendition_file_size_bytes": 104857600, "wave_form_points": 60, "max_duration_seconds": 86400, "max_dimension": 20000, "max_tag_length": 256, "placeholder_max_bytes": 4096 }
  },
  "file_types": {
    "image": { ".jpg": { "mimes": ["image/jpeg"], "default": "image/jpeg" } }
  }
}
```

- `ice_servers` генерируются **индивидуально для пользователя** (логин/пароль)
  — единственное место, откуда клиент получает ICE-серверы.
- `limits` — пределы платформы: размеры и количество файлов, длина текста и
  кнопок, лимиты стикеров, геометрия производных объектов. Это единственное
  место, откуда клиент берёт «сколько можно»: ответы
  `get upload attach url` / `get upload sticker url` этих значений не
  содержат.
- `file_types` — справочник типов файлов (категория → расширение →
  допустимые MIME и MIME по умолчанию).

## Обновление токена

### `POST /auth/refresh`

Заголовок `Authorization: Bearer <refreshToken>`.

Ответ: `{ "access_token": "<новый JWT>" }`.

Ошибки: `REFRESH_TOKEN_REQUIRED` (no token), `TOKEN_MISSING`/`TOKEN_INVALID` (401),
`REFRESH_TOKEN_EXPIRED`.

## Восстановление пароля

Все три endpoint'а **не требуют** заголовка `Authorization`. Успех:
`{ "status": true }`. Ошибки — стандартные ErrCode-ответы
(см. [errors.md](../errors.md)).

### `POST /auth/forgot-password/send`

```json
{ "email": "user@example.com" }
```

Отправляет 4-значный код на почту. Ответ одинаковый для всех случаев
(пользователь не найден / заблокирован / код отправлен) — анти-enumeration:
`{ "status": true }`. Срок действия кода — 10 минут, попыток ввода — максимум 5
(при превышении — `TOO_MANY_ATTEMPTS`).

### `POST /auth/forgot-password/confirm`

```json
{ "email": "user@example.com", "code": "1234" }
```

Проверка кода. Ошибки — ErrCode-ответы: `CODE_INVALID_OR_EXPIRED` (неверный/истёкший код),
`TOO_MANY_ATTEMPTS` (превышен лимит попыток).

### `POST /auth/forgot-password/set-password`

```json
{ "email": "user@example.com", "code": "1234", "password": "newPass123", "retryPassword": "newPass123" }
```

Устанавливает новый пароль (минимум 8 символов), очищает код восстановления
и удаляет все сессии пользователя.

> ✅ Все три шага восстановления пароля **не требуют** заголовка `Authorization`.

## Вход по QR-коду

Поток: браузер создаёт сессию → показывает QR → пользователь сканирует его
смартфоном (приложение) → приложение подтверждает → браузер опрашивает статус
и получает токены.

### `POST /auth/login/qrcode/gen-auth-session` — создать сессию

Необязательное тело:

```json
{ "platform": "web" }
```

- `platform` — платформа браузера (например `web`); запоминается в сессии и
  попадает в список устройств. Отсутствие тела допустимо.

Ответ:

```json
{
  "qr_id": "<hex>",
  "qr_image": "data:image/png;base64,...",
  "expires_at": 1789664400000
}
```

- `expires_at` — момент истечения (UNIX-ms), срок жизни сессии — 1 минута.
- Содержимое QR-кода: `{"id":"<qr_id>","action":"auth"}` — приложение передаёт
  его в `/scanned`.

### `POST /auth/login/qrcode/scanned` — код отсканирован (со смартфона)

```json
{ "qr_data": { "id": "<qr_id>", "action": "auth" } }
```

Ответ:

```json
{
  "status": true,
  "session_id": "<session_id>",
  "ip": "1.2.3.4",
  "user_agent": "Mozilla/5.0 ..."
}
```

- `session_id` передаётся далее в `/confirm`.

### `POST /auth/login/qrcode/confirm` — подтверждение входа (со смартфона)

```json
{
  "qr_session_id": "<session_id>",
  "refresh_token_payload": { "user_id": "UUIDv7", "session_id": "UUIDv7" }
}
```

- `refresh_token_payload` — данные из refresh-токена пользователя приложения
  (объект с `user_id` как минимум).
- Ответ: пустой (`{ "data": null, "status": true, ... }`).
- Ошибка: `SESSION_NOT_FOUND_OR_EXPIRED`.

### `POST /auth/login/qrcode/polling` — опрос статуса (браузер)

```json
{ "qr_id": "<qr_id>" }
```

Ответ — текущий статус:

```json
{ "status": "PENDING" }
{ "status": "SCANNED" }
```

При подтверждении:

```json
{
  "status": "COMPLETED",
  "user_id": "UUIDv7",
  "display_name": "Иван Петров",
  "email": "user@example.com",
  "session_id": "UUIDv7",
  "access_token": "<JWT>",
  "refresh_token": "<JWT>"
}
```

- Статусы: `PENDING` → `SCANNED` → `COMPLETED`.
- `COMPLETED` возвращается один раз (сессия удаляется после выдачи данных).
- Ошибки: `SESSION_NOT_FOUND`, `EXPIRED`.

## Вход по ключу доступа (Passkey / WebAuthn)

Автономный вход без пароля и кода из почты — завершается выдачей пары токенов.
Клиент взаимодействует с платформенной аутентификацией браузера
(WebAuthn): все криптографические поля в форматах спецификации, байтовые
поля — base64url. Оба endpoint'а **не требуют** заголовка `Authorization`.

### `POST /auth/passkey/login/begin` — шаг 1: challenge

```json
{ "email": "user@example.com" }
```

- `email` — необязателен: пре-проверка, что у аккаунта есть зарегистрированные
  ключи (отсутствие ключей и отсутствие аккаунта неразличимы — `NO_CREDENTIALS`).
- Ответ:

```json
{
  "ceremony_id": "UUIDv7",
  "options": {
    "rpId": "kodme.ru",
    "challenge": "<base64url>",
    "timeout": 300000,
    "userVerification": "required",
    "allowCredentials": []
  }
}
```

- `ceremony_id` — одноразовый идентификатор challenge (живёт 5 минут).
- `options` передаются в платформенную аутентификацию браузера как есть
  (пустой `allowCredentials` — вход по discoverable-ключу).
- Ошибки: `DISABLED`, `NO_CREDENTIALS`.

### `POST /auth/passkey/login/finish` — шаг 2: проверка и выдача токенов

```json
{
  "ceremony_id": "UUIDv7",
  "client_data": "<base64url>",
  "authenticator_data": "<base64url>",
  "signature": "<base64url>",
  "credential_id": "<base64url>",
  "platform": "web",
  "user_agent": "Mozilla/5.0 ..."
}
```

- `client_data`, `authenticator_data`, `signature` — поля ответа аутентификатора
  в base64url; `credential_id` — идентификатор credential'а из ответа браузера.
- Ответ — форма шага 2 парольного входа плюс `session_id` и `email`
  (при входе по discoverable-ключу почта могла не вводиться на клиенте):

```json
{
  "pair_token": {
    "accessToken": "<JWT>",
    "refreshToken": "<JWT>",
    "expiresAt": "2026-09-21T12:34:56.789Z"
  },
  "avatar_host_url": null,
  "display_name": "Иван Петров",
  "email": "user@example.com",
  "session_id": "UUIDv7"
}
```

- `ceremony_id` одноразовый: повторное использование отклоняется
  (`CEREMONY_INVALID`), после 5 минут — тоже.
- Ошибки: `CEREMONY_INVALID`, `CREDENTIAL_NOT_FOUND`, `RESPONSE_INVALID`,
  `SIGN_COUNT_REJECTED` (счётчик подписей не растёт — возможная копия
  аутентификатора), `USER_BLOCKED`, `DISABLED`.
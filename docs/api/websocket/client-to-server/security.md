# security — двухфакторная авторизация и ключи доступа

События раздела `[security]`: управление TOTP (двухфакторная авторизация по
коду из приложения-генератора) и ключами доступа (Passkey / WebAuthn).
Общая картина входа — в [authentication.md](../../authentication.md).

> Функции могут быть отключены на сервере — тогда любое событие раздела
> отвечает ошибкой `DISABLED`.

## `[security]: totp status` — статус TOTP

Данные — из контекста соединения (без параметров).

Ответ:

```json
{ "available": true, "enabled": false, "setup_pending": false }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `available` | `boolean` | Функция TOTP разрешена на сервере. |
| `enabled` | `boolean` | TOTP подтверждён и защищает вход. |
| `setup_pending` | `boolean` | Секрет выдан, но ещё не подтверждён (включение не завершено). |

Ошибки: `USER_ID_REQUIRED`, `USER_ID_INVALID`, `DISABLED`.

## `[security]: totp setup` — шаг 1: выпуск секрета

Данные — из контекста соединения (без параметров). Генерирует **новый**
неподтверждённый секрет (незавершённая настройка при этом перезаписывается)
и возвращает данные для добавления в приложение-генератор. Секрет действует
только после подтверждения (см. `totp confirm`).

Ответ:

```json
{
  "secret": "JBSWY3DPEHPK3PXP",
  "otpauth_url": "otpauth://totp/...",
  "qr_image": "data:image/png;base64,...",
  "digits": 6,
  "step": 30
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `secret` | `string` | Секрет в base32 (для ручного ввода). |
| `otpauth_url` | `string` | Стандартная otpauth-URI для передачи в приложение. |
| `qr_image` | `string` | QR-код в dataURL (PNG). |
| `digits` | `number` | Количество цифр кода. |
| `step` | `number` | Шаг кода в секундах. |

Ошибки: `USER_ID_REQUIRED`, `USER_ID_INVALID`, `ALREADY_ENABLED`, `DISABLED`.

## `[security]: totp confirm` — шаг 2: подтверждение включения

```json
{ "code": "123456" }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `code` | `string` | Код из приложения-генератора (ровно `digits` цифр). |

Код проверяется в окне ±1 шаг от текущего времени; повторное использование
того же кода запрещено. Успех активирует TOTP для входа.

Ответ: `{ "enabled": true }`.

Ошибки: `USER_ID_REQUIRED`, `USER_ID_INVALID`, `DISABLED`, `CODE_REQUIRED`,
`CODE_INVALID`, `SETUP_NOT_STARTED` (шаг setup не выполнялся),
`ALREADY_ENABLED`.

## `[security]: totp disable` — отключение TOTP

```json
{ "code": "123456" }
```

Отключает TOTP под действующий код из приложения-генератора.

Ответ: `{ "enabled": false }`.

Ошибки: `USER_ID_REQUIRED`, `USER_ID_INVALID`, `DISABLED`, `CODE_REQUIRED`,
`CODE_INVALID`, `NOT_ENABLED`.

## `[security]: passkey register begin` — шаг 1: challenge регистрации

Данные — из контекста соединения (без параметров).

Ответ:

```json
{
  "ceremony_id": "UUIDv7",
  "options": {
    "rp": { "id": "domain.ru", "name": "..." },
    "user": { "id": "<base64url>", "name": "user@example.com", "displayName": "Иван" },
    "challenge": "<base64url>",
    "pubKeyCredParams": [ { "type": "public-key", "alg": -7 }, { "type": "public-key", "alg": -257 } ],
    "timeout": 300000,
    "excludeCredentials": [ { "type": "public-key", "id": "<base64url>", "transports": ["internal"] } ],
    "authenticatorSelection": { "residentKey": "required", "userVerification": "required" },
    "attestation": "none"
  }
}
```

- `options` передаются в платформенную аутентификацию браузера
  (`navigator.credentials.create`) как есть; `ceremony_id` живёт 5 минут.
- `excludeCredentials` — уже зарегистрированные ключи пользователя
  (защита от дублей).
- Лимит ключей на пользователя — **10**.

Ошибки: `USER_ID_REQUIRED`, `USER_ID_INVALID`, `DISABLED`, `USER_NOT_FOUND`,
`LIMIT_REACHED`.

## `[security]: passkey register finish` — шаг 2: проверка и сохранение

```json
{
  "ceremony_id": "UUIDv7",
  "client_data": "<base64url>",
  "attestation_object": "<base64url>",
  "transports": ["internal"],
  "name": "iPhone"
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `client_data` | `string` | `clientDataJSON` от аутентификатора, base64url. |
| `attestation_object` | `string` | `attestationObject` от аутентификатора, base64url. |
| `transports` | `string[]` | Необязательно: перевозки аутентификатора (до 5). |
| `name` | `string` | Необязательно: имя ключа (до 64 символов, иначе «Passkey»). |

`ceremony_id` одноразовый (забирается при проверке). Ответ — пустой.

Ошибки: `USER_ID_REQUIRED`, `USER_ID_INVALID`, `DISABLED`,
`CEREMONY_ID_REQUIRED`, `CEREMONY_INVALID` (не выдан, истёк или уже
использован), `RESPONSE_INVALID` (проверка ответа аутентификатора не
пройдена), `USER_NOT_FOUND`, `LIMIT_REACHED`, `DUPLICATE`
(credential уже зарегистрирован).

## `[security]: passkey list` — список ключей

Данные — из контекста соединения (без параметров).

Ответ — массив:

```json
[
  {
    "credential_id": "<base64url>",
    "name": "iPhone",
    "transports": ["internal"],
    "created_at": "2026-10-22T12:00:00.000Z",
    "last_used_at": null
  }
]
```

Публичный ключ в ответ не входит. Порядок — по времени регистрации.

Ошибки: `USER_ID_REQUIRED`, `USER_ID_INVALID`, `DISABLED`.

## `[security]: passkey rename` — переименование ключа

```json
{ "credential_id": "<base64url>", "name": "Рабочий ноутбук" }
```

Ответ — пустой. Имя — 1–64 символа.

Ошибки: `USER_ID_REQUIRED`, `USER_ID_INVALID`, `DISABLED`,
`CREDENTIAL_ID_REQUIRED`, `NAME_REQUIRED`, `INVALID_NAME`, `NOT_FOUND`.

## `[security]: passkey remove` — удаление (отзыв) ключа

```json
{ "credential_id": "<base64url>" }
```

Ответ — пустой. Войти этим ключом после удаления нельзя.

Ошибки: `USER_ID_REQUIRED`, `USER_ID_INVALID`, `DISABLED`,
`CREDENTIAL_ID_REQUIRED`, `NOT_FOUND`.

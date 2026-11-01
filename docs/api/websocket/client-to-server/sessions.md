# sessions — сессии и push-подписки

События раздела `[session]`. Объект сессии — [Session](../../objects/session.md).

## `[session]: get sessions` — список активных сессий

```json
{ "link": null, "direction": "next", "cursor_id": null, "offset": 35 }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `link` | `string \| null` | `null` | Ссылка на профиль — получить сессии другого пользователя (не используется в обычном сценарии). |

Ответ — массив [Session](../../objects/session.md) **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).

## `[session]: remove` — завершить текущую сессию

```json
{ "session_id": "UUIDv7" }
```

Ответ — пустой. Соединение закрывается сервером с кодом **1008**.

## `[session]: remove other` — завершить другую сессию

Данные — из контекста соединения (без параметров). Ответ — пустой.

## `[session]: enable web push` — подписка на Web Push

```json
{ "endpoint": "https://...", "key": "...", "auth": "..." }
```

Ответ — пустой.

## `[session]: enable fcm push` — подписка на FCM

```json
{ "token": "..." }
```

Ответ — пустой.

## `[session]: enable hms push` — подписка на HMS

```json
{ "token": "..." }
```

Ответ — пустой.

## `[session]: disable push` — отключить push на устройстве

```json
{}
```

Ответ — пустой.
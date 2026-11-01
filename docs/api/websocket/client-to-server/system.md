# system — служебные события

## `[system]: ping` — поддержание соединения

`pong` приходит **только при указании `callbackId`**:

```json
{ "type": "event", "event": "[system]: ping", "callbackId": "1" }
```

Ответ — кадр callback:

```json
{ "type": "callback", "callbackId": "1", "error": null, "data": { "pong": 1726913696789 } }
```

`pong` — время на сервере в миллисекундах (Unix timestamp). Без `callbackId`
ответ не приходит. Подробнее — в [connection.md](../../connection.md).

# admin — административные события

События раздела `[admin]`. Доступны только пользователям из списка администраторов сервера.

## `[admin]: get access token` — токен администратора

```json
{}
```

Ответ — строка `data` (JWT администратора). Токен используется для подключения к
административным WebSocket-соединениям сервера.
Для не-администраторов — ошибка `ADMIN_NOT_FOUND`.
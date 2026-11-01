# system — служебные события

## `[system]: ping` — поддержание соединения

```json
{ "type": "event", "event": "[system]: ping", "callbackId": "1" }
```

`pong` приходит **только при указании `callbackId`** — кадром callback:

```json
{ "type": "callback", "callbackId": "1", "error": null, "data": { "pong": 1726913696789 } }
```

`pong` — время на сервере в миллисекундах (Unix timestamp). Без `callbackId`
ответ не приходит. Подробнее — в [connection.md](../../connection.md).
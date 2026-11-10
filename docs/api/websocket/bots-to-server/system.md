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

## `[system]: limits` — лимиты платформы

```json
{ "type": "event", "event": "[system]: limits", "callbackId": "1" }
```

Ответ — кадром callback, `data` без конверта (как у ping):

```json
{
  "limits": {
    "files": { "max_size_bytes": 524288000, "max_files_per_message": 10, "max_file_name_length": 255, "max_metadata_bytes": 65536 },
    "messages": { "text_max_length": 4096, "max_buttons": 10, "max_buttons_per_row": 5, "max_button_text_length": 64, "button_payload_length": 1024 },
    "stickers": { "max_size_bytes": 524288, "max_dimension": 512, "max_per_pak": 100, "pak_name_max_length": 64, "pak_about_max_length": 255 }
  },
  "rate_limits": { "enabled": true, "default": [120, "60s"], "ignore": ["[system]: ping"], "modules": { "message": [60, "60s"] }, "events": { "[message]: send": [20, "60s"] } }
}
```

- `limits` — секция `limits` настроек **конкретного стенда** (те же числа,
  что получает клиент при авторизации): файлы, текст и кнопки сообщений,
  стикеры. Числа могут отличаться между стендами — в коде бота их не
  хардкодить, а запрашивать здесь;
- `rate_limits` — правила WS-частоты **этого бота**: `default` общий
  счётчик, `modules` — по префиксу события, `events` — точечно (высший
  приоритет), `ignore` — неучитываемые события; правило —
  `[количество, окно]`. При превышении событие отклоняется ошибкой
  `RATE_LIMIT_EXCEEDED` (429), бот может учитывать правила сам и
  дозировать отправку.

Бот запрашивает лимиты один раз сразу после подключения (см. `kodme_bot`,
`core/app.ts`); при недоступности ответа работает дальше — проверки ведёт
сервер.
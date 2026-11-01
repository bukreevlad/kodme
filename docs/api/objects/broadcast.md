# Broadcast — трансляция

Трансляция связана с чатом (канал типа 7). Управление — [broadcasts.md](../websocket/client-to-server/broadcasts.md).

## `get_base`

```json
{
  "id": "UUIDv7",
  "name": "Моя трансляция",
  "about": null,
  "is_public": true,
  "is_chat": true,
  "chat_channel_id": "UUIDv7",
  "created_at": "2026-09-21T12:34:56.789Z",
  "created_user_id": "UUIDv7",
  "thumbnail_document_id": null,
  "is_bot": false,
  "bot_created_user_id": null,
  "thumbnail": null
}
```

## `get_meta` = `get_base` + статус эфира

```json
{
  "…": "поля get_base",
  "created_display_name": "Иван Петров",
  "is_live": false,
  "started_at": null
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `is_live` | `boolean` | Идёт ли эфир. |
| `started_at` | `ISO 8601 \| null` | Время начала эфира (только при `is_live: true`). |
| `created_display_name` | `string` | Имя автора (у бота — его `link`). |
| `thumbnail` | [File](./file.md) \| `null` | Обложка. |

## Связанное

- Статус эфира в реальном времени — push `[broadcast]: update`
  ([server-to-client](../websocket/server-to-client/broadcasts.md)).
- Технические параметры потока — `[broadcast]: get stream info`.
- Чат трансляции наследует её доступ: приватную трансляцию и её чат видят её
  владелец и подписанные участники. Приватность (`is_public`) чата повторяет
  приватность трансляции, а `is_chat: false` отключает отправку сообщений в чате.
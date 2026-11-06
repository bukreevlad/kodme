# Meet — конференция

Конференция (видео-встреча) работает через LiveKit; есть чат (канал типа 6).
Управление — [meets.md](../websocket/client-to-server/meets.md).

```json
{
  "id": "UUIDv7",
  "name": "Еженедельная встреча",
  "about": null,
  "is_public": true,
  "is_chat": true,
  "chat_channel_id": "UUIDv7",
  "created_at": "2026-09-21T12:34:56.789Z",
  "created_user_id": "UUIDv7",
  "thumbnail_document_id": null,
  "thumbnail": null,
  "created_display_name": "Иван Петров"
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | `UUIDv7` | Id конференции. |
| `name` | `string` | Название. |
| `about` | `string \| null` | Описание. |
| `is_public` | `boolean` | Публичность. |
| `is_chat` | `boolean` | Есть ли чат. |
| `chat_channel_id` | `UUIDv7 \| null` | Канал чата (тип 6). |
| `created_at` | `ISO 8601` | Дата создания. |
| `created_user_id` | `UUIDv7` | Владелец. |
| `thumbnail_document_id` | `UUIDv7 \| null` | Id документа обложки. |
| `thumbnail` | [File](./file.md) \| `null` | Обложка. |
| `created_display_name` | `string` | Имя создателя (у бота — его `link`). |

## Связанное

- Вход в конференцию (`[meet]: open`) возвращает объект meet + `token` — JWT для
  подключения к LiveKit (комната `meet::<meet_id>`).
- Присутствие участников в реальном времени — push `[meet]: user enter` / `[meet]: user exit`
  ([server-to-client](../websocket/server-to-client/meets.md)).
- Чат конференции наследует её доступ: приватную конференцию и её чат видят её
  владелец и подписанные участники. Приватность (`is_public`) чата повторяет
  приватность конференции, а `is_chat: false` отключает отправку сообщений в чате.
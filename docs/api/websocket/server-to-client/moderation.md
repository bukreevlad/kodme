# server-to-client: модерация

События раздела `[moderation]` — результат действий модерации в канале
(удаление всех сообщений участника, блокировка, разблокировка).

## `[moderation]: cleaned` — удалены сообщения участника

```json
{
  "type": "event",
  "event": "[moderation]: cleaned",
  "data": { "channel_id": "UUIDv7", "user_id": "UUIDv7", "pts": 123 },
  "timestamp": "2026-11-09T12:34:56.789Z"
}
```

Доставляется всем участникам в `channel::<channel_id>`: сообщения
пользователя `user_id` удалены из канала, `pts` — новый счётчик
состояния канала.

## `[moderation]: member banned` — участник заблокирован

```json
{
  "type": "event",
  "event": "[moderation]: member banned",
  "data": { "channel_id": "UUIDv7", "user_id": "UUIDv7" },
  "timestamp": "2026-11-09T12:34:56.789Z"
}
```

Доставляется всем участникам в `channel::<channel_id>`: участник
`user_id` кикнут и заблокирован.

## `[moderation]: member unbanned` — участник разблокирован

```json
{
  "type": "event",
  "event": "[moderation]: member unbanned",
  "data": { "channel_id": "UUIDv7", "user_id": "UUIDv7" },
  "timestamp": "2026-11-09T12:34:56.789Z"
}
```

Доставляется всем участникам в `channel::<channel_id>`: блокировка
участника `user_id` снята (подписка не восстанавливается автоматически).

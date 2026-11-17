# channels-members — участники каналов

События раздела `[channel-member]` для соединения бота.

## `[channel-member]: get info` — информация об участнике канала

```json
{ "channel_id": "UUIDv7", "user_id": "UUIDv7" }
```

Ответ — мета-информация участника канала:

```json
{
  "is_subscribed": true,
  "is_banned": false,
  "banned_at": null,
  "subscribed_at": "2026-09-21T12:34:56.789Z",
  "is_creator": false
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `is_subscribed` | `boolean` | Подписан ли участник на канал. |
| `is_banned` | `boolean` | Заблокирован ли участник модерацией. |
| `banned_at` | `ISO 8601 \| null` | Когда участник заблокирован. |
| `subscribed_at` | `ISO 8601 \| null` | Время подписки на канал. |
| `is_creator` | `boolean` | Создатель канала. |

Если пользователь не состоит в канале — ответ `null`.

Ошибки: `ACCESS_DENIED` (бот не подписан на канал — мета участников доступна
только подписчикам).

## `[channel-member]: get members` — список участников канала

```json
{ "channel_id": "UUIDv7", "direction": "next", "cursor_id": null, "offset": 35 }
```

Контракт совпадает с клиентским событием (см.
[channels-members.md](../client-to-server/channels-members.md)): ответ —
массив участников (`id`, `user_id`, `display_name`, `link`, `avatar`,
`is_subscribed`, `is_banned`, `banned_at`, `subscribed_at`) **и** поле `has_more`. Доступ: в сообществе
(`kind: "channel"`) — только владелец и модераторы, в группе, теме и чатах —
подписанный участник.
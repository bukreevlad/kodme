# channels-members — участники каналов

События раздела `[channel-member]` для соединения бота.

## `[channel-member]: get info` — информация об участнике канала

```json
{ "channel_id": "UUIDv7", "user_id": "UUIDv7" }
```

Ответ — мета-информация участника канала:

```json
{
  "subscribed_at": "2026-09-21T12:34:56.789Z",
  "is_blocked": false,
  "is_moderator": false,
  "can_deleted_message": false,
  "can_clean_messages": false,
  "can_restrict_members": false,
  "can_invite_users": false,
  "can_pin_messages": false,
  "is_creator": false
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `subscribed_at` | `ISO 8601 \| null` | Время подписки на канал. |
| `is_blocked` | `boolean` | Пользователь заблокирован в канале. |
| `is_moderator` | `boolean` | Модератор канала. |
| `can_deleted_message` | `boolean` | Может удалять сообщения. |
| `can_clean_messages` | `boolean` | Может очищать историю. |
| `can_restrict_members` | `boolean` | Может ограничивать участников. |
| `can_invite_users` | `boolean` | Может приглашать участников. |
| `can_pin_messages` | `boolean` | Может закреплять сообщения. |
| `is_creator` | `boolean` | Создатель канала. |

Если пользователь не состоит в канале — ответ `null`.
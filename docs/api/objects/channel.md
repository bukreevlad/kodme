# Channel — канал

Канал — любое пространство для сообщений: диалог, группа, канал, тема, избранное,
чат конференции или трансляции.

## Типы каналов

```json
{ "type": 1 }
```

| `type` | Название |
| --- | --- |
| `1` | Диалог (личный чат). |
| `2` | Группа. |
| `3` | Канал (публичный канал-рассылка). |
| `4` | Тема группы. |
| `5` | Избранное (saved messages). |
| `6` | Чат конференции. |
| `7` | Чат трансляции. |
| `8` | Диалог с ботом. |

## `get_data` (для текущего пользователя)

```json
{
  "id": "UUIDv7",
  "created_user_id": "UUIDv7",
  "type": 3,
  "about": null,
  "created_at": "2026-09-21T12:34:56.789Z",
  "group_for_channel_id": null,
  "topic_for_group_id": null,
  "is_public": true,
  "is_posting": false,
  "is_commenting": false,
  "last_pts": 0,
  "link": null,
  "total_members": 42,
  "first_message_id": null,
  "last_message_id": null,
  "total_unread_messages": 0,
  "last_viewed_message_id": null,
  "is_notifications": true,
  "is_subscribed": true,
  "is_moderator": false,
  "can_deleted_message": false,
  "can_clean_messages": false,
  "can_restrict_members": false,
  "can_invite_users": false,
  "can_pin_messages": false,
  "display_user_id": null,
  "display_last_action_at": null,
  "display_privacy_messages": null,
  "display_last_viewed_message_id": null,
  "main_folders_ids": [],
  "display_name": "Мой канал",
  "avatar": null,
  "display_user_is_online": null,
  "last_message": null,
  "topics": [],
  "bots": []
}
```

### Поля

| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | `UUIDv7` | Id канала. |
| `created_user_id` | `UUIDv7` | Создатель (владелец). |
| `type` | `int` | Тип канала (см. выше). |
| `about` | `string \| null` | Описание. |
| `created_at` | `ISO 8601` | Дата создания. |
| `group_for_channel_id` | `UUIDv7 \| null` | Группа канала (для типа 3). |
| `topic_for_group_id` | `UUIDv7 \| null` | Группа темы (для типа 4). |
| `is_public` | `boolean` | Публичность. |
| `is_posting` | `boolean` | Разрешена ли запись сообщений участниками. |
| `is_commenting` | `boolean` | Разрешены ли комментарии. |
| `last_pts` | `int` | Последняя точка сообщений (инкремент канала). |
| `link` | `string \| null` | Публичная ссылка/приглашение. |
| `total_members` | `int` | Число участников. |
| `first_message_id` / `last_message_id` | `UUIDv7 \| null` | Первое/последнее сообщение. |
| `total_unread_messages` | `int` | Непрочитанные для текущего пользователя. |
| `last_viewed_message_id` | `UUIDv7 \| null` | Последнее просмотренное. |
| `is_notifications` | `boolean` | Включены ли уведомления. |
| `is_subscribed` | `boolean` | Подписан ли текущий пользователь. |
| `is_moderator` | `boolean` | Модератор ли текущий пользователь. |
| `can_deleted_message` / `can_clean_messages` / `can_restrict_members` / `can_invite_users` / `can_pin_messages` | `boolean` | Права текущего пользователя. |
| `display_user_id` | `UUIDv7 \| null` | Собеседник (для диалогов). |
| `display_last_action_at` | `ISO 8601 \| null` | Активность собеседника (в `get_data`). |
| `display_privacy_*` | `string \| null` | Приватности собеседника (для диалогов). |
| `display_last_viewed_message_id` | `UUIDv7 \| null` | Прочтено собеседником (диалоги). |
| `main_folders_ids` | `UUIDv7[]` | Папки, куда добавлен канал. |
| `display_name` | `string` | Отображаемое имя. |
| `avatar` | [File](./file.md) \| `null` | Аватар. |
| `display_user_is_online` | `boolean \| null` | Собеседник онлайн (диалоги). |
| `last_message` | [Message](./message.md) \| `null` | Последнее сообщение. |
| `topics` | `Channel[]` | Темы (только для групп, тип 2). |
| `bots` | `{ id, bot_commands }[]` | Боты канала и их команды. |

## Варианты

- `get_meta` — без `last_message` и `display_last_action_at`.
- `get_base` — без пользовательской специфики (нет `is_subscribed`, `is_moderator`,
  прав, непрочитанных и т.п.).
- `[dialog]: create bot` — канал типа 8.

## Связанные страницы

- [channel-profile](../websocket/client-to-server/channel-profile.md) — медиа канала.
- [groups](../websocket/client-to-server/groups.md), [groups-topics](../websocket/client-to-server/groups-topics.md).
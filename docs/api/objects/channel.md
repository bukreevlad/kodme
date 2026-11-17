# Channel — канал

Канал — любое пространство для сообщений: диалог, группа, канал, тема, избранное,
чат конференции или трансляции.

## Виды каналов

```json
{ "kind": "channel" }
```

| `kind` | Название |
| --- | --- |
| `dialog` | Диалог (личный чат). Собеседник-бот определяется по объекту бота. |
| `group` | Группа. |
| `channel` | Канал (публичный канал-рассылка). |
| `topic` | Тема группы. |
| `favorite` | Избранное (saved messages). |
| `meet_chat` | Чат конференции. |
| `cast_chat` | Чат трансляции. |

## `get_data` (для текущего пользователя)

```json
{
  "id": "UUIDv7",
  "owner_id": "UUIDv7",
  "kind": "channel",
  "about": null,
  "created_at": "2026-09-21T12:34:56.789Z",
  "parent_channel_id": null,
  "visibility": "public",
  "posting_mode": "admins",
  "is_commenting": false,
  "last_pts": 0,
  "link": null,
  "total_members": 42,
  "first_message_id": null,
  "last_message_id": null,
  "total_unread_messages": 0,
  "last_read_id": null,
  "last_cleared_id": null,
  "updated_at": null,
  "notifications": { "mode": "all" },
  "is_subscribed": true,
  "display_user_id": null,
  "display_last_action_at": null,
  "display_privacy_messages": null,
  "display_last_read_id": null,
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
| `owner_id` | `UUIDv7` | Владелец (создатель) канала. |
| `kind` | `string` | Вид канала (см. выше). |
| `about` | `string \| null` | Описание. |
| `created_at` | `ISO 8601` | Дата создания. |
| `parent_channel_id` | `UUIDv7 \| null` | Родительский канал: у темы — её группа, у остальных видов — `null`. |
| `visibility` | `string` | `"public"` \| `"private"` — публичность канала. |
| `posting_mode` | `string` | Кто может писать: `"all"` — все подписанные участники, `"admins"` — только владелец и модераторы с правом публикации. |
| `is_commenting` | `boolean` | Разрешены ли комментарии. |
| `last_pts` | `int` | Последняя точка ленты событий канала (см. [синхронизацию](../websocket/server-to-client/channels.md)). |
| `link` | `string \| null` | Публичная ссылка/приглашение. |
| `total_members` | `int` | Число участников. |
| `first_message_id` / `last_message_id` | `UUIDv7 \| null` | Первое/последнее сообщение. |
| `total_unread_messages` | `int` | Непрочитанные для текущего пользователя. |
| `last_read_id` | `UUIDv7 \| null` | Позиция прочитанного текущим пользователем. |
| `last_cleared_id` | `UUIDv7 \| null` | Граница «очистить историю для себя»: сообщения старше неё не показываются. |
| `updated_at` | `ISO 8601 \| null` | Когда позиция прочитанного (`last_read_id`, `last_cleared_id`) последний раз менялась. |
| `notifications` | `{ mode }` \| `null` | Подписка на уведомления этой сущности для текущего пользователя: `mode` — `"all"` \| `"none"` \| `"mentions"`; `null` — подписки нет (пользователь не подписчик), push-уведомления не приходят. Подписка создаётся при вступлении в сущность, режим меняется событиями enable/disable notify. |
| `is_subscribed` | `boolean` | Подписан ли текущий пользователь. |
| `display_user_id` | `UUIDv7 \| null` | Собеседник (для диалогов). |
| `display_last_action_at` | `ISO 8601 \| null` | Активность собеседника (в `get_data`). |
| `display_privacy_*` | `string \| null` | Приватности собеседника (для диалогов). |
| `display_last_read_id` | `UUIDv7 \| null` | Позиция прочитанного собеседником (диалоги). |
| `main_folders_ids` | `UUIDv7[]` | Папки, куда добавлен канал. |
| `display_name` | `string` | Отображаемое имя. |
| `avatar` | [File](./file.md) \| `null` | Аватар. |
| `display_user_is_online` | `boolean \| null` | Собеседник онлайн (диалоги). |
| `last_message` | [Message](./message.md) \| `null` | Последнее сообщение. |
| `topics` | `Channel[]` | Темы (только для групп, `kind: "group"`). |
| `bots` | `{ id, commands }[]` | Боты канала и их команды. |

## Варианты

- `get_meta` — без `last_message` и `display_last_action_at`.
- `get_base` — без пользовательской специфики (нет `is_subscribed`,
  `notifications`, непрочитанных, позиций прочтения и т.п.).
- `[dialog]: create bot` — диалог с ботом имеет тот же `kind: "dialog"`;
  бот-собеседник определяется по объекту [Bot](./bot.md).

## Связанные страницы

- [channel-profile](../websocket/client-to-server/channel-profile.md) — медиа канала.
- [groups](../websocket/client-to-server/groups.md), [groups-topics](../websocket/client-to-server/groups-topics.md).
- [События канала](../websocket/server-to-client/channels.md) — лента событий и `last_pts`.

# groups-topics — темы групп

События раздела `[group-topic]`. Тема — канал типа 4 внутри группы (тип 2).
Группа задаётся полем `group_id` (id канала группы).

## `[group-topic]: create` — создать тему

```json
{ "group_id": "UUIDv7", "name": "Обсуждения", "about": null, "is_public": true, "is_posting": false }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название, `^[а-яеЁА-Яa-zA-Z0-9-:_ .\/\\]{2,128}$`. |
| `about` | `string \| null` | `null` | Описание. |
| `is_public` | `boolean` | `true` | Публичность. |
| `is_posting` | `boolean` | `false` | Разрешена ли запись участниками. |

Ответ: `{ "channel_id": "UUIDv7" }`.

## `[group-topic]: get settings` — настройки темы

```json
{ "channel_id": "UUIDv7" }
```

Ответ:

```json
{
  "id": "UUIDv7",
  "created_user_id": "UUIDv7",
  "type": 4,
  "name": "Обсуждения",
  "about": null,
  "created_at": "2026-09-21T12:34:56.789Z",
  "topic_for_group_id": "UUIDv7",
  "is_public": true,
  "is_posting": false,
  "avatar": null
}
```

## `[group-topic]: save settings` — изменить тему

```json
{ "channel_id": "UUIDv7", "name": "Новое", "about": null, "is_public": true, "is_posting": false }
```

Ответ — пустой.

## `[group-topic]: get upload avatar url` / `[group-topic]: save avatar`

Ссылка загрузки и сохранение аватарки темы — как в [channels.md](./channels.md).
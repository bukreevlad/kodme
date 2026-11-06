# groups — группы бота

События раздела `[group]` для соединения бота. Бот создаёт и управляет
группами (type 2) как владелец. Контракты совпадают с клиентскими
версиями (см. [groups.md](../client-to-server/groups.md)).

Правила доступа как у трансляций: управлять может **только создатель**
группы. Приглашения в группу создаются событиями раздела
[channels](./channels.md) (`[channel]: create invite` с `channel_id`
группы) — так же, как это делает клиентская форма группы.

## `[group]: create` — создать группу

```json
{ "name": "Группа", "about": "", "link": "", "is_public": true, "is_posting": false }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название (обязательно). |
| `about` | `string \| null` | `""` | Описание. |
| `link` | `string \| null` | `""` | Публичная ссылка; пусто — без ссылки. |
| `is_public` | `boolean` | `true` | Публичность. |
| `is_posting` | `boolean` | `false` | Могут ли писать все. |

Ответ: `{ "channel_id": "UUIDv7" }`.

## `[group]: remove` — удалить группу

```json
{ "channel_id": "UUIDv7" }
```

Только создатель. Удаляет группу и её данные (включая темы). Ответ —
пустой. Ошибка: `ACCESS_DENIED`.

## `[group]: get settings` / `[group]: save settings` — настройки

```json
{ "channel_id": "UUIDv7", "name": "Новое", "about": "", "is_public": true, "is_posting": false }
```

Только создатель. `get settings` принимает только `channel_id`.
Ответ: объект группы / пустой.

## `[group]: save link` — публичная ссылка

```json
{ "channel_id": "UUIDv7", "link": "my_group" }
```

Только создатель. Ответ — пустой.

## Аватар группы

- `[group]: get upload avatar url` — `{ "channel_id", "file_name", "mime_type", "size" }`
  → цели загрузки (см. [руководство по файлам](../../guides/upload.md));
- `[group]: save avatar` — `{ "channel_id", "document_id" }` →
  токенизированный объект файла; таймаут **не меньше 120 секунд**;
- `[group]: remove avatar` — `{ "channel_id" }` → пустой (идемпотентно).

Все три — только создатель.

## Модераторы группы

| Событие | Payload | Описание |
| --- | --- | --- |
| `[group]: get moderators` | `{ "channel_id", "direction", "cursor_id", "offset" }` | Список модераторов. |
| `[group]: add moderator` | `{ "channel_id", "user_id", can_* }` | Назначить модератора. `user_id` — **id назначаемого**; права: `can_deleted_message`, `can_clean_messages`, `can_restrict_members`, `can_invite_users`, `can_pin_messages` (все `boolean`). |
| `[group]: get moderator settings` | `{ "channel_id", "user_id" }` | Права модератора (`user_id` — id модератора). |
| `[group]: save moderator settings` | `{ "channel_id", "user_id", can_* }` | Изменить права. |

Назначение и изменение прав — только создателю группы. Ответы — как у
клиентских событий.

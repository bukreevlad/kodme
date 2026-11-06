# groups-topics — темы групп бота

События раздела `[group-topic]` для соединения бота. Бот создаёт и
управляет темами групп (type 4) как создатель. Контракты совпадают с
клиентскими версиями (см.
[groups-topics.md](../client-to-server/groups-topics.md)).

Правила доступа как у трансляций: управлять может **только создатель**
темы. Приглашения в тему создаются событиями раздела
[channels](./channels.md) (`[channel]: create invite` с `channel_id`
темы) — так же, как это делает клиентская форма темы.

## `[group-topic]: create` — создать тему

```json
{ "group_id": "UUIDv7", "name": "Тема", "about": "", "is_public": true, "is_posting": false }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `group_id` | `UUIDv7` | — | Id группы (обязательно). |
| `name` | `string` | — | Название (обязательно). |
| `about` | `string \| null` | `""` | Описание. |
| `is_public` | `boolean` | `true` | Публичность. |
| `is_posting` | `boolean` | `false` | Могут ли писать все. |

Ответ: `{ "channel_id": "UUIDv7" }` (тема — канал типа 4).

## `[group-topic]: remove` — удалить тему

```json
{ "channel_id": "UUIDv7" }
```

Только создатель. Удаляет тему и её данные. Ответ — пустой.
Ошибка: `ACCESS_DENIED`.

## `[group-topic]: get settings` / `[group-topic]: save settings` — настройки

```json
{ "channel_id": "UUIDv7", "name": "Новое", "about": "", "is_public": true, "is_posting": false }
```

Только создатель. `get settings` принимает только `channel_id`.
Ответ: объект темы / пустой.

## Аватар темы

- `[group-topic]: get upload avatar url` — `{ "channel_id", "file_name", "mime_type", "size" }`
  → цели загрузки (см. [руководство по файлам](../../guides/upload.md));
- `[group-topic]: save avatar` — `{ "channel_id", "document_id" }` →
  токенизированный объект файла; таймаут **не меньше 120 секунд**;
- `[group-topic]: remove avatar` — `{ "channel_id" }` → пустой (идемпотентно).

Все три — только создатель.

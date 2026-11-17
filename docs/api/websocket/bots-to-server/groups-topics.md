# groups-topics — темы групп бота

События раздела `[group-topic]` для соединения бота. Бот создаёт и
управляет темами групп (`kind: "topic"`) как создатель. Контракты совпадают с
клиентскими версиями (см.
[groups-topics.md](../client-to-server/groups-topics.md)).

Управлять темой может **только создатель**. Приглашения в тему
создаются и отзываются событиями раздела [channels](./channels.md)
(`[channel]: create invite` / `[channel]: remove invite` с `channel_id`
темы) — создателем либо модератором с правом `members.invite`.

## `[group-topic]: create` — создать тему

```json
{ "group_id": "UUIDv7", "name": "Тема", "about": "", "visibility": "public", "posting_mode": "admins" }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `group_id` | `UUIDv7` | — | Id группы (обязательно). |
| `name` | `string` | — | Название (обязательно). |
| `about` | `string \| null` | `""` | Описание. |
| `visibility` | `string` | `"public"` | `"public"` \| `"private"` — публичность. |
| `posting_mode` | `string` | `"admins"` | Кто может писать: `"all"` — все подписанные участники, `"admins"` — только владелец и модераторы с правом публикации. |

Ответ: `{ "channel_id": "UUIDv7" }` (тема — канал `kind: "topic"`).

## `[group-topic]: remove` — удалить тему

```json
{ "channel_id": "UUIDv7" }
```

Только создатель. Удаляет тему и её данные. Ответ — пустой.
Ошибка: `ACCESS_DENIED`.

## `[group-topic]: get settings` / `[group-topic]: save settings` — настройки

```json
{ "channel_id": "UUIDv7", "name": "Новое", "about": "", "visibility": "public", "posting_mode": "admins" }
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

# groups-topics — темы групп

События раздела `[group-topic]`. Тема — канал `kind: "topic"` внутри группы
(`kind: "group"`). Группа задаётся полем `group_id` (id канала группы).

## `[group-topic]: create` — создать тему

```json
{ "group_id": "UUIDv7", "name": "Обсуждения", "about": null, "visibility": "public", "posting_mode": "admins" }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название, `^[а-яеЁА-Яa-zA-Z0-9-:_ .\/\\]{2,128}$`. |
| `about` | `string \| null` | `null` | Описание. |
| `visibility` | `string` | `"public"` | `"public"` \| `"private"` — публичность темы. |
| `posting_mode` | `string` | `"admins"` | Кто может писать: `"all"` — все подписанные участники, `"admins"` — только владелец и модераторы с правом публикации. |

Ответ: `{ "channel_id": "UUIDv7" }`.

## `[group-topic]: remove` — удалить тему

```json
{ "channel_id": "UUIDv7" }
```

*Только создатель.* Удаляет тему и её данные. Ответ — пустой.
Ошибка: `ACCESS_DENIED`.

## `[group-topic]: get settings` — настройки темы

```json
{ "channel_id": "UUIDv7" }
```

Ответ:

```json
{
  "id": "UUIDv7",
  "owner_id": "UUIDv7",
  "kind": "topic",
  "name": "Обсуждения",
  "about": null,
  "created_at": "2026-09-21T12:34:56.789Z",
  "parent_channel_id": "UUIDv7",
  "visibility": "public",
  "posting_mode": "admins",
  "avatar": null
}
```

## `[group-topic]: save settings` — изменить тему

```json
{ "channel_id": "UUIDv7", "name": "Новое", "about": null, "visibility": "public", "posting_mode": "admins" }
```

Ответ — пустой.

## `[group-topic]: get upload avatar url` / `[group-topic]: save avatar`

Ссылка загрузки и сохранение аватарки темы — как в [channels.md](./channels.md).

## `[group-topic]: remove avatar` — удалить аватар

```json
{ "channel_id": "UUIDv7" }
```

*Только владелец.* Снимает ссылку на аватар: файл и документ не удаляются,
аватар перестаёт отображаться. Повторный вызов идемпотентен (отсутствие
аватара — не ошибка). Ответ — пустой. Ошибка: `ACCESS_DENIED` (запрашивает
не владелец темы).
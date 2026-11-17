# groups — группы бота

События раздела `[group]` для соединения бота. Бот создаёт и управляет
группами (`kind: "group"`) как владелец. Контракты совпадают с клиентскими
версиями (см. [groups.md](../client-to-server/groups.md)).

Управлять группой может **только создатель**. Приглашения в группу
создаются и отзываются событиями раздела [channels](./channels.md)
(`[channel]: create invite` / `[channel]: remove invite` с `channel_id`
группы) — создателем либо модератором с правом `members.invite`.

## `[group]: create` — создать группу

```json
{ "name": "Группа", "about": "", "link": "", "visibility": "public", "posting_mode": "admins" }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название (обязательно). |
| `about` | `string \| null` | `""` | Описание. |
| `link` | `string \| null` | `""` | Публичная ссылка; пусто — без ссылки. |
| `visibility` | `string` | `"public"` | `"public"` \| `"private"` — публичность. |
| `posting_mode` | `string` | `"admins"` | Кто может писать: `"all"` — все подписанные участники, `"admins"` — только владелец и модераторы с правом публикации. |

Ответ: `{ "channel_id": "UUIDv7" }`.

## `[group]: remove` — удалить группу

```json
{ "channel_id": "UUIDv7" }
```

Только создатель. Удаляет группу и её данные (включая темы). Ответ —
пустой. Ошибка: `ACCESS_DENIED`.

## `[group]: get settings` / `[group]: save settings` — настройки

```json
{ "channel_id": "UUIDv7", "name": "Новое", "about": "", "visibility": "public", "posting_mode": "admins" }
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

## `[group]: get groups` — список групп бота

```json
{ "direction": null, "cursor_id": null, "offset": 100 }
```

Поля пагинации — как у клиентского `[channel]: get conversations`.
Ответ — массив meta групп. Возвращаются **только созданные ботом**
группы (`kind = group`: без каналов, подписок, диалогов и чужих
публичных). Список сообществ бота — отдельное событие
`[channel]: get channels` (см. [channels.md](./channels.md)).

## Модераторы группы

| Событие | Payload | Описание |
| --- | --- | --- |
| `[group]: get moderators` | `{ "channel_id", "direction", "cursor_id", "offset" }` | Список модераторов: членство + поля прав `is_moderator`/`can_*` (см. [Role](../../objects/role.md)). |
| `[group]: add moderator` | `{ "channel_id", "user_id", can_* }` | Назначить модератора: узкие роли `channel_moderator_*` по галочкам `can_*` (см. [Role](../../objects/role.md)); `user_id` — **id назначаемого**; поля `can_deleted_message`, `can_clean_messages`, `can_restrict_members`, `can_invite_users`, `can_pin_messages`, `can_posting_messages` (все `boolean`) входят в контракт, состав прав меняется `save moderator settings`. |
| `[group]: remove moderator` | `{ "channel_id", "user_id" }` | Удалить модератора (`user_id` — id модератора): роль модератора снимается, участник остаётся в группе. |
| `[group]: get moderator settings` | `{ "channel_id", "user_id" }` | Права модератора (`user_id` — id модератора): членство + поля `is_moderator`/`can_*` (см. [Role](../../objects/role.md)). |
| `[group]: save moderator settings` | `{ "channel_id", "user_id", can_* }` | Изменить права: по узкой роли `channel_moderator_*` на включённую галочку, все шесть — полная роль `channel_moderator`, ни одной — модераторские роли снимаются (см. [Role](../../objects/role.md)). |

Назначение, удаление и изменение прав — только создателю группы. Ответы — как у
клиентских событий.

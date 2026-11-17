# channels — каналы бота

События раздела `[channel]` для соединения бота. Бот создаёт и управляется
каналами-сообществами (`kind: "channel"`) как владелец. Контракты совпадают с
клиентскими версиями (см. [channels.md](../client-to-server/channels.md)).

Управлять каналом (настройки, ссылка, аватар, удаление)
может **только создатель**; приглашения (создание, список, отзыв)
доступны также модератору с правом `members.invite`. Событиями
приглашений пользуются и группы,
и темы: это тоже каналы, их id передаётся в `channel_id`.

## `[channel]: create` — создать сообщество

```json
{ "name": "Канал", "about": "", "link": "", "visibility": "public", "posting_mode": "admins", "is_commenting": false }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название (обязательно). |
| `about` | `string \| null` | `""` | Описание. |
| `link` | `string \| null` | `""` | Публичная ссылка; пусто — без ссылки. |
| `visibility` | `string` | `"public"` | `"public"` \| `"private"` — публичность. |
| `posting_mode` | `string` | `"admins"` | Кто может писать: `"all"` — все подписанные участники, `"admins"` — только владелец и модераторы с правом публикации. |
| `is_commenting` | `boolean` | `false` | Можно ли комментировать записи. |

Ответ: `{ "channel_id": "UUIDv7" }`.

## `[channel]: remove` — удалить канал

```json
{ "channel_id": "UUIDv7" }
```

Только создатель. Удаляет канал и его данные. Ответ — пустой.
Ошибка: `ACCESS_DENIED`.

## `[channel]: get settings` / `[channel]: save settings` — настройки

```json
{ "channel_id": "UUIDv7", "name": "Новое", "about": "", "visibility": "public", "posting_mode": "admins", "is_commenting": false }
```

Только создатель. `get settings` принимает только `channel_id` и
возвращает ответ клиентского события; `save settings` — остальные поля.
Ответ: объект канала / пустой.

## `[channel]: save link` — публичная ссылка

```json
{ "channel_id": "UUIDv7", "link": "my_channel" }
```

Только создатель. Ответ — пустой.

## Аватар канала

- `[channel]: get upload avatar url` — `{ "channel_id", "file_name", "mime_type", "size" }`
  → цели загрузки `{ "targets": [...], "document_id": "UUIDv7" }` (см.
  [руководство по файлам](../../guides/upload.md));
- `[channel]: save avatar` — `{ "channel_id", "document_id" }` →
  токенизированный объект файла; таймаут **не меньше 120 секунд**;
- `[channel]: remove avatar` — `{ "channel_id" }` → пустой (идемпотентно).

Все три — только создатель.

## `[channel]: create invite` / `[channel]: get invites` — приглашения

```json
{ "channel_id": "UUIDv7", "name": "Для друзей", "max_users": 0 }
```

Только создатель; `channel_id` — канал, группа **или тема**. Ответ —
объект [Invite](../../objects/invite.md) (в поле `url` — готовая
полная ссылка) / список инвайтов с `has_more`.

## `[channel]: remove invite` — отозвать приглашение

```json
{ "channel_id": "UUIDv7", "invite_id": "UUIDv7" }
```

Только создатель; `channel_id` — канал, группа **или тема**. Приглашение
перестаёт действовать. Ответ — пустой. Ошибки: `ACCESS_DENIED`,
`INVITE_NOT_FOUND` (нет такого приглашения у этой сущности или оно уже
отозвано).

## `[channel]: get channels` — список каналов бота

```json
{ "direction": null, "cursor_id": null, "offset": 100 }
```

Поля пагинации — как у клиентского `[channel]: get conversations`.
Ответ — массив meta каналов. Возвращаются **только созданные ботом**
сообщества (`kind = channel`: без групп, подписок, диалогов и чужих
публичных). Список групп бота — отдельное событие
`[group]: get groups` (см. [groups.md](./groups.md)).

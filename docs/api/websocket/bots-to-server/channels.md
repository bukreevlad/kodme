# channels — каналы бота

События раздела `[channel]` для соединения бота. Бот создаёт и управляется
каналами-сообществами (type 3) как владелец. Контракты совпадают с
клиентскими версиями (см. [channels.md](../client-to-server/channels.md)).

Правила доступа как у трансляций: настройки, ссылку, аватар, приглашения
и удаление получает **только создатель** канала. Инвайты групп и тем
тоже создаются этими событиями (группа/тема — каналы, `channel_id` —
их id).

## `[channel]: create` — создать сообщество

```json
{ "name": "Канал", "about": "", "link": "", "is_public": true, "is_posting": false, "is_commenting": false }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название (обязательно). |
| `about` | `string \| null` | `""` | Описание. |
| `link` | `string \| null` | `""` | Публичная ссылка; пусто — без ссылки. |
| `is_public` | `boolean` | `true` | Публичность. |
| `is_posting` | `boolean` | `false` | Могут ли писать все. |
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
{ "channel_id": "UUIDv7", "name": "Новое", "about": "", "is_public": true, "is_posting": false, "is_commenting": false }
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

## `[channel]: get channels` — список каналов бота

```json
{ "direction": null, "cursor_id": null, "offset": 100 }
```

Поля пагинации — как у клиентского `[channel]: get user conversations`.
Ответ — массив meta каналов. Режим бота: возвращаются **только
созданные им** каналы (без подписок, диалогов и чужих публичных) —
зеркало `[broadcast]: get casts` и `[meet]: get meets`.

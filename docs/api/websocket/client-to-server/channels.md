# channels — каналы

События раздела `[channel]`. Канал типа 3 (публичный канал для подписчиков).
Основной объект — [Channel](../../objects/channel.md).

## `[channel]: create` — создание канала

```json
{ "name": "Мой канал", "about": null, "is_public": true }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название, 2–128 символов (кириллица/латиница/общие символы). |
| `about` | `string \| null` | `null` | Описание, до 255 символов. |
| `is_public` | `boolean` | `true` | Публичность. |

Ответ: `{ "channel_id": "UUIDv7" }`.

## `[channel]: get info` — информация о канале

```json
{ "channel_id": "UUIDv7" }
```

Ответ — объект [Channel](../../objects/channel.md) (meta).

## `[channel]: get user conversations` — список диалогов и каналов

```json
{ "direction": "next", "cursor_id": null, "offset": 100 }
```

Ответ — массив [Channel](../../objects/channel.md). Всегда включается «Избранное»
(тип 5); остальные типы — по конфигурации сервера (диалоги, группы, каналы, чаты).

## `[channel]: get updates` — новые данные по каналам

```json
{ "channels": [ { "id": "UUIDv7", "pts": 123 } ], "offset": 100 }
```

Ответ: `{ "items": [ ... ], "has_more": false }` — обновления и флаг наличия ещё порций.

## `[channel]: open` — открыть канал

```json
{ "channel_id": "UUIDv7" }
```

Ответ — объект [Channel](../../objects/channel.md).

## `[channel]: close` — закрыть канал

```json
{ "channel_id": "UUIDv7" }
```

Ответ — пустой.

## `[channel]: user typing` — сигнал набора текста

```json
{ "channel_id": "UUIDv7" }
```

Ответ — пустой. Собеседники получают push `[channel]: user typing`.

## `[channel]: get settings` — настройки канала

```json
{ "channel_id": "UUIDv7" }
```

*Только владелец.* Ответ:

```json
{
  "id": "UUIDv7",
  "created_user_id": "UUIDv7",
  "type": 3,
  "name": "...",
  "about": null,
  "created_at": "2026-09-21T12:34:56.789Z",
  "group_for_channel_id": null,
  "topic_for_group_id": null,
  "is_public": true,
  "is_posting": true,
  "is_commenting": false,
  "link": "...",
  "avatar": null
}
```

## `[channel]: save settings` — изменение настроек

*Только владелец.* Принимает те же поля, что возвращает `[channel]: get settings`
(изменяются `name`, `about`, `is_public` и др.). Ответ — пустой.

## `[channel]: save link` — ссылка-приглашение

```json
{ "channel_id": "UUIDv7", "link": "channel-link" }
```

*Только владелец.* Ответ — пустой.

## `[channel]: create invite` — инвайт

```json
{ "channel_id": "UUIDv7", "name": "Для друзей", "max_users": 0 }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `max_users` | `int` | `0` | Лимит использований; `0` — без лимита. Диапазон 0–1000. |

Ответ — объект [Invite](../../objects/invite.md).

## `[channel]: get invites` — список инвайтов

```json
{ "channel_id": "UUIDv7", "direction": "next", "cursor_id": null, "offset": 100 }
```

Ответ — массив [Invite](../../objects/invite.md) **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы). `offset` — диапазон 1–300.

## `[channel]: remove invite` — отозвать инвайт

```json
{ "channel_id": "UUIDv7", "invite_id": "UUIDv7" }
```

*Только владелец.* Инвайт помечается удалённым и перестаёт действовать
(для канала, группы **или темы**). Ответ — пустой. Ошибки:
`ACCESS_DENIED`, `INVITE_NOT_FOUND` (нет такого приглашения у этой
сущности или оно уже отозвано).

## `[channel]: get upload avatar url` — ссылка для загрузки аватарки

```json
{ "file_name": "avatar.jpg", "channel_id": "UUIDv7", "mime_type": "image/jpeg", "size": 102400 }
```

*Только владелец.* Ответ — цели загрузки: `{ "targets": [...], "document_id": "UUIDv7" }` —
**только оригинал**, производные ассеты создаст сервер. Загрузите цель
`POST`-ом по её `url` (см.
[руководство по файлам](../../guides/upload.md)).

## `[channel]: save avatar` — сохранить аватар

```json
{ "document_id": "UUIDv7", "channel_id": "UUIDv7" }
```

*Только владелец.* Вызывается после загрузки оригинала. Сервер проверяет
оригинал в хранилище, генерирует производные ассеты и отвечает готовым
объектом — ожидание обработки может занять до ~100 секунд, таймаут запроса
должен быть **не меньше 120 секунд**. Повторный вызов идемпотентен.
Ответ — токенизированный объект файла (см. [objects/file.md](../../objects/file.md)).

## `[channel]: remove avatar` — удалить аватар

```json
{ "channel_id": "UUIDv7" }
```

*Только владелец.* Снимает ссылку на аватар: файл и документ не удаляются,
аватар перестаёт отображаться. Повторный вызов идемпотентен (отсутствие
аватара — не ошибка). Ответ — пустой. Ошибка: `ACCESS_DENIED` (запрашивает
не владелец канала).

## `[channel]: remove` — удалить канал

```json
{ "channel_id": "UUIDv7" }
```

*Только владелец.* Ответ — пустой.
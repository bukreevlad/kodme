# channels — каналы

События раздела `[channel]`. Канал — публичное пространство для подписчиков
(`kind: "channel"`). Основной объект — [Channel](../../objects/channel.md).

## `[channel]: create` — создание канала

```json
{ "name": "Мой канал", "about": null, "visibility": "public" }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название, 2–128 символов (кириллица/латиница/общие символы). |
| `about` | `string \| null` | `null` | Описание, до 255 символов. |
| `visibility` | `string` | `"public"` | `"public"` \| `"private"` — публичность канала. |

Ответ: `{ "channel_id": "UUIDv7" }`.

## `[channel]: get info` — информация о канале

```json
{ "channel_id": "UUIDv7" }
```

Ответ — объект [Channel](../../objects/channel.md) (meta).

## `[channel]: get conversations` — список диалогов и каналов

```json
{ "direction": "next", "cursor_id": null, "offset": 100 }
```

Ответ — массив [Channel](../../objects/channel.md). Всегда включается «Избранное»
(`kind: "favorite"`); остальные виды — по конфигурации сервера (диалоги, группы, каналы, чаты).

## `[channel]: get updates` — догоняющая синхронизация

События ленты каналов, которых нет у клиента:

```json
{ "channels": [ { "id": "UUIDv7", "pts": 123 } ], "offset": 100 }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `channels` | `array` | — | Состояния каналов: `id` канала и последний применённый клиентом `pts`. |
| `offset` | `int` | `35` | Максимум событий в ответе, диапазон 1–100. |

Ответ:

```json
{
  "items": [ { "channel_id": "UUIDv7", "type": "message_new", "pts": 124, "payload": { "message_id": "UUIDv7" }, "created_at": "2026-09-21T12:34:56.789Z" } ],
  "has_more": false,
  "too_long": []
}
```

- `items` — события ленты (тем же форматом, что и живые `[channel]: feed`), по
  возрастанию `pts`;
- `has_more` — есть ли следующая порция;
- `too_long` — массив id каналов, чья точка отрезана лентой: по ним клиент
  обязан перечитать канал целиком, остальные догоняются событиями.

Формат событий, правило применения по `pts` и таблица типов — в разделе
[синхронизации канала](../server-to-client/channels.md#синхронизация-и-события-канала).

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
  "owner_id": "UUIDv7",
  "kind": "channel",
  "name": "...",
  "about": null,
  "created_at": "2026-09-21T12:34:56.789Z",
  "parent_channel_id": null,
  "visibility": "public",
  "posting_mode": "admins",
  "is_commenting": false,
  "link": "...",
  "avatar": null
}
```

## `[channel]: save settings` — изменение настроек

*Только владелец.* Принимает те же поля, что возвращает `[channel]: get settings`
(изменяются `name`, `about`, `visibility`, `posting_mode`, `is_commenting` и др.). Ответ — пустой.

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

Доступ — создатель сущности (канал, группа или тема) либо модератор с правом `members.invite`.

Ответ — объект [Invite](../../objects/invite.md).

## `[channel]: get invites` — список инвайтов

```json
{ "channel_id": "UUIDv7", "direction": "next", "cursor_id": null, "offset": 100 }
```

Доступ — создатель сущности либо модератор с правом `members.invite`.

Ответ — массив [Invite](../../objects/invite.md) **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы). `offset` — диапазон 1–300.

## `[channel]: remove invite` — отозвать инвайт

```json
{ "channel_id": "UUIDv7", "invite_id": "UUIDv7" }
```

*Создатель сущности либо модератор с правом `members.invite`.* Инвайт помечается удалённым и перестаёт действовать
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
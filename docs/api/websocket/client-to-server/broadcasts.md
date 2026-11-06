# broadcasts — трансляции

События раздела `[broadcast]`. Трансляция связана с SRS (RTMP/RTC) и чатом на базе канала типа 7.
Основной объект — [Broadcast](../../objects/broadcast.md).

## `[broadcast]: create` — создать трансляцию

```json
{ "name": "Моя трансляция", "about": null, "is_public": true, "is_chat": true }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название, 2–128 символов (кириллица/латиница/общие символы). |
| `about` | `string \| null` | `null` | Описание, до 255 символов. |
| `is_public` | `boolean` | `true` | Публичность. |
| `is_chat` | `boolean` | `true` | Включить чат трансляции (создаётся канал типа 7). |

Ответ: `{ "cast_id": "UUIDv7" }`.

## `[broadcast]: get casts` — список трансляций

```json
{ "direction": "next", "cursor_id": null, "offset": 35 }
```

`offset` — диапазон 1–100.

Ответ — массив [Broadcast](../../objects/broadcast.md) (meta) **и** поле
`has_more: boolean` — есть ли продолжение в сторону `direction`
(для первой загрузки — есть ли более старые записи, новые сверху первой
страницы появятся только при следующем запросе с `direction: "next"`).

Порядок массива — «новые сверху»:

| `direction` | Порядок | Ось пагинации |
| --- | --- | --- |
| не передан (первая загрузка) | от новых к старым | `cursor_id` не нужен |
| `"prev"` | от новых к старым | записи **старше** `cursor_id` |
| `"next"` | от старых к новым | записи **новее** `cursor_id` |

## `[broadcast]: get settings` — настройки

```json
{ "cast_id": "UUIDv7" }
```

*Только владелец.* Ответ — объект [Broadcast](../../objects/broadcast.md) (meta) + поле `token`
(токен для подключения трансляции к серверу, в клиентских сценариях обычно не используется).

## `[broadcast]: save settings` — изменение настроек

```json
{ "cast_id": "UUIDv7", "name": "Новое", "about": null, "is_public": true, "is_chat": true }
```

Ответ — пустой.

## `[broadcast]: open` — открыть трансляцию

```json
{ "cast_id": "UUIDv7" }
```

Соединение подписывается на комнату `broadcast::<cast_id>` (получение `[broadcast]: update`).
Доступ — публичная трансляция, владелец или подписанный участник.

Ответ:

```json
{ "data": { "...meta Broadcast": "...", "access_token": "JWT для просмотра потока" } }
```

## `[broadcast]: close` — закрыть трансляцию

```json
{ "cast_id": "UUIDv7" }
```

Соединение отписывается от комнаты `broadcast::<cast_id>`. Ответ — пустой.

## `[broadcast]: get stream info` — статус потока

```json
{ "cast_id": "UUIDv7" }
```

Ответ — `null`, если трансляция не идёт, иначе:

```json
{
  "name": "...",
  "app": "...",
  "online": true,
  "bitrate": { "bps": 0, "kbps": 0, "mbps": 0, "recv_30s_kbps": 0, "send_30s_kbps": 0 },
  "received_total": 0,
  "video": { "codec": "H264", "width": 1920, "height": 1080, "fps": 25 },
  "audio": { "codec": "AAC", "sample_rate": 48000, "channels": 2 },
  "readers": 0,
  "total_readers": 0
}
```

`video` / `audio` — `null`, если соответствующая дорожка отсутствует.

## `[broadcast]: remove` — удалить трансляцию

```json
{ "cast_id": "UUIDv7" }
```

*Только владелец* — автор трансляции. Трансляции, созданные ботом,
из клиента не удаляются и не редактируются: удаляет и меняет настройки
только создавший их бот (см.
[bots-to-server/broadcasts.md](../bots-to-server/broadcasts.md)).
Удаляет трансляцию и её чат-канал. Ответ — пустой. Ошибка:
`ACCESS_DENIED`.

## `[broadcast]: create invite` — приглашение

```json
{ "cast_id": "UUIDv7", "name": "Для друзей", "max_users": 0 }
```

`max_users`: `0` — без лимита, диапазон 0–1000. Ответ — объект [Invite](../../objects/invite.md).

## `[broadcast]: get invites` — список приглашений

```json
{ "cast_id": "UUIDv7", "direction": "next", "cursor_id": null, "offset": 100 }
```

`offset` — диапазон 1–300. Ответ — массив [Invite](../../objects/invite.md) **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).

## `[broadcast]: get upload thumb url` — ссылка для загрузки обложки

```json
{ "file_name": "cover.jpg", "cast_id": "UUIDv7", "mime_type": "image/jpeg", "size": 102400 }
```

*Только владелец.* Ответ — цели загрузки: `{ "targets": [...], "document_id": "UUIDv7" }` —
**только оригинал**, производные ассеты создаст сервер. Загрузите цель
`POST`-ом по её `url` (см.
[руководство по файлам](../../guides/upload.md)).

## `[broadcast]: save thumb` — сохранить обложку

```json
{ "document_id": "UUIDv7", "cast_id": "UUIDv7" }
```

*Только владелец.* Вызывается после загрузки оригинала. Сервер проверяет
оригинал в хранилище, генерирует производные ассеты и отвечает готовым
объектом — ожидание обработки может занять до ~100 секунд, таймаут запроса
должен быть **не меньше 120 секунд**. Повторный вызов идемпотентен.
Ответ — токенизированный объект файла ([objects/file.md](../../objects/file.md)).

## `[broadcast]: remove thumb` — удалить обложку

```json
{ "cast_id": "UUIDv7" }
```

*Только владелец.* Снимает ссылку на обложку: файл и документ не
удаляются, обложка перестаёт отображаться. Повторный вызов идемпотентен
(отсутствие обложки — не ошибка). Ответ — пустой. Ошибка:
`ACCESS_DENIED` (запрашивает не владелец трансляции).
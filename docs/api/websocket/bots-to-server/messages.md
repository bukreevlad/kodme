# messages — сообщения бота

События раздела `[message]` для соединения бота. Бот отправляет сообщения **от
своего имени** и может прикреплять кнопки. Контракты совпадают с клиентскими
(см. [messages.md](../client-to-server/messages.md)).

## `[message]: send` — отправка сообщения

```json
{
  "channel_id": "UUIDv7",
  "text": "Привет!",
  "buttons": [ [ { "text": "ОК", "id": "ok", "state": "done" } ] ],
  "reply_to_message_id": null,
  "attachments": { "UUIDv7": {} }
}
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `channel_id` | `UUIDv7` | — | Канал, в который отправляется сообщение. |
| `text` | `string` | `""` | Текст сообщения. |
| `buttons` | `Array` | `[]` | Строки кнопок: до 10 строк, в строке до 5 кнопок `[{ text, id?, state?, classes? }]`. `id`/`state` — payload кнопки: возвращаются боту кликом событием `[message]: click button` (поля `button_id`/`state`). |
| `reply_to_message_id` | `UUIDv7 \| null` | `""` | Сообщение, на которое отвечаем. |
| `attachments` | `object` | `{}` | Вложения: объект, ключи — `document_id` из `[message]: get upload attach url`. |

Автор сообщения — всегда сам бот (поле `created_user_id` в запросе игнорируется).

Каждое вложение в `attachments` обязано пройти `[message]: save attach` —
иначе `send` отвечает `DOCUMENT_NOT_PROCESSED` (`122016`).

Ответ: `{ "message_id": "UUIDv7" }`.

## `[message]: get upload attach url` — ссылка для загрузки вложения

```json
{ "channel_id": "UUIDv7", "file_name": "photo.jpg", "mime_type": "image/jpeg", "size": 1024000, "metadata": null }
```

Ответ:

```json
{
  "targets": [
    {
      "path": "messages/attaches/<channel_id>/<uuid>/<uuid>.jpg",
      "kind": "original",
      "url": "https://...presigned.url",
      "fields": { "key": "...", "Policy": "..." },
      "mime_type": "image/jpeg",
      "max_size": 524288000
    }
  ],
  "document_id": "UUIDv7"
}
```

Загрузите `POST`-ом на `target.url` каждый объект `targets[]` (для вложений
выдаётся **только оригинал** — производные ассеты создаст сервер), затем
вызовите `[message]: save attach`. Описание процесса — в
[руководстве по файлам](../../guides/upload.md).

## `[message]: save attach` — сохранить загруженное вложение

```json
{ "document_id": "UUIDv7" }
```

Вызывается после загрузки оригинала и **до** `[message]: send`. Сервер
проверяет оригинал в хранилище (наличие и фактический размер), генерирует
производные ассеты и отвечает «готово». Ожидание обработки может занять до
~100 секунд — таймаут запроса должен быть **не меньше 120 секунд**. Повторный
вызов идемпотентен: уже обработанный файл отвечает сразу. Ответ:

```json
{ "document_id": "UUIDv7", "status": "ready" }
```

Формат идентичен клиентскому `[message]: save attach` (коды ошибок —
в [messages.md](../client-to-server/messages.md)).

## `[message]: get data` — данные сообщения

```json
{ "message_id": "UUIDv7" }
```

Ответ — объект [Message](../../objects/message.md), включая поле `reactions`.

## `[message]: update` — редактирование

```json
{ "message_id": "UUIDv7", "text": "Новый текст", "buttons": [ ... ] }
```

Только свои сообщения. Ответ — пустой. Обновление рассылается участникам
событием `[message]: update`.

## `[message]: remove` — удаление

```json
{ "message_id": "UUIDv7" }
```

Удаляет сообщение **для всех участников** (для бота `for_all` всегда
`true`). Кто может удалить — те же правила, что у клиента (см.
[messages.md](../client-to-server/messages.md)): автор сообщения,
владелец канала, модератор с правом удаления; в личных диалогах
(тип 1/8) — любой участник. Ответ — пустой. Ошибки: `ACCESS_DENIED`,
`REMOVE_FOR_ALL_DENIED`.

## `[message]: send reaction` — реакция

```json
{ "message_id": "UUIDv7", "reaction": "🔥" }
```

`reaction` — один из 16 поддерживаемых emoji. Повторная отправка той же реакции
снимает её; отправка другой реакции заменяет предыдущую.

Ответ — массив [Reaction](../../objects/reaction.md) для сообщения (актуальное состояние).

Ошибки: `MESSAGE_NOT_FOUND` (сообщение не найдено или удалено),
`ACCESS_DENIED` (нет доступа на чтение канала), `REACTION_UNAVAILABLE`
(эмодзи не из списка).

## Входящие события (сервер → бот)

Бот получает сообщения каналов, в которых он состоит.

### `[message]: new` — новое сообщение

Приходит публикацией в топик `bot::<bot_id>`:

```json
{
  "type": "event",
  "event": "[message]: new",
  "data": { "…": "Message (meta)" },
  "timestamp": "2026-09-21T12:34:56.789Z"
}
```

Сообщения, отправленные самим ботом, ему не приходят.

### `[message]: update` — изменение сообщения

Публикация в топик `bot::<bot_id>`; `data` — объект [Message (meta)](../../objects/message.md),
`timestamp` — ISO 8601.

### `[message]: click button` — нажатие кнопки сообщения

Приходит точечно в соединение бота (без `timestamp`):

```json
{
  "type": "event",
  "event": "[message]: click button",
  "data": {
    "socket_id": "…",
    "user_id": "UUIDv7",
    "channel_id": "UUIDv7",
    "message_id": "UUIDv7",
    "button_id": "btn-ok",
    "state": null
  }
}
```

`state` — состояние, переданное пользователем при нажатии.

### `[message]: remove` — удаление сообщения

Приходит публикацией в топик `bot::<bot_id>` при удалении сообщения
в канале «для всех» — включая собственные сообщения бота (чтобы бот
синхронизировал своё состояние):

```json
{
  "type": "event",
  "event": "[message]: remove",
  "data": {
    "channel_id": "UUIDv7",
    "message_id": "UUIDv7",
    "pts": "69"
  }
}
```

`pts` — контрольная точка канала; приходит строкой (bigint не помещается
в JSON).
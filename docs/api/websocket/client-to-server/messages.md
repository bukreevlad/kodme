# messages — сообщения

События раздела `[message]`. Основные объекты: [Message](../../objects/message.md), [Reaction](../../objects/reaction.md).

> Комментарии под постами сообществ — отдельный домен `[comment]`,
> см. [comments.md](./comments.md).

## `[message]: send` — отправка сообщения

```json
{
  "channel_id": "UUIDv7",
  "text": "Привет!",
  "reply_to_message_id": null,
  "attachments": { "UUIDv7": {} },
  "sticker_document_id": null
}
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `channel_id` | `UUIDv7` | — | Канал, в который отправляется сообщение. |
| `text` | `string` | — | Текст сообщения. |
| `reply_to_message_id` | `UUIDv7 \| null` | `null` | Сообщение, на которое отвечаем. |
| `attachments` | `object` | `{}` | Вложения: объект, ключи — `document_id` из `[message]: get upload attach url`. |
| `sticker_document_id` | `UUIDv7 \| null` | `null` | Документ стикера — стикер-сообщение (id из `[sticker]: save sticker`, см. [stickers.md](./stickers.md)). |

При переданном `sticker_document_id` `text` и `attachments` могут быть пустыми —
стикер считается содержимым сообщения. Стикер должен входить в пак, видимый
отправителю (публичный либо свой), иначе `STICKER_NOT_FOUND` (122015).
Такое сообщение приходит получателям с полями `sticker_document_id`,
`sticker_pak_id` и `sticker` (см. [Message](../../objects/message.md)).

Каждое вложение в `attachments` обязано пройти `[message]: save attach` —
иначе `send` отвечает `DOCUMENT_NOT_PROCESSED` (122016). Порядок полного
цикла — в [руководстве по файлам](../../guides/upload.md).

Отправленное сообщение наследует `is_commenting` от канала — так комментирование
включается под постом автоматически. Дальше флаг меняется отдельно, через
`[comment]: update post commenting`.

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
выдаётся **только оригинал** — производные ассеты создаст сервер на следующем
шаге), затем вызовите `[message]: save attach`. Полное описание процесса — в
[руководстве по файлам](../../guides/upload.md).

## `[message]: save attach` — сохранить загруженное вложение

```json
{ "document_id": "UUIDv7" }
```

Вызывается после загрузки оригинала и **до** `send`. Сервер проверяет оригинал
в хранилище (наличие и фактический размер), генерирует производные ассеты и
отвечает «готово». Ожидание обработки может занять до ~100 секунд — таймаут
запроса должен быть **не меньше 120 секунд**. Повторный вызов с тем же
`document_id` идемпотентен: уже обработанный файл отвечает сразу — повторяйте
спокойно при сетевом таймауте. Ответ:

```json
{ "document_id": "UUIDv7", "status": "ready" }
```

Если производные ассеты (превью, метадата) создать не удалось, ответ
дополнительно содержит `"processed": false` — это не ошибка: отправляйте
сообщение как обычно, вложение отобразится документом для скачивания
(без превью):

```json
{ "document_id": "UUIDv7", "status": "ready", "processed": false, "reason": "failed" }
```

- `reason: "failed"` — обработка файла не удалась; вложение отправляется
  без превью (можно показать пользователю уведомление).
- отсутствие `reason` — серверная обработка временно отключена;
  вложение тоже уходит без превью, молча.

Пока вложение не сохранено, `send` с ним отвечает `DOCUMENT_NOT_PROCESSED`
(122016). Ошибки (блоки сообщения / комментария — 136100 / 136200):

- `DOCUMENT_NOT_FOUND` (`136100`) — запись загрузки не найдена (истёк срок).
- `MEDIA_PROCESSING_FAILED` (`136101`) — обработка файла не уложилась во
  времени; повторите вызов — ожидающий файл дождётся результата.
- `OBJECT_NOT_UPLOADED` (`136102`) — оригинал не загружен в хранилище.
- `UPLOAD_SIZE_MISMATCH` (`136103`) — фактический размер не совпал с заявленным.
- `DOCUMENT_ID_REQUIRED` / `DOCUMENT_ID_INVALID` (`136104` / `136105`).
- `ACCESS_DENIED` (`136106`) — чужая загрузка или нет прав на публикацию.

## `[message]: get data` — одно сообщение

```json
{ "message_id": "UUIDv7" }
```

Ответ — объект [Message](../../objects/message.md), включая поле `reactions`.

## `[message]: get history` — история сообщений

```json
{
  "channel_id": "UUIDv7",
  "after_last_viewed_message": false,
  "direction": "prev",
  "cursor_id": null,
  "offset": 35
}
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `after_last_viewed_message` | `boolean` | `false` | Только сообщения не старше последнего просмотренного. |
| `direction` | `string \| null` | `null` | `"prev"` / `"next"` (см. [пагинация](../README.md#пагинация-списков)). |
| `cursor_id` | `UUIDv7 \| null` | `null` | Курсор. |
| `offset` | `int` | `35` | Размер порции, диапазон 1–100. |

Ответ — массив объектов [Message](../../objects/message.md) (включая `count_comments`
и `is_commenting`).

## `[message]: update` — редактирование

```json
{ "message_id": "UUIDv7", "text": "Новый текст" }
```

Ответ — пустой (`data: null`).

## `[message]: remove` — удаление

```json
{ "message_id": "UUIDv7", "for_all": false }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `for_all` | `boolean` | `false` | Удалить для всех участников. |

Ответ — пустой.

## `[message]: clear history` — очистка истории

```json
{ "channel_id": "UUIDv7", "for_all": false }
```

Ответ — пустой.

## `[message]: forward` — пересылка

```json
{ "message_id": "UUIDv7", "channel_ids": ["UUIDv7", "..."] }
```

Ответ — пустой.

## `[message]: send reaction` — поставить/снять реакцию

```json
{ "message_id": "UUIDv7", "reaction": "🔥" }
```

- Список доступных реакций: `👍` `👎` `❤️` `🔥` `🎉` `🤩` `😱` `😁` `😢` `💩` `🤮` `🥰` `🤯` `🤔` `🤬` `👏`
- Повторная отправка той же реакции снимает её; отправка другой реакции заменяет предыдущую.

Ответ — массив [Reaction](../../objects/reaction.md) для сообщения (актуальное состояние).

## `[message]: get reactions` — реакции сообщений

```json
{ "message_ids": ["UUIDv7", "..."] }
```

Ответ — объект, ключи — `message_id`, значения — массивы [Reaction](../../objects/reaction.md):

```json
{
  "0191...1": [ { "reaction": "🔥", "avatars": [], "count": 1, "is_selected": true } ],
  "0191...2": []
}
```

## `[message]: click button` — нажатие кнопки в сообщении бота

```json
{ "bot_id": "UUIDv7", "channel_id": "UUIDv7", "message_id": "UUIDv7", "button_id": "button-1", "state": null }
```

Событие пересылается сервером боту (в его сокет).
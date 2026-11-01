# comments — комментарии

События раздела `[comment]`. Основной объект: [Comment](../../objects/comment.md).

Комментарии существуют только под постами сообществ (канал `type = 3`).
В отличие от сообщений у комментариев **нет PTS** — порядок задаётся `id`
(все id — `UUIDv7`, то есть монотонно возрастают по времени).

## Когда можно комментировать

Комментировать (`[comment]: send`, `[comment]: get upload attach url`) можно, если
одновременно выполнены **оба** условия:

1. `channels.is_commenting = true` — комментирование включено в сообществе;
2. `messages.is_commenting = true` — комментирование включено под этим постом.

`messages.is_commenting` наследуется от канала в момент отправки поста
([`[message]: send`](./messages.md)), а дальше меняется событием
[`[comment]: update post commenting`](#comment-update-post-commenting).

Дополнительно требуется подписка на сообщество; владелец сообщества может
комментировать без подписки.

**Чтение комментариев не проверяет эти флаги.** Выключенные комментарии должны
оставаться читаемыми, поэтому `[comment]: get history` и `[comment]: get data`
проверяют только доступ к каналу.

| Ошибка | Когда |
| --- | --- |
| `COMMENTING_DISABLED_IN_CHANNEL` (`132001`) | Выключено в сообществе. |
| `COMMENTING_DISABLED_IN_POST` (`132002`) | Выключено под постом. |
| `SUBSCRIPTION_REQUIRED` (`132010`) | Нет подписки на сообщество. |
| `ACCESS_DENIED` (`132000`) | Нет доступа к каналу. |

## `[comment]: open` — открытие формы комментариев

```json
{
  "entity_id": "UUIDv7",
  "entity_type": "message"
}
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `entity_id` | `UUIDv7` | — | Id поста. |
| `entity_type` | `string` | — | Тип сущности (`"message"`). |

Вызывается при открытии формы комментариев. Побочные эффекты:

1. создаётся запись о читателе ветки (если её ещё нет) — позиция возврата
   заводится заранее, чтобы при следующем открытии форма открылась на месте;
2. соединение подписывается на обновления канала поста.

Флаги `is_commenting` при открытии **не проверяются**: форма с выключенным
комментированием открывается на чтение.

Ответ:

```json
{
  "message": { "…": "Message" },
  "last_viewed_comment_id": "UUIDv7 | null",
  "is_commenting_allowed": true
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `message` | [Message](../../objects/message.md) | Пост, под которым открыта ветка (автор, текст, вложения, счётчик комментариев). |
| `last_viewed_comment_id` | `UUIDv7 \| null` | Сохранённая позиция возврата (`null` — читать ещё не начинали). По нему клиент ставит разделитель «Новые комментарии». |
| `is_commenting_allowed` | `boolean` | Можно ли писать в ветку: комментирование включено и в сообществе, и под этим постом. `false` — форма открывается на чтение, поле ввода скрыто. |

| Ошибка | Когда |
| --- | --- |
| `SUBSCRIPTION_REQUIRED` (`132010`) | Нет подписки на сообщество (и пользователь не владелец). |
| `ENTITY_NOT_FOUND` (`132801`) | Пост не найден или удалён. |

## `[comment]: send` — отправка комментария

```json
{
  "entity_id": "UUIDv7",
  "entity_type": "message",
  "text": "Красивое фото!",
  "reply_to_comment_id": null,
  "attachments": { "UUIDv7": { "file_name": "photo.jpg" } }
}
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `entity_id` | `UUIDv7` | — | Id поста. |
| `entity_type` | `string` | — | Тип сущности. Сейчас поддерживается только `"message"`. |
| `text` | `string` | — | Текст комментария (HTML-экранируется сервером). |
| `reply_to_comment_id` | `UUIDv7 \| null` | `null` | Комментарий, на который отвечаем. |
| `attachments` | `object \| null` | `null` | Вложения: объект, ключи — `document_id` из `[comment]: get upload attach url` (контракт единообразен с `[message]: send`). |

- Хотя бы одно из полей `text` / `attachments` должно быть заполнено, иначе
  `TEXT_OR_ATTACHMENTS_REQUIRED` (`131010`).
- Каждое вложение в `attachments` обязано пройти `[comment]: save attach` —
  иначе `send` отвечает `DOCUMENT_NOT_PROCESSED` (`131012`).
- Веток нет: если `reply_to_comment_id` ссылается на комментарий **другого** поста —
  `REPLY_TO_COMMENT_MISMATCH` (`131008`); на несуществующий/удалённый —
  `REPLY_TO_COMMENT_NOT_FOUND` (`131009`).
- Ответы не наследуют `reply_to_comment_id` ответа: ответ на ответ допускается,
  но в интерфейсе показывается только один уровень.

Ответ: `{ "comment_id": "UUIDv7" }`.

Событие рассылается участникам сообщества как `[comment]: new`
(см. [server-to-client/comments.md](../server-to-client/comments.md)).

## `[comment]: get upload attach url` — ссылка для загрузки вложения

```json
{
  "entity_id": "UUIDv7",
  "entity_type": "message",
  "file_name": "photo.jpg",
  "mime_type": "image/jpeg",
  "size": 102400,
  "metadata": null
}
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `entity_id` | `UUIDv7` | — | Id поста. |
| `entity_type` | `string` | — | Тип сущности (`"message"`). |
| `file_name` | `string` | — | Оригинальное имя файла (по нему определяется расширение). |
| `mime_type` | `string` | — | MIME-тип; сверяется с расширением. |
| `size` | `number` | — | Размер файла в байтах. |
| `metadata` | `object \| null` | `null` | Флаги файла, например `{ "flags": { "is_audio_note": true } }` для голосового. Производные ассеты (превью, LQIP, цвета) создаёт сервер — в `metadata` они не нужны. |

Ответ — цели загрузки:

```json
{
  "targets": [...],
  "document_id": "UUIDv7"
}
```

Лимиты (размер файла, число вложений, длина имени, справочник типов файлов)
клиент получает при авторизации — поле `limits` в ответе
[`POST /auth/check`](../../http/auth.md).

Загрузите каждую цель `POST`-ом по её `url` (для вложений выдаётся **только
оригинал**), затем вызовите `[comment]: save attach`. Описание процесса — в
[руководстве по файлам](../../guides/upload.md).

Права на загрузку те же, что и на отправку (проверяются оба флага
`is_commenting` и подписка).

## `[comment]: save attach` — сохранить загруженное вложение

```json
{ "document_id": "UUIDv7" }
```

Вызывается после загрузки оригинала и **до** `[comment]: send`. Сервер
проверяет оригинал в хранилище (наличие и фактический размер), генерирует
производные ассеты и отвечает «готово». Ожидание обработки может занять до
~100 секунд — таймаут запроса должен быть **не меньше 120 секунд**. Повторный
вызов идемпотентен: уже обработанный файл отвечает сразу. Ответ:

```json
{ "document_id": "UUIDv7", "status": "ready" }
```

При несозданных производных ассетах ответ дополнительно содержит
`"processed": false` (опционально с `reason: "failed"`) — отправляйте
комментарий как обычно, вложение отобразится документом для скачивания;
подробности — в [messages.md](./messages.md).

Формат идентичен `[message]: save attach` (см.
[messages.md](./messages.md)), отличаются только коды ошибок — блок
комментариев 136200–136299: `DOCUMENT_NOT_FOUND` (`136200`),
`MEDIA_PROCESSING_FAILED` (`136201`), `OBJECT_NOT_UPLOADED` (`136202`),
`UPLOAD_SIZE_MISMATCH` (`136203`), `DOCUMENT_ID_REQUIRED` /
`DOCUMENT_ID_INVALID` (`136204` / `136205`), `ACCESS_DENIED` (`136206`).

## `[comment]: get history` — комментарии поста

```json
{
  "entity_id": "UUIDv7",
  "entity_type": "message",
  "after_last_viewed_comment": true,
  "direction": null,
  "cursor_id": null,
  "offset": 35
}
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `entity_id` | `UUIDv7` | — | Id поста. |
| `entity_type` | `string` | — | Тип сущности (`"message"`). |
| `after_last_viewed_comment` | `boolean` | `false` | Опора на сохранённую позицию возврата. |
| `direction` | `string \| null` | `null` | `"prev"` / `"next"` (см. [пагинация](../README.md#пагинация-списков)). |
| `cursor_id` | `UUIDv7 \| null` | `null` | Курсор. |
| `offset` | `int` | `35` | Размер порции, диапазон 1–100. |

Ответ — **объект**, а не массив:

```json
{
  "entity_id": "UUIDv7",
  "entity_type": "message",
  "last_viewed_comment_id": "UUIDv7 | null",
  "first_comment_id": "UUIDv7 | null",
  "last_comment_id": "UUIDv7 | null",
  "comments": [ { "…": "Comment" } ]
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `last_viewed_comment_id` | `UUIDv7 \| null` | Позиция возврата пользователя (из `comments_members`). |
| `first_comment_id` | `UUIDv7 \| null` | Самый старый комментарий ветки. |
| `last_comment_id` | `UUIDv7 \| null` | Самый свежий комментарий ветки. |
| `comments` | [Comment](../../objects/comment.md)[] | Комментарии страницы, по `id` по возрастанию. |

Порядок `comments` в ответе зависит от `direction`: `prev` — по убыванию `id`
(свежие впереди), иначе — по возрастанию. Клиенту рекомендуется отсортировать
полученную страницу по `id` по возрастанию перед вставкой в ленту. Комментарии
в ответе уже включают `reactions`, `attachments` и `reply_to_comment`.

### `after_last_viewed_comment`

Если `true` и `cursor_id` не передан, сервер:

1. берёт порцию комментариев не старше `comments_members.last_viewed_comment_id`
   (если позиции нет — от начала ветки);
2. если новых комментариев оказалось меньше `offset`, добирает более старые —
   иначе форма открылась бы почти пустой.

Клиенту `last_viewed_comment_id` нужен, чтобы поставить маркер «вы не читали
с этого места» между комментариями.

## `[comment]: get data` — один комментарий

```json
{ "comment_id": "UUIDv7" }
```

Ответ — объект [Comment](../../objects/comment.md). Глобально удалённый комментарий
(`is_deleted = true`) считается отсутствующим: `COMMENT_NOT_FOUND` (`131200`).

## `[comment]: update` — редактирование

```json
{ "comment_id": "UUIDv7", "text": "Новый текст" }
```

Редактировать может только автор комментария, иначе `ACCESS_DENIED` (`132100`).
Вложения при редактировании не меняются.

Ответ — пустой (`data: null`). Рассылается как `[comment]: update`.

## `[comment]: remove` — удаление

```json
{ "comment_id": "UUIDv7" }
```

Удалить комментарий может (по убыванию приоритета):

1. автор комментария;
2. автор поста;
3. владелец сообщества;
4. модератор сообщества с правом `can_deleted_message`.

Иначе `ACCESS_DENIED` (`132200`). Удаление **глобальное** (`is_deleted = true`),
у пользователей нет личной корзины удалённых комментариев.

Ответ — пустой. Рассылается как `[comment]: remove`.

## `[comment]: send reaction` — поставить/снять реакцию

```json
{ "comment_id": "UUIDv7", "reaction": "🔥" }
```

- Список доступных реакций: `👍` `👎` `❤️` `🔥` `🎉` `🤩` `😱` `😁` `😢` `💩` `🤮` `🥰` `🤯` `🤔` `🤬` `👏`
- Повторная отправка той же реакции снимает её; отправка другой реакции заменяет предыдущую.
- Реакция не эмитится в комнату — чужие реакции клиент догоняет
  `[comment]: get reactions` для видимых комментариев (так же, как в сообщениях).

Ответ — массив [Reaction](../../objects/reaction.md) для комментария
(актуальное состояние).

## `[comment]: get reactions` — реакции нескольких комментариев

```json
{ "comment_ids": ["UUIDv7", "..."] }
```

Ответ — объект, ключи — `comment_id`, значения — массивы [Reaction](../../objects/reaction.md):

```json
{
  "0191...1": [ { "reaction": "🔥", "avatars": [], "count": 1, "is_selected": true } ],
  "0191...2": []
}
```

## `[comment]: update post commenting` — включить/выключить комментарии под постом

```json
{ "message_id": "UUIDv7", "is_commenting": false }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `message_id` | `UUIDv7` | — | Пост. |
| `is_commenting` | `boolean` | — | Новое значение флага. |

Переключить может автор поста, владелец сообщества или модератор, иначе
`ACCESS_DENIED` (`131800`). Если сообщество само выключило комментирование
(`channels.is_commenting = false`) — `COMMENTING_DISABLED_IN_CHANNEL` (`131801`).

Ответ — пустой. Рассылается как `[comment]: update post commenting`
(см. [server-to-client/comments.md](../server-to-client/comments.md)).

Событие живёт в домене `comments`, а не `messages`: в диапазоне кодов ошибок
`messages` (122xxx) для него не было свободного места, а домен `comments`
отведён под эту фичу целиком.

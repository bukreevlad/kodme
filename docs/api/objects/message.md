# Message — сообщение

Сообщение в любом канале.

```json
{
  "id": "UUIDv7",
  "random_id": "UUIDv7",
  "channel_id": "UUIDv7",
  "author_id": "UUIDv7",
  "created_at": "2026-09-21T12:34:56.789Z",
  "edited_at": null,
  "text": "Привет!",
  "reply_to_message_id": null,
  "forwarded_to_message_id": null,
  "buttons": null,
  "entities": null,
  "action_type": null,
  "action_payload": null,
  "is_bot": false,
  "channel_kind": "channel",
  "is_moderator": false,
  "is_commenting": true,
  "count_comments": 3,
  "display_name": "Мой канал",
  "avatar": null,
  "attachments": [],
  "sticker_document_id": null,
  "sticker_pak_id": null,
  "sticker": null,
  "reactions": []
}
```

## Поля

| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | `UUIDv7` | Id сообщения. |
| `random_id` | `UUIDv7 \| null` | Клиентский ключ идемпотентности (у сообщений, отправленных без него, — `null`). Позволяет сопоставить своё локальное сообщение с пришедшим из событий. |
| `channel_id` | `UUIDv7` | Канал. |
| `author_id` | `UUIDv7` | Автор сообщения. |
| `author_is_blocked` | `boolean` | Забанен ли автор в канале модерацией. |
| `created_at` | `ISO 8601` | Дата отправки. |
| `edited_at` | `ISO 8601 \| null` | Дата редактирования. |
| `text` | `string` | Текст (HTML-экранирован сервером). |
| `reply_to_message_id` | `UUIDv7 \| null` | На какой ответ. |
| `reply_to_message` | [Message](./message.md) \| `null` | Объект ответа (при `reply_to_message_id`). |
| `forwarded_to_message_id` | `UUIDv7 \| null` | Что переслано. |
| `forwarded_message` | `object \| null` | Информация о пересланном (см. ниже). |
| `buttons` | `array \| string \| null` | Кнопки (для бота). |
| `entities` | `array \| null` | Форматирование текста. |
| `action_type` | `string \| null` | Тип системного сообщения (см. ниже). |
| `action_payload` | `object \| null` | Данные системного сообщения. |
| `is_bot` | `boolean` | Автор — бот. |
| `channel_kind` | `string` | Вид канала (см. [Channel](./channel.md)). |
| `is_moderator` | `boolean` | Автор — модератор канала. |
| `is_commenting` | `boolean \| null` | Личный флаг комментирования поста: `null` — пост наследует `channels.is_commenting`, `false` — комментарии под постом выключены отдельно, `true` — включены отдельно (меняется через `[comment]: update post commenting`). Эффективно комментировать можно, когда `channels.is_commenting && is_commenting !== false`. |
| `count_comments` | `int` | Кол-во комментариев под постом. Считается на лету при загрузке сообщений; для каналов с `channel_kind ≠ "channel"` всегда `0`. Обновляется событиями `[comment]: new` / `[comment]: remove`. |
| `display_name` | `string` | Отображаемое имя автора. |
| `avatar` | [File](./file.md) \| `null` | Аватар автора (для канала `channel_kind: "channel"` — аватар канала). |
| `attachments` | [File](./file.md)[] | Вложения. |
| `sticker_document_id` | `UUIDv7 \| null` | Документ стикера (sticker-сообщение, см. [stickers.md](../websocket/client-to-server/stickers.md)). |
| `sticker_pak_id` | `UUIDv7 \| null` | Набор, которому принадлежит стикер (sticker-сообщение, см. [StickerPak](./stickerpak.md)); `null` — набор не найден или удалён. Набор может быть недоступен пользователю — доступность проверяется запросом `[sticker]: get pak`. |
| `sticker` | `string \| null` | Токен на чтение файла стикера (query `?token=…` ссылки хранилища). |
| `reactions` | [Reaction](./reaction.md)[] | Реакции (только в `[message]: get data`). |

## Пересланное сообщение (`forwarded_message`)

- Для диалогов, групп, тем, избранного, чатов: `{ channel_kind, avatar_link, user_id | bot_id, display_name }`.
- Для каналов (`channel_kind: "channel"`): `{ channel_kind, avatar_link, channel_id, display_name }`.

## Системные сообщения (`action_type`)

| `action_type` | Описание |
| --- | --- |
| `USER_JOINED_GROUP` | Участник вступил в группу (`action_payload: { user_name, user_id, is_bot }`). |
| `USER_LEFT_GROUP` | Участник покинул группу (`action_payload: { user_name, user_id, is_bot }`). |
| `USER_RENAMED_GROUP` | Группа переименована (`action_payload: { user_name, user_id, is_bot, group_name }`). |
| `USER_ROLE_CHANGED_TO_MODERATOR_IN_GROUP` | Назначен модератор (`action_payload: { user_name, user_id, is_bot }`). |
| `CALL` | Звонок в диалоге 1-1. Одно сообщение на звонок: `action_payload: { call_id, status, user_id, display_name, started_at, accepted_at, ended_at, duration }`; `status` — `"ringing"` (идёт вызов) → `"missed"` (не ответили), `"declined"` (отклонили), `"canceled"` (инициатор сбросил до ответа) или `"finished"` (разговор состоялся, `duration` — длительность в секундах). Статус обновляется по ходу звонка — сообщение приходит событием `message_edit`. |
| `BROADCAST_STARTED` | Трансляция началась (`action_payload: { cast_id }`). |
| `BROADCAST_ENDED` | Трансляция завершилась (`action_payload: { cast_id, started_at, ended_at }`). |

## Примечания

- Голосовое сообщение определяется по вложению (`audio/*` с `metadata.flags.is_audio_note`),
  отдельного поля `is_voice` у сообщения нет.
- Позиция сообщения в канале (`pts`) — у событий ленты канала, а не у сообщения:
  изменения сообщений приходят событием `[channel]: feed` (см.
  [синхронизацию](../websocket/server-to-client/channels.md)).

## Комментарии

Комментарии есть только у постов в сообществах (`channel_kind = "channel"`). Ветка
комментария открывается по `entity_id` = `Message.id`, список — через
`[comment]: get history`, состав ветки — в объекте [Comment](./comment.md).
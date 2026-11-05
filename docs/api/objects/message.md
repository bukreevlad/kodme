# Message — сообщение

Сообщение в любом канале.

```json
{
  "id": "UUIDv7",
  "channel_id": "UUIDv7",
  "created_user_id": "UUIDv7",
  "created_at": "2026-09-21T12:34:56.789Z",
  "edited_at": null,
  "text": "Привет!",
  "reply_to_message_id": null,
  "forwarded_to_message_id": null,
  "buttons": null,
  "entities": null,
  "pts": 123,
  "action_type": null,
  "action_payload": null,
  "is_bot": false,
  "channel_type": 1,
  "is_moderator": false,
  "is_commenting": true,
  "count_comments": 3,
  "display_name": "Иван Петров",
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
| `channel_id` | `UUIDv7` | Канал. |
| `created_user_id` | `UUIDv7` | Автор. |
| `created_at` | `ISO 8601` | Дата отправки. |
| `edited_at` | `ISO 8601 \| null` | Дата редактирования. |
| `text` | `string` | Текст (HTML-экранирован сервером). |
| `reply_to_message_id` | `UUIDv7 \| null` | На какой ответ. |
| `reply_to_message` | [Message](./message.md) \| `null` | Объект ответа (при `reply_to_message_id`). |
| `forwarded_to_message_id` | `UUIDv7 \| null` | Что переслано. |
| `forwarded_message` | `object \| null` | Информация о пересланном (см. ниже). |
| `buttons` | `array \| string \| null` | Кнопки (для бота). |
| `entities` | `array \| null` | Форматирование текста. |
| `pts` | `int` | Точка сообщений в канале. |
| `action_type` | `string \| null` | Тип системного сообщения (см. ниже). |
| `action_payload` | `object \| null` | Данные системного сообщения. |
| `is_bot` | `boolean` | Автор — бот. |
| `channel_type` | `int` | Тип канала (см. [Channel](./channel.md)). |
| `is_moderator` | `boolean` | Автор — модератор канала. |
| `is_commenting` | `boolean` | Разрешены ли комментарии под этим постом. Наследуется от `channels.is_commenting` при отправке, затем меняется через `[comment]: update post commenting`. Для каналов `type ≠ 3` всегда `false`. |
| `count_comments` | `int` | Кол-во комментариев под постом. Считается на лету при загрузке сообщений; для каналов `type ≠ 3` всегда `0`. Обновляется событиями `[comment]: new` / `[comment]: remove`. |
| `display_name` | `string` | Отображаемое имя автора. |
| `avatar` | [File](./file.md) \| `null` | Аватар автора (для канала типа 3 — аватар канала). |
| `attachments` | [File](./file.md)[] | Вложения. |
| `sticker_document_id` | `UUIDv7 \| null` | Документ стикера (sticker-сообщение, см. [stickers.md](../websocket/client-to-server/stickers.md)). |
| `sticker_pak_id` | `UUIDv7 \| null` | Набор, которому принадлежит стикер (sticker-сообщение, см. [StickerPak](./stickerpak.md)); `null` — набор не найден или удалён. Набор может быть недоступен пользователю — доступность проверяется запросом `[sticker]: get pak`. |
| `sticker` | `string \| null` | Токен на чтение файла стикера (query `?token=…` ссылки хранилища). |
| `reactions` | [Reaction](./reaction.md)[] | Реакции (только в `[message]: get data`). |

## Пересланное сообщение (`forwarded_message`)

- Для диалогов, групп, тем, избранного, чатов: `{ channel_type, avatar_link, user_id | bot_id, display_name }`.
- Для каналов (тип 3): `{ channel_type, avatar_link, channel_id, display_name }`.

## Системные сообщения (`action_type`)

| `action_type` | Описание |
| --- | --- |
| `USER_JOINED_GROUP` | Участник вступил в группу (`action_payload: { user_name, user_id, is_bot }`). |
| `USER_LEFT_GROUP` | Участник покинул группу (`action_payload: { user_name, user_id, is_bot }`). |
| `USER_RENAMED_GROUP` | Группа переименована (`action_payload: { user_name, user_id, is_bot, group_name }`). |
| `USER_ROLE_CHANGED_TO_MODERATOR_IN_GROUP` | Назначен модератор (`action_payload: { user_name, user_id, is_bot }`). |
| `BROADCAST_STARTED` | Трансляция началась (`action_payload: { cast_id }`). |
| `BROADCAST_ENDED` | Трансляция завершилась (`action_payload: { cast_id, started_at, ended_at }`). |

## Примечания

- Голосовое сообщение определяется по вложению (`audio/*` с `metadata.flags.is_audio_note`),
  отдельного поля `is_voice` у сообщения нет.

## Комментарии

Комментарии есть только у постов в сообществах (`channel_type = 3`). Ветка
комментария открывается по `entity_id` = `Message.id`, список — через
`[comment]: get history`, состав ветки — в объекте [Comment](./comment.md).
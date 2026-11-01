# Comment — комментарий

Комментарий под постом сообщества (канал `type = 3`).

```json
{
  "id": "UUIDv7",
  "entity_id": "UUIDv7",
  "entity_type": "message",
  "created_user_id": "UUIDv7",
  "text": "Красивое фото!",
  "reply_to_comment_id": null,
  "created_at": "2026-09-21T12:34:56.789Z",
  "edited_at": null,
  "channel_id": "UUIDv7",
  "channel_type": 3,
  "is_moderator": false,
  "display_name": "Иван Петров",
  "avatar": null,
  "reactions": [],
  "reply_to_comment": null,
  "attachments": []
}
```

## Поля

| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | `UUIDv7` | Id комментария. |
| `entity_id` | `UUIDv7` | Id поста (сообщения), под которым написан комментарий. |
| `entity_type` | `string` | Всегда `"message"`. |
| `created_user_id` | `UUIDv7` | Автор комментария. |
| `text` | `string` | Текст (HTML-экранирован сервером). Может быть пустым, если есть вложения. |
| `reply_to_comment_id` | `UUIDv7 \| null` | Комментарий, на который отвечают. |
| `reply_to_comment` | [Comment](./comment.md) \| `null` | Объект ответа. Разворачивается только на один уровень. |
| `created_at` | `ISO 8601` | Дата отправки. |
| `edited_at` | `ISO 8601 \| null` | Дата редактирования. |
| `channel_id` | `UUIDv7` | Канал, в котором лежит пост (из [Message](./message.md)). |
| `channel_type` | `int` | Тип канала, для комментариев всегда `3`. |
| `is_moderator` | `boolean` | Автор — модератор сообщества. |
| `display_name` | `string` | Отображаемое имя автора. |
| `avatar` | [File](./file.md) \| `null` | Аватар автора. |
| `reactions` | [Reaction](./reaction.md)[] | Реакции (заполняется всегда — и в `[comment]: get history`, и в `[comment]: get data`). |
| `attachments` | [File](./file.md)[] | Вложения комментария. |

## Ответы — плоские

Ответ на комментарий — это отдельный комментарий с `reply_to_comment_id`. Веток
(комментарий на ответ на ответ) нет: клиент показывает максимум один уровень
«в ответ на», а сервер при отправке ответа ссылается только на исходный комментарий.

## Счётчик

Количество комментариев под постом **не хранится** в сообщении — оно считается
на лету при загрузке сообщений и приходит полем
[`Message.count_comments`](./message.md). Актуальное состояние поддерживается
событиями `[comment]: new` / `[comment]: remove`
(см. [server-to-client/comments.md](../websocket/server-to-client/comments.md)).

## Вложения

Вложения комментария хранятся с `attachments.entity_type = "comment"` и
`attachments.entity_id = <comment_id>`, поэтому у разных комментариев одного
поста могут быть разные файлы.

# server-to-client: сообщения

События раздела `[message]`. Данные — объект [Message (meta)](../../objects/message.md).

## `[message]: new` — новое сообщение

```json
{
  "type": "event",
  "event": "[message]: new",
  "data": { "…": "Message (meta) + user_socket_id" },
  "timestamp": "2026-09-21T12:34:56.789Z"
}
```

- Для каналов `тип 2, 3, 4, 6, 7` — всем участникам в комнату `channel::<channel_id>`.
- Для диалогов, избранного и диалогов с ботами (`тип 1, 5, 8`) — каждому участнику
  в его комнату `user::<user_id>`.
- Ботам канала — в комнату `bot::<bot_id>` (в `data` добавляется `user_socket_id` —
  id соединения отправителя). Описание для разработчика бота — в
  [bots-to-server](../bots-to-server/messages.md).
- Для чата трансляции (`тип 7`) — дополнительно в комнату `cast_online_chat::<channel_id>`.

## `[message]: update` — изменение сообщения

Данные — объект [Message (meta)](../../objects/message.md). Доставка — как у
`[message]: new` (без `cast_online_chat::`).

## `[message]: remove` — удаление сообщения

```json
{ "channel_id": "UUIDv7", "message_id": "UUIDv7", "pts": 123 }
```

Доставка — как у `[message]: new`.

## `[message]: clear history` — очистка истории

```json
{ "channel_id": "UUIDv7" }
```

- Для каналов `тип 2, 3, 4, 6, 7` — в `channel::<channel_id>`.
- Для диалогов, избранного, диалогов с ботами (`тип 1, 5, 8`) — в `user::` участников.
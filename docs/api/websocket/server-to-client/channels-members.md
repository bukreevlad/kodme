# server-to-client: участники каналов

События раздела `[channel-member]`.

## `[channel-member]: typing status` — статус набора

```json
{
  "channel_id": "UUIDv7",
  "action": "typing",
  "user_id": "UUIDv7",
  "display_name": "Иван Петров"
}
```

`action` — значение, переданное отправителем в `[channel-member]: typing status`.
В диалоге (`тип 1`) — только собеседнику в `user::<user_id>`; в остальных каналах —
всем участникам в `channel::<channel_id>`.

## `[channel-member]: update last viewed message` — отметка прочтения

```json
{ "channel_id": "UUIDv7", "message_id": "UUIDv7" }
```

Доставляется самому пользователю во все его соединения (`user::<user_id>`).

## `[channel-member]: update participant viewed message` — собеседник прочитал

```json
{ "user_id": "UUIDv7", "channel_id": "UUIDv7", "message_id": "UUIDv7" }
```

Доставляется только в диалогах (`тип 1`) собеседнику в `user::<user_id>`.
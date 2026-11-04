# server-to-client: секретные чаты

Push-события раздела `[secret-chat]`. Две категории доставки:

- **устройству** (`target_device_id`) — сигнальные события, адресованные
  конкретному устройству участника;
- **подписчикам присутствия** — `[secret-chat]: presence` доставляется
  соединениям, подписанным на присутствие пользователя
  (см. [secret-chats.md](../client-to-server/secret-chats.md)).

> Push-события секретных **звонков** — в [secret-calls.md](./secret-calls.md).

## `[secret-chat]: incoming` — приглашение в секретный чат

```json
{
  "chat_id": "UUIDv7",
  "from_user_id": "UUIDv7",
  "from_device_id": "UUIDv7",
  "identity_key": "base64url",
  "ephemeral_key": "base64url",
  "self_destruct": "5s"
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `chat_id` | `string` | Id нового чата. |
| `from_user_id` | `string` | Инициатор. |
| `from_device_id` | `string` | Устройство инициатора (session_id) — на него отправляются `accept`/`decline`. |
| `identity_key` | `string` | Публичный ключ идентичности инициатора (SPKI, base64url). |
| `ephemeral_key` | `string` | Одноразовый публичный ключ инициатора (SPKI, base64url). |
| `self_destruct` | `string \| null` | Таймер самоуничтожения сообщений чата. |

Приглашение приходит **на все онлайн-устройства** получателя: каждое
показывает экран входящего приглашения, пользователь выбирает устройство
кнопкой «Принять» (`accept`) или отклоняет (`decline`). Чат привязывается
к принявшему устройству; остальным инициатор шлёт
[`[secret-chat]: declined`](#secret-chat-declined--приглашение-закрыто)
(`reason: "taken"`).

## `[secret-chat]: accepted` — чат принят

```json
{
  "chat_id": "UUIDv7",
  "from_user_id": "UUIDv7",
  "from_device_id": "UUIDv7",
  "identity_key": "base64url",
  "ephemeral_key": "base64url"
}
```

Ответная сторона handshake: по полученным ключам оба устройства вычисляют
ключ соединения и обмениваются сигналами `[secret-chat]: signal`.

## `[secret-chat]: signal` — WebRTC-сигнал (SDP/ICE)

```json
{
  "chat_id": "UUIDv7",
  "from_user_id": "UUIDv7",
  "from_device_id": "UUIDv7",
  "type": "answer",
  "sdp": "v=0…",
  "candidate": null
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `type` | `string` | `"offer"` \| `"answer"` \| `"candidate"` \| `"hangup"` \| `"rekey"`. |
| `sdp` | `string \| null` | SDP (для `offer`/`answer`). |
| `candidate` | `string \| null` | ICE-кандидат, JSON-строка (для `candidate`). |

## `[secret-chat]: closed` — чат удалён собеседником

```json
{ "chat_id": "UUIDv7", "from_user_id": "UUIDv7", "from_device_id": "UUIDv7" }
```

Чат и его история удаляются локально на обоих устройствах. Если чат ещё не
принят (приглашение открыто) — приглашение закрывается как отменённое.

## `[secret-chat]: declined` — приглашение закрыто

```json
{ "chat_id": "UUIDv7", "from_user_id": "UUIDv7", "from_device_id": "UUIDv7", "reason": "taken" }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `from_user_id` | `string` | Кто закрыл приглашение (при `taken`/`timeout` — инициатор). |
| `reason` | `string` | `"declined"` (устройство отклонило) \| `"taken"` (принято на другом устройстве) \| `"cancelled"` (инициатор закрыл чат до принятия) \| `"timeout"` (истекло время ожидания). |

Приходит устройствам, открытым для этого приглашения: экран входящего
приглашения нужно закрыть. Инициатору событие уходит при отказах его
устройств (`reason: "declined"`).

## `[secret-chat]: presence` — присутствие устройства пользователя

```json
{ "user_id": "UUIDv7", "device_id": "UUIDv7", "status": "online" }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `device_id` | `string` | Устройство пользователя (session_id). |
| `status` | `string` | `"online"` \| `"offline"`. |

Событие приходит на каждое изменение статуса устройства (после подписки
`[secret-chat]: presence subscribe`, снимок онлайн-устройств — в её ответе).

# server-to-client: звонки

Peer-события раздела `[call]` доставляются на **все активные соединения** участника
диалога, а не через комнаты. Полный сценарий — в [calls.md](../../websocket/client-to-server/calls.md).

## `[call]: incoming` — входящий звонок

```json
{
  "user_id": "UUIDv7",
  "socket_user_id": "…",
  "display_name": "Иван Петров",
  "avatar": null
}
```

- `socket_user_id` — id соединения звонящего; его нужно передавать как
  `participant_socket_id` в ответных событиях `[call]: accept` / `[call]: sdp`.
- `avatar` — id документа аватарки звонящего (может отсутствовать).

## `[call]: accept` — собеседник принял звонок

```json
{ "user_id": "UUIDv7", "socket_user_id": "…" }
```

`socket_user_id` — id соединения принявшего.

## `[call]: decline` — собеседник отклонил

```json
{ "user_id": "UUIDv7" }
```

## `[call]: hangup` — собеседник завершил звонок

```json
{ "user_id": "UUIDv7" }
```

## `[call]: sdp` — SDP/ICE от собеседника

```json
{ "user_id": "UUIDv7", "type": "candidate", "sdp": "…" }
```

`type` — `"offer"` | `"answer"` | `"candidate"`.
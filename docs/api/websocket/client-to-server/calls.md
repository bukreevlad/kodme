# calls — звонки (WebRTC)

События раздела `[call]`. P2P-звонки через WebRTC; сигналинг идёт через WebSocket.
Соединение идентифицируется `socket_user_id` — его вы получаете в push `[call]: incoming`
и передаёте обратно как `participant_socket_id`.

Ice-серверы для WebRTC выдаются сервером в ответе HTTP `POST /api/v1/auth/check` (поле `server_data.web_rtc.ice_servers`).

## `[call]: start` — позвонить пользователю

```json
{ "user_id": "UUIDv7" }
```

`user_id` — кому звоним. Ответ — пустой.

Собеседнику (на все его активные соединения) приходит push `[call]: incoming`:

```json
{
  "user_id": "UUIDv7",
  "socket_user_id": "...",
  "display_name": "Иван Петров",
  "avatar": null
}
```

- `socket_user_id` — идентификатор соединения звонящего (нужен для `[call]: accept`, `[call]: sdp` и т.д.).
- `avatar` — id документа аватарки звонящего (может отсутствовать).

Доступ определяется настройкой приватности `privacy_calls` вызываемого пользователя
(`"all"` — всем, `"contacts"` — только контактам; иначе `ACCESS_DENIED_CALLS_RESTRICTED`).
Если пользователь не найден — `ACCESS_DENIED_USER_NOT_FOUND`.

## `[call]: accept` — принять звонок

```json
{ "participant_socket_id": "...", "answer": "<RTCSessionDescription>" }
```

Ответ — пустой. Звонящий получает push `[call]: accept`:

```json
{ "user_id": "UUIDv7", "socket_user_id": "..." }
```

Если соединения `participant_socket_id` уже нет — ошибка `USER_NOT_IN_NETWORK`.

## `[call]: decline` — отклонить звонок

```json
{ "participant_socket_id": "..." }
```

Ответ — пустой. Звонящий получает push `[call]: decline`:

```json
{ "user_id": "UUIDv7" }
```

## `[call]: hangup` — завершить звонок

```json
{ "participant_socket_id": "..." }
```

Ответ — пустой. Собеседник получает push `[call]: hangup`:

```json
{ "user_id": "UUIDv7" }
```

## `[call]: sdp` — обмен SDP (offer/answer/candidate)

```json
{ "participant_socket_id": "...", "type": "candidate", "sdp": "..." }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `type` | `string` | `"offer"` \\| `"answer"` \\| `"candidate"`. |
| `sdp` | `string` | Тело SDP / ICE-кандидат. |

Ответ — пустой. Собеседник получает push `[call]: sdp`:

```json
{ "user_id": "UUIDv7", "type": "candidate", "sdp": "..." }
```

Типичный сценарий (хост-клиент):

1. `[call]: start` → push `[call]: incoming`.
2. Принятие: `[call]: accept` → push `[call]: accept`; далее обмен `[call]: sdp`
   (`offer` со звонящего, `answer` с принявшего, ICE-`candidate` в обе стороны).
3. Завершение: `[call]: hangup` → push `[call]: hangup`.
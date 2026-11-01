# WebRTC / LiveKit: звонки, конференции

Все медиа-сценарии платформы строятся на WebRTC:

- **Звонки** (`[call]`) — P2P-медиамежду двумя пользователями в диалоге.
- **Конференции** (`[meet]`) — групповое медиа через LiveKit.

## ICE-серверы

Клиент получает ICE-серверы **один раз** из HTTP
`POST /api/v1/auth/check` → `server_data.web_rtc.ice_servers`:

```json
[ { "urls": ["stun:..."], "username": "...", "credential": "..." } ]
```

Серверы генерируются персонально (логин/пароль) и используются во всех
WebRTC-соединениях клиента.

## Звонки (поток)

Соединения участников идентифицируются `socket_user_id` / `participant_socket_id`
(это id websocket-соединения, не пользователя). События — [calls.md](../websocket/client-to-server/calls.md).

```
Звонящий (A)                        Сервер                         Собеседник (B)
    │  [call]: start {user_id}         │                                 │
    │─────────────────────────────────►│  push [call]: incoming          │
    │                                  │  (user_id, socket_user_id,      │
    │                                  │   display_name, avatar) ────────►│
    │  push [call]: accept             │                                 │
    │◄─────────────────────────────────│  [call]: accept                  │
    │                                  │  {participant_socket_id,answer} │
    │  [call]: sdp (offer/candidate)   │                                 │
    │─────────────────────────────────►│  push [call]: sdp ─────────────►│
    │  push [call]: sdp                │                                 │
    │◄─────────────────────────────────│  [call]: sdp (answer/candidate) │
    │            ...медиа P2P...       │                                 │
    │  [call]: hangup                  │                                 │
    │─────────────────────────────────►│  push [call]: hangup ──────────►│
```

- Альтернатива принятию — `[call]: decline` → push `[call]: decline`.
- Если соединение `participant_socket_id` пропало — событие-инициатор вернёт
  `USER_NOT_IN_NETWORK`.
- Приватность: `privacy_calls` собеседника (`"all"` / `"contacts"`).

## Конференции (LiveKit)

События — [meets.md](../websocket/client-to-server/meets.md). Медиаобмен
происходит через LiveKit SDK, отдельное (второе) WebRTC-соединение.

1. `[meet]: create { name, about, is_public, is_chat }` → `{ meet_id }`.
2. `[meet]: open { meet_id }` — клиент подписывается на комнату `meet::<meet_id>`
   и получает объект Meet **+ `token`** (JWT для LiveKit). Остальным участникам
   комнаты — push `[meet]: user enter`.
3. Клиент подключается к LiveKit по `token` (комната LiveKit совпадает с `meet_id`),
   публикует/подписывает треки.
4. `[meet]: close { meet_id }` — отписка от комнаты и push `[meet]: user exit`
   остальным участникам.

Приглашение по ссылке: `[meet]: create invite` → объект [Invite](../objects/invite.md);
вход по приглашению — `[invite]: open`-механика (см. [invites.md](../websocket/client-to-server/invites.md)).
# secret-chats — секретные чаты (WebRTC P2P)

События раздела `[secret-chat]`. Секретный чат «один-на-один» поверх прямого
WebRTC-соединения устройств: сервер участвует только в **сигналинге** (обмен
SDP/ICE и ключами) и **присутствии**. Сообщения, файлы и прочий контент через
сервер не проходят — они шифруются на устройстве отправителя и летят напрямую
собеседнику.

Ключевые свойства:

- чат привязан к **паре устройств**: события адресуются устройству
  (`target_device_id` = session_id устройства собеседника), история живёт
  только на устройствах участников;
- доставка контента — **только при совместном онлайне** (присутствие — ниже);
- ICE-серверы для WebRTC выдаются сервером в ответе HTTP `POST /api/v1/auth/check`
  (поле `server_data.web_rtc.ice_servers`).

> Секретные **звонки** — отдельный раздел [`secret-calls`](./secret-calls.md).

## `[secret-chat]: invite` — приглашение в чат (обмен ключами)

```json
{
  "chat_id": "UUIDv7",
  "target_device_id": "UUIDv7",
  "identity_key": "base64url",
  "ephemeral_key": "base64url",
  "self_destruct": "5s"
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `chat_id` | `string` | Id чата (UUIDv7, генерирует инициатор, одинаков на обоих устройствах). |
| `target_device_id` | `string` | Устройство-получатель (session_id). |
| `identity_key` | `string` | Публичный ключ идентичности отправителя (SPKI, base64url). |
| `ephemeral_key` | `string` | Одноразовый публичный ключ отправителя (SPKI, base64url). |
| `self_destruct` | `string \| null` | Таймер самоуничтожения сообщений: `"5s"` \| `"1m"` \| `"1h"` \| `"1d"` \| `"1w"` \| `null` (выключен). |

Ответ — `{ "delivered": true }`. Устройству собеседника приходит push
[`[secret-chat]: incoming`](../server-to-client/secret-chats.md).

Приглашение рассылается **на все онлайн-устройства собеседника**: каждое
показывает экран входящего приглашения, чат привязывается к устройству,
которое его примет (ответит `accept`). Если приглашение никто не принял за
45 секунд — инициатор снимает его (`decline`, `reason: "timeout"`).

Если устройство собеседника офлайн — ошибка `PEER_OFFLINE`: приглашение не
доставлено, повторите его после появления устройства в сети (presence ниже).

## `[secret-chat]: accept` — принятие чата (ответная сторона handshake)

```json
{
  "chat_id": "UUIDv7",
  "target_device_id": "UUIDv7",
  "identity_key": "base64url",
  "ephemeral_key": "base64url"
}
```

Поля — как в `invite` (без `self_destruct`). Ответ — `{ "delivered": true }`.
Устройству инициатора приходит push
[`[secret-chat]: accepted`](../server-to-client/secret-chats.md). После обмена
`invite`/`accept` устройства сами вычисляют ключ соединения и поднимают
P2P-канал сигналами ниже.

## `[secret-chat]: signal` — WebRTC-сигнал (SDP/ICE)

```json
{
  "chat_id": "UUIDv7",
  "target_device_id": "UUIDv7",
  "type": "candidate",
  "sdp": null,
  "candidate": "{\"candidate\":\"…\"}"
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `type` | `string` | `"offer"` \| `"answer"` \| `"candidate"` \| `"hangup"` \| `"rekey"`. |
| `sdp` | `string \| null` | SDP (для `offer`/`answer`). |
| `candidate` | `string \| null` | ICE-кандидат, JSON-строка (для `candidate`). |

Ответ — `{ "delivered": true }`. Устройству собеседника приходит push
[`[secret-chat]: signal`](../server-to-client/secret-chats.md). Если устройство
собеседника пропало из сети — ошибка `PEER_OFFLINE`.

`rekey` — пересогласование ключа при переподключении (новый `invite`/`accept`
поверх активного чата).

## `[secret-chat]: close` — удаление чата

```json
{ "chat_id": "UUIDv7", "target_device_id": "UUIDv7" }
```

Ответ — `{ "delivered": true }`; если собеседник офлайн — `{ "delivered": false }`
(закрытие засчитано в любом случае: его устройство удалит чат локально при
следующем входе). Устройству собеседника приходит push
[`[secret-chat]: closed`](../server-to-client/secret-chats.md).

## `[secret-chat]: decline` — отказ от приглашения / снятие приглашения

```json
{ "chat_id": "UUIDv7", "target_device_id": "UUIDv7", "reason": "declined" }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `reason` | `string` | `"declined"` (устройство отклонило приглашение) \| `"taken"` (принято на другом устройстве) \| `"cancelled"` (инициатор закрыл чат до принятия) \| `"timeout"` (истекло время ожидания — инициатор снимает приглашение). |

Ответ — `{ "delivered": true }`; если устройство собеседника офлайн —
`{ "delivered": false }` (отказ засчитан и без доставки). Устройству
собеседника приходит push
[`[secret-chat]: declined`](../server-to-client/secret-chats.md).

Используется для закрытия **непринятых** приглашений: отказ устройства,
снятие приглашения после принятия на другом устройстве, отмена и таймаут.
Удаление существующего чата — `close` выше.

## `[secret-chat]: presence subscribe` — подписка на присутствие устройств

```json
{ "user_id": "UUIDv7" }
```

Ответ — снимок онлайн-устройств пользователя:

```json
{ "user_id": "UUIDv7", "devices": ["UUIDv7", "UUIDv7"] }
```

`devices` — session_id устройств, находящихся в сети. После подписки на каждое
изменение приходит push
[`[secret-chat]: presence`](../server-to-client/secret-chats.md).

Присутствие видно только **контактам и собеседникам диалогов** пользователя —
иначе ошибка `ACCESS_DENIED`.

## `[secret-chat]: presence unsubscribe` — отписка от присутствия

```json
{ "user_id": "UUIDv7" }
```

Ответ — `{ "user_id": "UUIDv7" }`.

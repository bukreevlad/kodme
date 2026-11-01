# channels-members — подписки и участники каналов

События раздела `[channel-member]`. Все ответы — пустые (`data: null`).

## `[channel-member]: update last viewed message` — отметка прочтения

```json
{ "message_id": "UUIDv7" }
```

Сервер обновляет последнее просмотренное сообщение в канале этого сообщения.
Другим устройствам пользователя приходит push `[channel-member]: update last viewed message`, собеседнику в диалоге — `[channel-member]: update participant viewed message`.

## `[channel-member]: typing status` — статус набора текста

```json
{ "channel_id": "UUIDv7", "action": "typing" }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `channel_id` | `UUIDv7` | Канал. |
| `action` | `string` | Статус набора (например `"typing"`). |

Другие участники получают push `[channel-member]: typing status` (в диалоге — только собеседник).

## `[channel-member]: subscribe` — подписка на канал

```json
{ "channel_id": "UUIDv7" }
```

Для групп (тип 2) в чат добавляется системное сообщение `USER_JOINED_GROUP`.
Ошибки: `CHANNEL_NOT_FOUND`, `CHANNEL_IS_PRIVATE` для закрытых каналов.

## `[channel-member]: unsubscribe` — отписка

```json
{ "channel_id": "UUIDv7" }
```

Для групп (тип 2) в чат добавляется системное сообщение `USER_LEFT_GROUP`.

## `[channel-member]: subscribe with invite` — вступление по инвайту

```json
{ "channel_id": "UUIDv7", "invite": "invite-link" }
```

`invite` — значение поля `link` объекта [Invite](../../objects/invite.md) (в т.ч. ссылка-приглашение канала). Ошибки: `INVITE_INVALID`, `INVITE_EXPIRED`, `INVITE_MAX_USES_EXHAUSTED`; повторная подписка — без ошибки.

## `[channel-member]: enable notify` / `[channel-member]: disable notify`

Включить/выключить уведомления канала.

```json
{ "channel_id": "UUIDv7" }
```
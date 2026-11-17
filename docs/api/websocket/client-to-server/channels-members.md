# channels-members — подписки и участники каналов

События раздела `[channel-member]`. Все ответы — пустые (`data: null`).

## `[channel-member]: update last viewed message` — отметка прочтения

```json
{ "message_id": "UUIDv7" }
```

Сервер обновляет позицию прочитанного (`last_read_id`) в канале этого сообщения.
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

Подписка делает пользователя участником: создаётся членство и подписка на
уведомления (режим `"all"` по умолчанию). Для групп (`kind: "group"`) в чат
добавляется системное сообщение `USER_JOINED_GROUP`.
Ошибки: `CHANNEL_NOT_FOUND`, `CHANNEL_IS_PRIVATE` для закрытых каналов.

## `[channel-member]: unsubscribe` — отписка

```json
{ "channel_id": "UUIDv7" }
```

Для групп (`kind: "group"`) в чат добавляется системное сообщение `USER_LEFT_GROUP`.

## `[channel-member]: subscribe with invite` — вступление по инвайту

```json
{ "channel_id": "UUIDv7", "invite": "invite-link" }
```

`invite` — значение поля `link` объекта [Invite](../../objects/invite.md) (в т.ч. ссылка-приглашение канала). Ошибки: `INVITE_INVALID`, `INVITE_EXPIRED`, `INVITE_MAX_USES_EXHAUSTED`; повторная подписка — без ошибки.

## `[channel-member]: enable notify` / `[channel-member]: disable notify`

Включить/выключить уведомления канала — установить режим подписки на уведомления
сущности: `enable` → `"all"`, `disable` → `"none"` (значения поля `mode` подписки,
см. [Channel](../../objects/channel.md)). Режим `"mentions"` — уведомления только
по упоминаниям. Доступно только подписчику сущности; без подписки — ошибка
`NOT_SUBSCRIBED`.

```json
{ "channel_id": "UUIDv7" }
```

## `[channel-member]: get members` — список участников

```json
{ "channel_id": "UUIDv7", "direction": "next", "cursor_id": null, "offset": 35 }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `direction` | `"prev" \| "next"` | — | Направление подгрузки; без него — первая страница. |
| `cursor_id` | `UUIDv7` | `null` | Курсор — `id` крайней строки (равен `user_id`). |
| `offset` | `int` | `35` | Размер страницы, диапазон 1–100. |

Ответ — массив участников **и** поле `has_more: boolean`. Элемент — поля
[User](../../objects/user.md) (base) и поля членства:

```json
{ "id": "UUIDv7", "user_id": "UUIDv7", "display_name": "Имя", "link": "username", "avatar": { "…": "File" }, "is_subscribed": true, "is_banned": false, "banned_at": null, "subscribed_at": "2026-09-21T12:34:56.789Z" }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `is_subscribed` | `boolean` | Подписан ли участник на сущность. |
| `is_banned` | `boolean` | Заблокирован ли участник модерацией. |
| `banned_at` | `ISO 8601 \| null` | Когда участник заблокирован. |
| `subscribed_at` | `ISO 8601` | Когда участник подписался. |

`id` равен `user_id` — этим значением клиент оперирует как курсором
пагинации.

Кто видит список:

- сообщество (`kind: "channel"`) — только владелец и модераторы;
- группа (`kind: "group"`), тема (`kind: "topic"`), чат конференции и чат
  трансляции (`kind: "meet_chat"` / `"cast_chat"`) — подписанный участник;
- личные диалоги и избранное — `CHANNEL_TYPE_UNSUPPORTED`.

Участники темы — участники её группы; участники чатов трансляции и
конференции — участники родительской сущности. Ошибки: `ACCESS_DENIED`,
`CHANNEL_NOT_FOUND`, `CHANNEL_TYPE_UNSUPPORTED`.
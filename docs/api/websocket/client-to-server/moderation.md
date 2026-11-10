# moderation — модерация каналов

События раздела `[moderation]`: действия модератора в канале, группе,
теме, чате трансляции и чате конференции. В личных диалогах и избранном
не работают (`CHANNEL_TYPE_UNSUPPORTED`).

Модератор — участник с соответствующим правом в канале; создатель
сущности имеет те же возможности.

## `[moderation]: clean user messages` — удалить все сообщения участника

```json
{ "channel_id": "UUIDv7", "user_id": "UUIDv7" }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `channel_id` | `UUIDv7` | Канал, группа, тема, чат трансляции или чат конференции. |
| `user_id` | `UUIDv7` | Автор, чьи сообщения удаляются. |

Удаляет все сообщения автора в канале. Ответ:

```json
{ "removed": 42, "pts": 123 }
```

`removed` — сколько сообщений удалено, `pts` — новый счётчик состояния
канала (синхронизация остальных устройств). Ошибки: `ACCESS_DENIED`
(нет прав), `CHANNEL_NOT_FOUND`, `CHANNEL_TYPE_UNSUPPORTED`,
`CANNOT_CLEAN_SELF` (нельзя чистить свои сообщения),
`CANNOT_CLEAN_CREATOR`, `CANNOT_CLEAN_MODERATOR`.

## `[moderation]: ban member` — заблокировать участника

```json
{ "channel_id": "UUIDv7", "user_id": "UUIDv7" }
```

«Кик + бан»: подписка участника снимается, он не может писать в канал
и подписаться заново. Ответ — пустой.

Ошибки: `ACCESS_DENIED`, `CHANNEL_NOT_FOUND`, `CHANNEL_TYPE_UNSUPPORTED`,
`CANNOT_BAN_SELF` (нельзя забанить себя), `CANNOT_BAN_CREATOR`,
`CANNOT_BAN_MODERATOR`.

## `[moderation]: unban member` — разблокировать участника

```json
{ "channel_id": "UUIDv7", "user_id": "UUIDv7" }
```

Снимает блокировку. Подписка не возвращается — участник подписывается
сам; повторный вызов не является ошибкой и ничего не меняет.
Ответ — пустой. Ошибки: `ACCESS_DENIED`, `CHANNEL_NOT_FOUND`,
`CHANNEL_TYPE_UNSUPPORTED`.

# moderation — модерация ботом

События раздела `[moderation]` для соединения бота. Бот действует как
модератор: доступ — для создателя сущности или бота-модератора с
соответствующим правом. Контракты совпадают с клиентскими версиями
(см. [moderation.md](../client-to-server/moderation.md)).

Работает в каналах, группах, темах, чатах трансляций и конференций;
личные диалоги и избранное не поддерживаются.

## `[moderation]: clean user messages` — удалить все сообщения участника

```json
{ "channel_id": "UUIDv7", "user_id": "UUIDv7" }
```

`user_id` — автор, чьи сообщения удаляются. Ответ — `{ "removed": 42,
"pts": 123 }`. Ошибки: `ACCESS_DENIED`, `CHANNEL_NOT_FOUND`,
`CHANNEL_TYPE_UNSUPPORTED`, `CANNOT_CLEAN_SELF`, `CANNOT_CLEAN_CREATOR`,
`CANNOT_CLEAN_MODERATOR`.

## `[moderation]: ban member` — заблокировать участника

```json
{ "channel_id": "UUIDv7", "user_id": "UUIDv7" }
```

«Кик + бан»: подписка снимается, участник не может писать и подписаться
заново. Ответ — пустой. Ошибки: `ACCESS_DENIED`, `CHANNEL_NOT_FOUND`,
`CHANNEL_TYPE_UNSUPPORTED`, `CANNOT_BAN_SELF`, `CANNOT_BAN_CREATOR`,
`CANNOT_BAN_MODERATOR`.

## `[moderation]: unban member` — разблокировать участника

```json
{ "channel_id": "UUIDv7", "user_id": "UUIDv7" }
```

Снимает блокировку, подписка не возвращается. Ответ — пустой.
Ошибки: `ACCESS_DENIED`, `CHANNEL_NOT_FOUND`, `CHANNEL_TYPE_UNSUPPORTED`.

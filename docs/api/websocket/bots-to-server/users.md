# users — пользователи

События раздела `[user]` для соединения бота.

## `[user]: get info` — информация о пользователе

```json
{ "user_id": "UUIDv7" }
```

Можно также передать `link` (вместо `user_id`). Ответ — объект
[User](../../objects/user.md) (meta): `get_base` + `is_contact`.
Состав полей совпадает с клиентским запросом: `privacy_messages`,
`privacy_calls`, `privacy_messages_voice` и `last_action_at` возвращаются
тоже.
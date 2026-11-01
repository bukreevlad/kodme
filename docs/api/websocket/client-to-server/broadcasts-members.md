# broadcasts-members — участники трансляций

События раздела `[broadcast-member]`.

## `[broadcast-member]: subscribe with invite` — вступление по приглашению

```json
{ "cast_id": "UUIDv7", "invite": "invite-link" }
```

`invite` — значение `link` приглашения трансляции. Ответ — пустой.

Ошибки: `INVITE_MAX_USES_EXCEEDED`, `INVITE_EXPIRED`. Повторное вступление по тому же
приглашению — без ошибки.
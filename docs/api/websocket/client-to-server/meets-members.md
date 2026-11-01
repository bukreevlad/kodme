# meets-members — участники конференций

События раздела `[meet-member]`.

## `[meet-member]: subscribe with invite` — вступление по приглашению

```json
{ "meet_id": "UUIDv7", "invite": "invite-link" }
```

`invite` — значение `link` приглашения конференции. Ответ — пустой.

Ошибки: `INVITE_INVALID_MAX_USES`, `INVITE_INVALID_EXPIRED`. Повторное вступление по тому же
приглашению — без ошибки.
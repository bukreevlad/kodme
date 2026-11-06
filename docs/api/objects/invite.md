# Invite — приглашение

```json
{
  "id": "UUIDv7",
  "entity_id": "UUIDv7",
  "entity_type": "channel",
  "created_user_id": "UUIDv7",
  "name": "Для друзей",
  "link": "abc123",
  "url": "https://kodme.ru/+abc123",
  "max_users": 0,
  "expires_at": null,
  "is_deleted": false,
  "created_at": "2026-09-21T12:34:56.789Z",
  "count_uses": 0
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | `UUIDv7` | Id приглашения. |
| `entity_id` | `UUIDv7` | Приглашаемый ресурс. |
| `entity_type` | `string` | `"channel"` \| `"broadcast"` \| `"meet"`. |
| `created_user_id` | `UUIDv7` | Создатель. |
| `name` | `string` | Название приглашения. |
| `link` | `string` | Значение ссылки-приглашения (передаётся как `invite`). |
| `url` | `string` | **Готовая полная ссылка** `<host>/+<link>` — хост берётся из конфигурации сервера, клиенту и боту не нужно собирать её самим. |
| `max_users` | `int` | Лимит использований; `0` — без лимита. |
| `expires_at` | `ISO 8601 \| null` | Срок действия. |
| `is_deleted` | `boolean` | Удалено. |
| `created_at` | `ISO 8601` | Дата создания. |
| `count_uses` | `int` | Сколько раз использовано. |

## Ошибки при использовании

- `INVITE_INVALID` — приглашение не найдено / некорректно.
- `INVITE_EXPIRED` — срок действия истёк.
- `INVITE_MAX_USES_EXHAUSTED` / `INVITE_MAX_USES_EXCEEDED` — лимит исчерпан.
- Повторное вступление по тому же приглашению — без ошибки (уже участник).
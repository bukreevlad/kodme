# Session — сессия устройства

```json
{
  "id": "UUIDv7",
  "platform": "web",
  "user_agent": "Mozilla/5.0 ...",
  "last_action_at": "2026-09-21T12:34:56.789Z"
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | `UUIDv7` | Id сессии. |
| `platform` | `string` | Платформа устройства (например `web`). |
| `user_agent` | `string` | User-Agent браузера/приложения. |
| `last_action_at` | `ISO 8601` | Последняя активность. |

События — [sessions.md](../websocket/client-to-server/sessions.md).
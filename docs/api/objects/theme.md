# Theme — тема оформления

Управление темами — [themes.md](../websocket/client-to-server/themes.md).

```json
{
  "id": "UUIDv7",
  "name": "Тёмная",
  "style": "{ ... }",
  "created_at": "2026-09-21T12:34:56.789Z",
  "edited_at": null,
  "created_user_id": "UUIDv7",
  "author_name": "Иван Петров"
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | `UUIDv7` | Id темы. |
| `name` | `string` | Название. |
| `style` | `string` | Стиль темы (JSON-строка). |
| `created_at` | `ISO 8601` | Дата создания. |
| `edited_at` | `ISO 8601 \| null` | Дата изменения. |
| `created_user_id` | `UUIDv7` | Автор. |
| `author_name` | `string` | Имя автора. |
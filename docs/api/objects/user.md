# User — пользователь

Пользователь платформы (или бот, если `is_bot: true`).

## `get_base` (публичные данные)

```json
{
  "id": "UUIDv7",
  "first_name": "Иван",
  "last_name": "Петров",
  "bio": null,
  "privacy_messages": "all",
  "privacy_calls": "all",
  "privacy_messages_voice": "all",
  "is_bot": false,
  "link": null,
  "display_name": "Иван Петров",
  "last_action_at": "2026-09-21T12:34:56.789Z",
  "avatar": null
}
```

## `get_meta` = `get_base` + `is_contact`

```json
{
  "…": "поля get_base",
  "is_contact": false
}
```

`is_contact` — `boolean`: добавлен ли пользователь в ваши контакты.

## Поля

| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | `UUIDv7` | Id пользователя. |
| `first_name` / `last_name` | `string` | Имя / фамилия. |
| `bio` | `string \| null` | О себе. |
| `privacy_messages` | `string` | Приватность сообщений: `"all"` \| `"contacts"` \| `"none"`. |
| `privacy_calls` | `string` | Приватность звонков: `"all"` \| `"contacts"` \| `"none"`. |
| `privacy_messages_voice` | `string` | Приватность голосовых: `"all"` \| `"contacts"` \| `"none"`. |
| `is_bot` | `boolean` | Является ли пользователь ботом. |
| `link` | `string \| null` | Публичная ссылка на профиль (у бота — ссылка бота). |
| `display_name` | `string` | Отображаемое имя (для бота — его `link`). |
| `last_action_at` | `ISO 8601 \| null` | Последняя активность (максимум по сессиям). |
| `avatar` | [File](./file.md) \| `null` | Аватар. |
| `is_contact` | `boolean` | Только в `get_meta`. |

## Дополнительные поля в ответах

- `[search]: get users` — поле `is_online: boolean`.
- `[contact]: get contacts` — поле `is_blocked: boolean`.
- `[user]: get settings` возвращает не объект `User` целиком, а набор полей
  (`avatar_document_id` — сырой UUID без токена, `privacy_*` и т.д.).
  Полный список — в [users.md](../websocket/client-to-server/users.md).
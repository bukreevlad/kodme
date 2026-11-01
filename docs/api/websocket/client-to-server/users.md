# users — профиль пользователя

События раздела `[user]`. Основной объект — [User](../../objects/user.md).

## `[user]: get info` — информация о пользователе

```json
{ "user_id": "UUIDv7", "link": null }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `user_id` | `UUIDv7` | — | Id пользователя. |
| `link` | `string \| null` | `null` | Поиск по ссылке на профиль (если передан — `user_id` не нужен). |

Ответ — объект [User](../../objects/user.md) (meta).

## `[user]: get settings` — настройки профиля

```json
{}
```

Ответ:

```json
{
  "id": "UUIDv7",
  "first_name": "Иван",
  "last_name": "Петров",
  "bio": null,
  "avatar_document_id": "UUIDv7",
  "privacy_messages": "all",
  "privacy_messages_voice": "all",
  "privacy_calls": "all",
  "display_name": "Иван Петров",
  "link": "ivan"
}
```

`avatar_document_id` — сырой UUID документа аватарки (без токена), может быть `null`.

## `[user]: save settings` — изменение профиля

```json
{ "email": "user@example.com", "first_name": "Иван", "last_name": "Петров", "bio": "Описание", "link": "ivan" }
```

Ответ:

```json
{ "first_name": "Иван", "last_name": "Петров", "display_name": "Иван Петров", "bio": null }
```

## `[user]: get privacy settings`

```json
{}
```

Ответ: `{ "id", "privacy_messages", "privacy_messages_voice", "privacy_calls", "privacy_search_users" }`.

## `[user]: save privacy settings` — приватность

```json
{
  "privacy_messages": "all",
  "privacy_messages_voice": "all",
  "privacy_calls": "all",
  "privacy_search_users": "all"
}
```

Возможные значения:

- `privacy_messages`, `privacy_messages_voice`, `privacy_calls`, `privacy_search_users`.

Значения по умолчанию — как в примере выше. Ответ — пустой.

## `[user]: get notify settings` — настройки уведомлений

```json
{}
```

Ответ:

```json
{
  "id": "UUIDv7",
  "notify_action_accounts": false,
  "notify_calls": false,
  "notify_messages": false,
  "notify_comments": false,
  "notify_reply_message": false
}
```

## `[user]: save notify settings`

```json
{
  "notify_action_accounts": true,
  "notify_calls": true,
  "notify_messages": true,
  "notify_comments": true,
  "notify_reply_message": true
}
```

Все поля опциональны, по умолчанию `false`. Ответ — пустой.

## `[user]: save link` — ссылка на профиль

```json
{ "link": "ivan" }
```

`link` — `^[a-z0-9_]{3,32}$`; передайте `null`, чтобы удалить. Ответ — пустой. Ошибка: `LINK_ALREADY_TAKEN`.

## `[user]: save email` — смена почты

```json
{ "email": "new@example.com" }
```

Ответ — пустой. Ошибки: `EMAIL_ALREADY_TAKEN`, `EMAIL_INVALID`.

## `[user]: set password` — смена пароля

```json
{
  "old_password": "old",
  "new_password": "new",
  "retry_password": "new",
  "is_exit_other_sessions": false
}
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `is_exit_other_sessions` | `boolean` | `false` | Выйти из остальных сессий. При `true` требуется передать `current_session_id`. |

Ответ — пустой. Ошибки: `PASSWORDS_NOT_MATCH`, `OLD_PASSWORD_MISMATCH`.

## `[user]: get upload avatar url` — ссылка для загрузки аватарки

```json
{ "file_name": "avatar.jpg", "mime_type": "image/jpeg", "size": 102400 }
```

Ответ — цели загрузки: `{ "targets": [...], "document_id": "UUIDv7" }` —
**только оригинал**, производные ассеты создаст сервер. Загрузите цель
`POST`-ом по её `url` (см.
[руководство по файлам](../../guides/upload.md)).

## `[user]: save avatar` — сохранить аватар

```json
{ "document_id": "UUIDv7" }
```

Вызывается после загрузки оригинала. Сервер проверяет оригинал в хранилище,
генерирует производные ассеты и отвечает готовым объектом — ожидание
обработки может занять до ~100 секунд, таймаут запроса должен быть
**не меньше 120 секунд**. Повторный вызов идемпотентен. Ответ —
токенизированный объект файла (см. [objects/file.md](../../objects/file.md)).
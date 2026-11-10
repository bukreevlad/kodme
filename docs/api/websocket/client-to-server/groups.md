# groups — группы

События раздела `[group]`. Группа — канал типа 2. Модераторам доступна часть действий.

## `[group]: create` — создание группы

```json
{ "name": "Python разработчики", "about": null, "is_public": true, "is_posting": false }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название, `^[а-яеЁА-Яa-zA-Z0-9-:_ .\/\\]{2,128}$`. |
| `about` | `string \| null` | `null` | Описание, до 255 символов. |
| `is_public` | `boolean` | `true` | Публичность. |
| `is_posting` | `boolean` | `false` | Разрешена ли запись сообщений участниками. |

Ответ: `{ "channel_id": "UUIDv7" }`.

## `[group]: get settings` — настройки группы

```json
{ "channel_id": "UUIDv7" }
```

*Только владелец.* Ответ:

```json
{
  "id": "UUIDv7",
  "created_user_id": "UUIDv7",
  "type": 2,
  "name": "П",
  "about": null,
  "created_at": "2026-09-21T12:34:56.789Z",
  "topic_for_group_id": null,
  "is_public": true,
  "is_posting": false,
  "link": null,
  "avatar": null
}
```

## `[group]: save settings` — изменение настроек

```json
{ "channel_id": "UUIDv7", "name": "Новое имя", "link": null, "about": null, "is_public": true, "is_posting": false }
```

*Только владелец.* Поле `link` игнорируется (ссылка меняется событием `[group]: save link`). При смене имени в чат добавляется системное сообщение `USER_RENAMED_GROUP`. Ответ — пустой.

## `[group]: save link` — ссылка-приглашение

```json
{ "channel_id": "UUIDv7", "link": "python-dev" }
```

Ответ — пустой.

## `[group]: remove` — удаление группы

```json
{ "channel_id": "UUIDv7" }
```

*Только владелец.* Ответ — пустой.

## `[group]: topic create` — создать тему группы

```json
{ "channel_id": "UUIDv7", "name": "Обсуждения", "about": null, "is_posting": true }
```

Ответ: `{ "channel_id": "UUIDv7" }` — id канала темы (тип 4).

## `[group]: get topics` — темы группы

```json
{ "channel_id": "UUIDv7", "direction": "next", "cursor_id": null, "offset": 35 }
```

Ответ — массив [Channel](../../objects/channel.md) (тип 4) **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).

## `[group]: get moderators` — модераторы

```json
{ "channel_id": "UUIDv7", "direction": "next", "cursor_id": null, "offset": 35 }
```

Ответ — массив объектов модераторов: поля членства (участника) + поля [User](../../objects/user.md) (base) **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).

## `[group]: add moderator` — назначить модератора

```json
{
  "channel_id": "UUIDv7",
  "user_id": "UUIDv7",
  "can_deleted_message": false,
  "can_clean_messages": false,
  "can_restrict_members": false,
  "can_invite_users": false,
  "can_pin_messages": false
}
```

*Только владелец.* Ответ — пустой. В чат добавляется системное сообщение `USER_ROLE_CHANGED_TO_MODERATOR_IN_GROUP` с полями `{ user_name, user_id, is_bot }`.

## `[group]: remove moderator` — удалить модератора

```json
{ "channel_id": "UUIDv7", "user_id": "UUIDv7" }
```

*Только владелец.* `user_id` — id разжалуемого модератора. Снимаются
`is_moderator` и все права — участник остаётся в группе. Ответ — пустой.
В чат добавляется системное сообщение `USER_ROLE_CHANGED_TO_USER_IN_GROUP`
с полями `{ user_name, user_id, is_bot }`. Ошибки:
`MODERATOR_NOT_FOUND` (пользователь не модератор этой группы),
`ACCESS_DENIED`.

## `[group]: get moderator settings` — права модератора

```json
{ "channel_id": "UUIDv7", "user_id": "UUIDv7" }
```

Ответ — поля членства модератора + поля [User](../../objects/user.md) (base).

## `[group]: save moderator settings` — изменить права модератора

```json
{
  "channel_id": "UUIDv7",
  "user_id": "UUIDv7",
  "can_deleted_message": true,
  "can_clean_messages": true,
  "can_restrict_members": true,
  "can_invite_users": true,
  "can_pin_messages": true
}
```

Ответ — пустой.

## `[group]: get upload avatar url` / `[group]: save avatar`

Ссылка загрузки и сохранение аватарки группы — как в [channels.md](./channels.md) (поле `channel_id` обязательно).

## `[group]: remove avatar` — удалить аватар

```json
{ "channel_id": "UUIDv7" }
```

*Только владелец.* Снимает ссылку на аватар: файл и документ не удаляются,
аватар перестаёт отображаться. Повторный вызов идемпотентен (отсутствие
аватара — не ошибка). Ответ — пустой. Ошибка: `ACCESS_DENIED` (запрашивает
не владелец группы).
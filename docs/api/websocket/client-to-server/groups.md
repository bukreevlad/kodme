# groups — группы

События раздела `[group]`. Группа — канал `kind: "group"`. Модераторам доступна часть действий.

## `[group]: create` — создание группы

```json
{ "name": "Python разработчики", "about": null, "visibility": "public", "posting_mode": "admins" }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название, `^[а-яеЁА-Яa-zA-Z0-9-:_ .\/\\]{2,128}$`. |
| `about` | `string \| null` | `null` | Описание, до 255 символов. |
| `visibility` | `string` | `"public"` | `"public"` \| `"private"` — публичность группы. |
| `posting_mode` | `string` | `"admins"` | Кто может писать: `"all"` — все подписанные участники, `"admins"` — только владелец и модераторы с правом публикации. |

Ответ: `{ "channel_id": "UUIDv7" }`.

## `[group]: get settings` — настройки группы

```json
{ "channel_id": "UUIDv7" }
```

*Только владелец.* Ответ:

```json
{
  "id": "UUIDv7",
  "owner_id": "UUIDv7",
  "kind": "group",
  "name": "П",
  "about": null,
  "created_at": "2026-09-21T12:34:56.789Z",
  "parent_channel_id": null,
  "visibility": "public",
  "posting_mode": "admins",
  "link": null,
  "avatar": null
}
```

## `[group]: save settings` — изменение настроек

```json
{ "channel_id": "UUIDv7", "name": "Новое имя", "link": null, "about": null, "visibility": "public", "posting_mode": "admins" }
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
{ "channel_id": "UUIDv7", "name": "Обсуждения", "about": null, "posting_mode": "all" }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название, `^[а-яеЁА-Яa-zA-Z0-9-:_ .\/\\]{2,128}$`. |
| `about` | `string \| null` | `null` | Описание. |
| `posting_mode` | `string` | `"all"` | Кто может писать: `"all"` — все подписанные участники, `"admins"` — только владелец и модераторы с правом публикации. |

Ответ: `{ "channel_id": "UUIDv7" }` — id канала темы (`kind: "topic"`).

## `[group]: get topics` — темы группы

```json
{ "channel_id": "UUIDv7", "direction": "next", "cursor_id": null, "offset": 35 }
```

Ответ — массив [Channel](../../objects/channel.md) (`kind: "topic"`) **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).

## `[group]: get moderators` — модераторы

```json
{ "channel_id": "UUIDv7", "direction": "next", "cursor_id": null, "offset": 35 }
```

Ответ — массив объектов модераторов: поля членства участника
(`is_subscribed`, `is_banned`, `banned_at`, `subscribed_at`), поля прав
модератора (`is_moderator`, `can_deleted_message`, `can_clean_messages`,
`can_restrict_members`, `can_invite_users`, `can_pin_messages`,
`can_posting_messages` — см. [Role](../../objects/role.md)) + поля
[User](../../objects/user.md) (base) **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).

## `[group]: add moderator` — назначить модератора

```json
{
  "channel_id": "UUIDv7",
  "user_id": "UUIDv7",
  "can_deleted_message": false,
  "can_clean_messages": false,
  "can_restrict_members": false,
  "can_invite_users": false,
  "can_pin_messages": false,
  "can_posting_messages": false
}
```

*Только владелец.* Назначает модератора канала: по одной узкой роли
(`channel_moderator_*`, см. [Role](../../objects/role.md)) на каждое
включённое право `can_*`. Поля `can_*`
входят в контракт события, а состав прав задаётся событием
`save moderator settings`. Ответ — пустой. В чат добавляется системное
сообщение `USER_ROLE_CHANGED_TO_MODERATOR_IN_GROUP` с полями
`{ user_name, user_id, is_bot }`.

## `[group]: remove moderator` — удалить модератора

```json
{ "channel_id": "UUIDv7", "user_id": "UUIDv7" }
```

*Только владелец.* `user_id` — id разжалуемого модератора. Роль модератора
снимается — участник остаётся в группе. Ответ — пустой.
В чат добавляется системное сообщение `USER_ROLE_CHANGED_TO_USER_IN_GROUP`
с полями `{ user_name, user_id, is_bot }`. Ошибки:
`MODERATOR_NOT_FOUND` (пользователь не модератор этой группы),
`ACCESS_DENIED`.

## `[group]: get moderator settings` — права модератора

```json
{ "channel_id": "UUIDv7", "user_id": "UUIDv7" }
```

Ответ — поля членства модератора (`is_subscribed`, `is_banned`, `banned_at`,
`subscribed_at`), поля прав модератора (`is_moderator`, `can_deleted_message`,
`can_clean_messages`, `can_restrict_members`, `can_invite_users`,
`can_pin_messages`, `can_posting_messages`, см.
[Role](../../objects/role.md)) + поля [User](../../objects/user.md) (base).

## `[group]: save moderator settings` — изменить права модератора

```json
{
  "channel_id": "UUIDv7",
  "user_id": "UUIDv7",
  "can_deleted_message": true,
  "can_clean_messages": true,
  "can_restrict_members": true,
  "can_invite_users": true,
  "can_pin_messages": true,
  "can_posting_messages": true
}
```

Ответ — пустой. Галочки превращаются в канальные роли модератора (см.
[Role](../../objects/role.md)): по одной узкой роли `channel_moderator_*` на
каждое включённое право; если ни одно право не включено — модераторские роли
снимаются (участник остаётся в группе). `can_posting_messages` разрешает
писать в сущности с режимом `posting_mode: "admins"` («Только администратор»):
без права в таком режиме публикация доступна только создателю. От права не
зависит общий режим `posting_mode: "all"` — там пишут все подписанные
участники.

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
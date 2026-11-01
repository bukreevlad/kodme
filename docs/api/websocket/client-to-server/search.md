# search — поиск

События раздела `[search]`. Общие параметры: `search` (строка запроса), `direction`, `cursor_id`, `offset: 35`.

## `[search]: get users` — поиск пользователей

```json
{ "search": "Иван", "direction": "next", "cursor_id": null, "offset": 35 }
```

Ответ — массив [User](../../objects/user.md) (meta) с полем `is_online` (`boolean`) **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).
Учитывается приватность `privacy_search_users` (см. [users.md](./users.md)).

## `[search]: get bots` — поиск ботов

```json
{ "search": "бот", "direction": "next", "cursor_id": null, "offset": 35 }
```

Ответ — массив [Bot](../../objects/bot.md) (meta) с полем `is_online` **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).

## `[search]: get channels` — поиск каналов

```json
{ "search": "Код", "direction": "next", "cursor_id": null, "offset": 35 }
```

Ответ — массив [Channel](../../objects/channel.md) (meta), каналы типа 3, **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).

## `[search]: get groups` — поиск групп

```json
{ "search": "Python", "direction": "next", "cursor_id": null, "offset": 35 }
```

Ответ — массив [Channel](../../objects/channel.md) (meta), группы типа 2, **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).
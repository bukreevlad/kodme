# contacts — контакты

События раздела `[contact]`. Объект контакта — [User](../../objects/user.md) с дополнительной меткой `is_blocked`.

## `[contact]: get contacts` — список контактов

```json
{ "direction": "next", "cursor_id": null, "offset": 35 }
```

Ответ — массив [User](../../objects/user.md) (meta) с полем `is_blocked` (`boolean`) **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).

## `[contact]: is contact` — проверка, что пользователь в контактах

```json
{ "contact_user_id": "UUIDv7" }
```

Ответ:

```json
{ "id": "UUIDv7" }
```

Если пользователь не в контактах — `data: null`.

## `[contact]: add` — добавить контакт

```json
{ "contact_user_id": "UUIDv7" }
```

Ответ — `{ "is_contact": true }`, если пользователь уже был добавлен, иначе `data: null`.

## `[contact]: remove` — удалить контакт

```json
{ "contact_user_id": "UUIDv7" }
```

Ответ — `{ "is_contact": false }`, если пользователя не было, иначе `data: null`.
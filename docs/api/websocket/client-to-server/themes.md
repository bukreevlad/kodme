# themes — темы оформления

События раздела `[theme]`. Основной объект — [Theme](../../objects/theme.md).

## `[theme]: create` — создать тему

```json
{ "name": "Тёмная", "style": "{ \"colors\": { ... } }", "is_public": false }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `name` | `string` | — | Название, `^[\p{sc=Cyrillic}\p{sc=Common}\p{sc=Latin}]{2,128}$`. |
| `style` | `string` | — | Стиль темы (обязателен). |
| `is_public` | `boolean` | `true` | Публичность. |

Ответ: `{ "theme_id": "UUIDv7" }`.

## `[theme]: save` — сохранить/изменить тему

```json
{ "name": "Тёмная", "style": "...", "is_public": false, "theme_id": "UUIDv7" }
```

Ответ — пустой.

## `[theme]: get themes` — список тем

```json
{ "direction": "next", "cursor_id": null, "offset": 35 }
```

`direction` — `"prev"` \\| `"next"`; `offset` — 1–100. Ответ — массив тем: свои и публичные **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).
Объект темы:

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

## `[theme]: get info` — информация о теме

```json
{ "theme_id": "UUIDv7" }
```

*Только автор темы.* Ответ — объект темы (см. выше).

## `[theme]: remove` — удалить тему

```json
{ "theme_id": "UUIDv7" }
```

*Только автор.* Ответ — пустой.
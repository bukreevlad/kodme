# dialogs — личные диалоги

События раздела `[dialog]`. Диалог — канал `kind: "dialog"` (личный чат);
собеседник-бот определяется по объекту [Bot](../../objects/bot.md).

## `[dialog]: create` — создать диалог

```json
{ "user_id": "UUIDv7" }
```

Ответ: `{ "channel_id": "UUIDv7" }`.

Если диалог уже существовал — возвращается id существующего канала. Оба участника получают событие `channel_created` личной ленты `[user]: feed`.

## `[dialog]: create bot` — создать диалог с ботом

```json
{ "bot_id": "UUIDv7" }
```

Ответ: `{ "channel_id": "UUIDv7" }` — диалог с ботом (`kind: "dialog"`).

## `[dialog]: remove` — удалить диалог

```json
{ "channel_id": "UUIDv7", "for_all": false }
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `for_all` | `boolean` | `false` | Удалить у обоих участников. |

Ответ — пустой.
# server-to-client: боты и формы

События раздела `[bot][form]` доставляются на **конкретное соединение** пользователя
(то соединение, с которого он отправлял `[bot-form]: click button`). Это ответы
бота на действия пользователя, см. [bot-forms.md](../client-to-server/bot-forms.md).

> События, которые приходят **самому боту** (`[form]: click button`, `[message]: *`)
> — в документации соединения бота
> ([bots-to-server](../bots-to-server/README.md)).

## `[bot][form]: new` — новая форма

```json
{
  "bot_id": "UUIDv7",
  "form": { "…": "объект формы" },
  "channel_id": "UUIDv7"
}
```

## `[bot][form]: update` — обновление элементов формы

```json
{ "bot_id": "UUIDv7", "form_id": "form-1", "elements": [ ... ] }
```

## `[bot][form]: replace` — полная замена формы

```json
{ "bot_id": "UUIDv7", "form": { "…": "объект формы" } }
```

## `[bot][form]: close` — закрытие формы

```json
{ "bot_id": "UUIDv7", "form_id": "form-1" }
```
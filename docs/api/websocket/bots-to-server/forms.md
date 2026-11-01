# forms — формы

События раздела `[form]` для соединения бота. Форма — интерактивная карточка
в чате с ботом (кнопки, поля, списки, медиа). Пользователь взаимодействует
с формой событиями `[bot-form]: *` (см. [bot-forms.md](../client-to-server/bot-forms.md)),
сервер пересылает действия боту, а ответы бота возвращает пользователю.

Для ответа конкретному пользователю бот передаёт `user_socket_id` — id соединения,
из которого пришло действие.

## `[form]: send` — отправить форму пользователю

```json
{
  "user_socket_id": "…",
  "channel_id": "UUIDv7",
  "form": { "id": "form-1", "title": "Оплата", "elements": [ ... ] }
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `user_socket_id` | `string` | Соединение пользователя, которому показывается форма. |
| `channel_id` | `UUIDv7` | Канал, в котором открыта форма. |
| `form` | `object` | Объект формы. |

Ответ — пустой. Пользователь получает `[bot][form]: new`.

## `[form]: update` — обновить элементы формы

```json
{ "user_socket_id": "…", "form_id": "form-1", "elements": [ ... ] }
```

Ответ — пустой. Пользователь получает `[bot][form]: update`.

## `[form]: close` — закрыть форму

```json
{ "user_socket_id": "…", "form_id": "form-1" }
```

Ответ — пустой. Пользователь получает `[bot][form]: close`.

## `[form]: replace` — полностью заменить форму

```json
{ "user_socket_id": "…", "form": { "id": "form-2", "elements": [ ... ] } }
```

Ответ — пустой. Пользователь получает `[bot][form]: replace`.

## Входящие события (сервер → бот)

### `[form]: click button` — нажатие кнопки формы

Приходит точечно в соединение бота (без `timestamp`):

```json
{
  "type": "event",
  "event": "[form]: click button",
  "data": {
    "user_socket_id": "…",
    "user_id": "UUIDv7",
    "channel_id": "UUIDv7",
    "form_id": "form-1",
    "button_id": "btn-ok",
    "state": null,
    "data": { ... }
  }
}
```

`user_socket_id` — то соединение, на которое боту нужно отвечать
событиями `[form]: update` / `[form]: close`.
# bot-forms — формы ботов

События раздела `[bot-form]`. Форма — интерактивный интерфейс в чате с ботом
(карточка с кнопками, полями, списками и медиа).

События клиента пересылаются сервером **боту** (в его WebSocket-соединение); ответы
бота приходят пользователю событиями `[bot][form]: *` (см. [server-to-client](../server-to-client/README.md)).
Формат событий, которые получает сам бот (`[form]: *`), описан в [bots-to-server](../bots-to-server/forms.md).

## `[bot-form]: click button` — нажатие кнопки формы

```json
{
  "bot_id": "UUIDv7",
  "channel_id": "UUIDv7",
  "form_id": "form-1",
  "button_id": "btn-ok",
  "state": null,
  "data": { ... }
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `bot_id` | `UUIDv7` | Бот, которому адресовано действие. |
| `channel_id` | `UUIDv7` | Канал, где открыта форма. |
| `form_id` | `string` | Id формы. |
| `button_id` | `string` | Id нажатой кнопки. |
| `state` | `any \| null` | Состояние формы. |
| `data` | `any` | Данные формы (обязательны). |

Ответ — пустой. Ошибка `BOT_NOT_IN_NETWORK` — если бот сейчас офлайн.
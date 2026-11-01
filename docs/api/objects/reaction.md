# Reaction — реакция на сообщение

```json
{
  "reaction": "🔥",
  "avatars": [
    {
      "user_id": "UUIDv7",
      "display_name": "Иван Петров",
      "avatar": null
    }
  ],
  "count": 1,
  "is_selected": false
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `reaction` | `string` | Emoji реакции. |
| `avatars` | `array` | Кто поставил (сокращённый User: `user_id`, `display_name`, `avatar`). |
| `count` | `int` | Сколько раз поставлена. |
| `is_selected` | `boolean` | Поставил ли текущий пользователь. |

## Доступные реакции

```
👍 👎 ❤️ 🔥 🎉 🤩 😱 😁 😢 💩 🤮 🥰 🤯 🤔 🤬 👏
```

Повторная отправка той же реакции снимает её; другая реакция — заменяет текущую.
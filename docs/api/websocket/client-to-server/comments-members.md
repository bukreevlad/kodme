# comments-members — позиция возврата в комментарии

События раздела `[comment-member]`.

## `[comment-member]: update last viewed comment` — сохранить позицию чтения

```json
{
  "entity_id": "UUIDv7",
  "entity_type": "message",
  "comment_id": "UUIDv7"
}
```

| Поле | Тип | По умолчанию | Описание |
| --- | --- | --- | --- |
| `entity_id` | `UUIDv7` | — | Id поста. |
| `entity_type` | `string` | — | Тип сущности (`"message"`). |
| `comment_id` | `UUIDv7` | — | Комментарий, до которого пользователь долистал. |

Ответ — пустой (`data: null`).

## Правила

- Позиция **двигается только вперёд**: `greatest(старая, новая)`. Это защищает от
  гонки с `IntersectionObserver` — когда позиция отправляется пачками по мере
  прокрутки, запросы могут прийти не по порядку.
- `comment_id` обязан принадлежать этому посту, иначе `COMMENT_MISMATCH` (`131901`);
  на удалённый/несуществующий — `INVALID_COMMENT_ID` (`131907`).
- Запись создаётся лениво (UPSERT); при открытии формы комментариев запись
  создаётся заранее событием [`[comment]: open`](./comments.md#comment-open--открытие-формы-комментариев).
- Флаги `is_commenting` канала и поста **не** проверяются: комментирование могут
  выключить, а сохранить позицию в уже прочитанной ветке — можно.

Ответ события и его содержимое — в
[server-to-client/comments-members.md](../server-to-client/comments-members.md).

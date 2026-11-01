# server-to-client: позиция возврата в комментарии

События раздела `[comment-member]`.

## `[comment-member]: update last viewed comment`

```json
{
  "type": "event",
  "event": "[comment-member]: update last viewed comment",
  "data": {
    "entity_id": "UUIDv7",
    "entity_type": "message",
    "last_viewed_comment_id": "UUIDv7"
  },
  "timestamp": "2026-09-21T12:34:56.789Z"
}
```

Доставляется **только текущему пользователю**, во все его комнаты
`user::<user_id>` (то есть во все вкладки и сессии). Это нужно, чтобы вторая
вкладка не показывала маркер «вы не читали» на месте, которое первая вкладка уже
просмотрела.

Значение в `data` — результат UPSERT, а не присланное клиентом: сервер двигает
позицию только вперёд (`greatest`), поэтому при гонке запросов клиент получит
актуальный (максимальный) id.

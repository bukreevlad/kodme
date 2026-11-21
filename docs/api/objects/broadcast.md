# Broadcast — трансляция

Трансляция связана с чатом (`kind: "cast_chat"`). Управление — [broadcasts.md](../websocket/client-to-server/broadcasts.md).

## `get_base`

```json
{
  "id": "UUIDv7",
  "name": "Моя трансляция",
  "about": null,
  "is_public": true,
  "is_chat": true,
  "chat_channel_id": "UUIDv7",
  "created_at": "2026-09-21T12:34:56.789Z",
  "owner_id": "UUIDv7",
  "thumbnail_document_id": null,
  "is_bot": false,
  "bot_owner_id": null,
  "thumbnail": null
}
```

## `get_meta` = `get_base` + статус эфира

```json
{
  "…": "поля get_base",
  "created_display_name": "Иван Петров",
  "is_live": false,
  "started_at": null
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `is_live` | `boolean` | Идёт ли эфир. |
| `started_at` | `ISO 8601 \| null` | Время начала эфира (только при `is_live: true`). |
| `created_display_name` | `string` | Имя автора (у бота — его `link`). |
| `thumbnail` | [File](./file.md) \| `null` | Обложка. |

## `access_token` — токен просмотра потока

Строка (JWT) для подключения к потоку трансляции: передаётся в query-параметре
`token` адресов воспроизведения, срок действия — 6 часов.

| Где возвращается | Когда |
| --- | --- |
| `[broadcast]: get casts` | Для каждой трансляции с `is_live: true` |
| `[broadcast]: open` | Всегда |

Поле отсутствует у трансляций не в эфире в ответе списка.

## Кадры и обложки

У трансляции два источника картинки:

| Что | Когда доступно | Откуда берётся |
| --- | --- | --- |
| Обложка | всегда, если задана (`thumbnail` не `null`) | файл в хранилище |
| Текущий кадр эфира | только при `is_live: true` | снимок идущего потока |

### Обложка

Собирается из полей `thumbnail` — объекта [File](./file.md):

```http
GET /api/v1/storage/<thumbnail.id>?size=<ширина>&token=<thumbnail.token>
```

- `size` — одно из значений `metadata.thumbnails[].width` (`400`/`800`/`1200`);
  без параметра отдаётся оригинал;
- в ответе — редирект на подписанный адрес файла (подробности и коды ответов —
  [HTTP: скачивание файлов](../http/storage.md)).

### Текущий кадр эфира

Снимок кадра идущего эфира — показывает, что трансляция идёт прямо сейчас:

```http
GET /api/v1/cast/hls/live/<id>/thumb.jpg?token=<access_token>&_=<метка времени>
```

- `token` — `access_token` трансляции (см. выше);
- обновляйте кадр не чаще одного раза в 10 секунд и передавайте в `_` новое
  значение (например, время в миллисекундах) — иначе придёт копия из кэша;
- кадр отдаётся только во время эфира: пока поток стартует или уже остановлен,
  запрос может не пройти — в этом случае используйте обложку из `thumbnail`.

## Связанное

- Адреса воспроизведения и публикации (LL-HLS, WebRTC, RTMP, WHIP) —
  [гайд «Трансляции»](../guides/broadcasts.md).
- Статус эфира в реальном времени — push `[broadcast]: update`
  ([server-to-client](../websocket/server-to-client/broadcasts.md)).
- Технические параметры потока — `[broadcast]: get stream info`.
- Чат трансляции наследует её доступ: приватную трансляцию и её чат видят её
  владелец и подписанные участники. Приватность (`is_public`) чата повторяет
  приватность трансляции, а `is_chat: false` отключает отправку сообщений в чате.
# channel-profile — медиа и ссылки канала

События раздела `[channel-profile]`.

Общие параметры для всех событий списка:

```json
{ "channel_id": "UUIDv7", "direction": "next", "cursor_id": null, "offset": 100 }
```

`offset` — диапазон **1–300**. Доступ — как у открытого канала (участник или публичный канал).

Ответы — массивы объектов вложений: токенизированный файл + `attachment_id` + `document_id` + `entity_context` + `created_at`
(см. [objects/file.md](../../objects/file.md)) **и** поле `has_more: boolean` — есть ли
продолжение в сторону `direction` (для первой загрузки — есть ли записи старше страницы).

Список идёт **новыми записями вперёд**: без `direction` (первая загрузка) отдаются
самые новые записи, `direction: "next"` — записи новее курсора, `direction: "prev"` —
старше. `created_at` — дата поста, которому принадлежит запись (ISO 8601); если дата
неизвестна, поле приходит `null`.

`cursor_id` следующей страницы — крайний `attachment_id` загруженной части списка
(для `get urls`, где объект ответа — сообщение, — крайний `id`).

| Событие | Содержимое ответа |
| --- | --- |
| `[channel-profile]: get photos` | Вложения с image-типами. |
| `[channel-profile]: get videos` | Вложения с video-типами. |
| `[channel-profile]: get audios` | Вложения с audio-типами (без голосовых). |
| `[channel-profile]: get voices` | Голосовые сообщения (audio с `metadata.flags.is_audio_note: true`; добавляется `display_name` автора). |
| `[channel-profile]: get files` | Прочие файлы (не image/audio/video). |
| `[channel-profile]: get urls` | Сообщения со ссылками: `{ id, text_preview, urls[], display_name }`. |
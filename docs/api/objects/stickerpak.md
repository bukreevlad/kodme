# StickerPak — пак стикеров

Пак — набор стикеров (картинок WEBP), собранный пользователем. Публичные паки
видны всем и доступны для подписки, приватные — только автору. Управление
паками — [stickers.md](../websocket/client-to-server/stickers.md).

```json
{
  "id": "UUIDv7",
  "name": "Мои стикеры",
  "about": "Первый пак",
  "is_public": false,
  "created_user_id": "UUIDv7",
  "created_at": "2026-09-21T12:34:56.789Z",
  "author_name": "Иван Петров",
  "is_author": true,
  "is_member": false,
  "stickers_count": 12,
  "preview": []
}
```

## Поля пака

| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | `UUIDv7` | Id пака. |
| `name` | `string` | Название (≤ 64 символов). |
| `about` | `string \| null` | Описание (≤ 255 символов). |
| `is_public` | `boolean` | Публичный (виден всем) либо приватный (только автору). |
| `created_user_id` | `UUIDv7` | Автор. |
| `created_at` | `ISO 8601` | Дата создания. |
| `author_name` | `string` | Имя автора. |
| `is_author` | `boolean` | Является ли запрашивающий автором пака. |
| `is_member` | `boolean` | Добавил ли запрашивающий пак к себе. |
| `stickers_count` | `int` | Количество стикеров в паке. |
| `preview` | `Array<Sticker>` | Первые 4 стикера пака (в `[sticker]: get paks`). |

## Стикер

Элемент массивов `preview` (в списке паков) и `stickers` (в `[sticker]: get pak`).

```json
{
  "sticker_id": "UUIDv7",
  "document_id": "UUIDv7",
  "file_token": "..."
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `sticker_id` | `UUIDv7` | Идентификатор стикера (для `[sticker]: delete sticker`). |
| `document_id` | `UUIDv7` | Документ файла стикера (для отправки — `sticker_document_id` в `[message]: send`). |
| `file_token` | `string \| null` | Токен на чтение файла (query `?token=…` ссылки хранилища). |

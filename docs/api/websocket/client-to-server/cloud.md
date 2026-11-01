# cloud — личное облако (файлы и папки)

События раздела `[cloud]`. Модуль включается флагом `server.modules.cloud` в `config.yaml`.

Элементы облака (`папки` и `файлы`) хранятся в единой таблице `cloud_items`
(поле `parent_id` ссылается на родительскую папку; корень облака —
элемент без `parent_id`). Метаданные файлов хранятся в `documents`.

При получении содержимого папки **папки всегда отдаются первыми и полностью**,
файлы — порциями по `offset` (keyset-пагинация по `id`, `direction` / `cursor_id`).

## Общие поля пагинации

| Поле | Тип | Описание |
| --- | --- | --- |
| `direction` | `"prev" \| "next" \| null` | Направление загрузки (по умолчанию `null` — первая страница). |
| `cursor_id` | `UUIDv7 \| null` | Id последнего файла предыдущей страницы. |
| `offset` | `number` | Количество файлов (от 1 до 300, по умолчанию 50). |

## `[cloud]: create folder` — создать папку

```json
{ "parent_id": null, "link_id": null, "name": "Документы" }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `parent_id` | `UUIDv7 \| null` | Id родительской папки (корень облака, если не передан; для ссылки — корень ссылки). |
| `link_id` | `UUIDv7 \| null` | Id ссылки (для общего доступа; нужен уровень доступа `write`). |
| `name` | `string` | Название папки (2–128 символов, буквы). Имя должно быть уникальным в родителе. |

Ответ — созданная папка (`cloud_items`). По ссылке папка создаётся у владельца
ссылки внутри общего поддерева.

## `[cloud]: get folder` — получить содержимое папки

```json
{ "folder_id": null, "link_id": null, "direction": null, "cursor_id": null, "offset": 50 }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `folder_id` | `UUIDv7 \| null` | Id папки (корень облака, если не передан). |
| `link_id` | `UUIDv7 \| null` | Id ссылки (для общего доступа). |

Ответ:

```json
{
  "folders": [],
  "files": [],
  "has_more": false,
  "access_level": "owner",
  "owner_user_id": "UUIDv7"
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `folders` | `array` | Подпапки (записи `cloud_items`, всегда сверху). |
| `files` | `array` | Файлы: `item_id`, `parent_id`, `name`, `created_at` + данные файла (`file_name`, `mime_type`, `size`, `metadata`, `token`). |
| `has_more` | `boolean` | Есть ли ещё файлы для подгрузки. |
| `access_level` | `"owner" \| "read" \| "write"` | Уровень доступа. |
| `owner_user_id` | `UUIDv7` | Id владельца облака. |

## `[cloud]: get upload file url` — получить URL для загрузки файла

```json
{ "folder_id": null, "link_id": null, "file_name": "photo.jpg", "mime_type": "image/jpeg", "size": 1024000 }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `folder_id` | `UUIDv7 \| null` | Id папки, в которую загружается файл. |
| `link_id` | `UUIDv7 \| null` | Id ссылки (нужен уровень доступа `write`). |
| `file_name` | `string` | Оригинальное имя файла. Расширение проверяется по white-листу. |
| `mime_type` | `string` | MIME-тип файла; сверяется с расширением. |
| `size` | `number \| null` | Размер файла в байтах (сохраняется в `documents.size`). |

Ответ содержит **только оригинал** — производные ассеты создаст сервер
при сохранении:

```json
{
  "targets": [
    {
      "path": "cloud/attaches/<user_id>/<uuid>/<uuid>.jpg",
      "kind": "original",
      "url": "https://...",
      "fields": { "key": "...", "Policy": "..." },
      "mime_type": "image/jpeg",
      "max_size": 524288000
    }
  ],
  "document_id": "UUIDv7",
  "folder_id": "UUIDv7 | null"
}
```

Клиент загружает файл `POST`-ом на `target.url` по подписанной политике (как
описано в [руководстве по файлам](../../guides/upload.md)), после чего вызывает
`[cloud]: save file`. Размер и MIME сервер узнаёт из события S3 и проверяет
перед сохранением.

## `[cloud]: save file` — сохранить загруженный файл

```json
{ "folder_id": null, "link_id": null, "document_id": "UUIDv7" }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `folder_id` | `UUIDv7 \| null` | Id папки из `get upload file url`. |
| `link_id` | `UUIDv7 \| null` | Id ссылки из `get upload file url`. |
| `document_id` | `UUIDv7` | Id документа из `get upload file url`. |

Ответ: `{ "item": "cloud_items", "file": "данные файла с token" }`.

Вызывается после загрузки оригинала: сервер проверяет оригинал, генерирует
производные ассеты и отвечает готовыми данными — ожидание обработки может
занять до ~100 секунд, таймаут запроса должен быть **не меньше 120
секунд**. Повторный вызов идемпотентен.

## `[cloud]: remove folder` — удалить папку

```json
{ "item_id": "UUIDv7", "link_id": null }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `item_id` | `UUIDv7` | Id папки. |
| `link_id` | `UUIDv7 \| null` | Id ссылки (для общего доступа; нужен уровень доступа `write`; корень ссылки удалить нельзя). |

Папка удаляется вместе со всем содержимым (рекурсивно, мягкое удаление).
Ответ: `{ "item_id": "UUIDv7" }`.

## `[cloud]: remove file` — удалить файл

```json
{ "item_id": "UUIDv7", "link_id": null }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `item_id` | `UUIDv7` | Id файла. |
| `link_id` | `UUIDv7 \| null` | Id ссылки (для общего доступа; нужен уровень доступа `write`; корень ссылки удалить нельзя). |

Ответ: `{ "item_id": "UUIDv7" }`.

## `[cloud]: create share link` — создать ссылку (общий доступ)

```json
{ "item_id": "UUIDv7", "user_ids": [], "access_level": "read", "expires_at": null }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `item_id` | `UUIDv7` | Id папки или файла. |
| `user_ids` | `array` | Id пользователей, которым доступна ссылка (пусто — доступ всем по ссылке). |
| `access_level` | `"read" \| "write"` | Уровень доступа (по умолчанию `read`). |
| `expires_at` | `string \| null` | Дата истечения срока (ISO), например `2026-12-31T23:59:59Z`. |

Ответ — созданная ссылка (`cloud_share_links`), содержит значение `link` для передачи.

## `[cloud]: get share links` — список своих ссылок

```json
{ "item_id": null }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `item_id` | `UUIDv7 \| null` | Если передан — ссылки только на этот элемент. |

Ответ — массив ссылок (с `item_type` и `item_name`).

## `[cloud]: get share link info` — информация о ссылке (превью)

```json
{ "link": "nanoid" }
```

Ответ:

```json
{
  "link": { "id": "UUIDv7", "link": "nanoid", "owner_user_id": "UUIDv7", "item_id": "UUIDv7", "item_type": "folder", "access_level": "read", "expires_at": null, "created_at": "ISO" },
  "item": { "id": "UUIDv7", "item_type": "folder", "name": "Документы", "parent_id": null, "document_id": null },
  "owner": { "user_id": "UUIDv7", "first_name": "Иван", "last_name": "Петров" },
  "members": ["UUIDv7"]
}
```

## `[cloud]: open share link` — открыть ссылку

```json
{ "link": "nanoid", "folder_id": null, "direction": null, "cursor_id": null, "offset": 50 }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `link` | `string` | Значение ссылки. |
| `folder_id` | `UUIDv7 \| null` | Папка внутри общего поддерева (навигация). |

Ссылка проверяется (срок действия, удаление, выбранные пользователи) и
сохраняется у пользователя как «Доступное для меня» (кроме открытия владельцем).

Ответ для папки — содержимое (как в `[cloud]: get folder`) + `link`, `item`, `owner`.
Ответ для файла — `{ "link", "item", "owner", "file": "данные файла с token", "access_level" }`.

## `[cloud]: get available links` — список «Доступное для меня»

```json
{}
```

Ответ — массив ссылок, открытых и сохранённых пользователем
(`link_id`, `link`, `access_level`, `expires_at`, `opened_at`, `item_id`, `item_type`, `item_name`, `owner_user_id`, `owner_first_name`, `owner_last_name`).

## `[cloud]: remove share link` — отозвать свою ссылку

```json
{ "link_id": "UUIDv7" }
```

Ответ: `{ "link_id": "UUIDv7" }`.

## `[cloud]: remove available link` — удалить из «Доступное для меня»

```json
{ "link_id": "UUIDv7" }
```

Ответ: `{ "link_id": "UUIDv7" }`.
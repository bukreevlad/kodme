# main — папки

События раздела `[main]`. Папки используются для группировки каналов в интерфейсе.
Объект папки — [Folder](../../objects/folder.md).

## `[main]: get folders` — список папок

```json
{ "direction": "next", "cursor_id": null, "offset": 35 }
```

Ответ — массив [Folder](../../objects/folder.md) **и** поле `has_more: boolean` — есть ли продолжение в сторону `direction` (для первой загрузки — есть ли продолжение после страницы).

## `[main]: create folder` — создание папки

```json
{ "name": "Работа" }
```

`name` — `^[\p{sc=Cyrillic}\p{sc=Common}\p{sc=Latin}]{2,128}$`.

Ответ — папка (объект [Folder](../../objects/folder.md)).

## `[main]: remove folder` — удаление папки

```json
{ "folder_id": "UUIDv7" }
```

Ответ — пустой.

## `[main]: move channel to folder` — добавить канал в папку

```json
{ "channel_id": "UUIDv7", "main_folder_id": "UUIDv7" }
```

Ответ — пустой.

## `[main]: unmove channel from folder` — убрать канал из папки

```json
{ "channel_id": "UUIDv7", "main_folder_id": "UUIDv7" }
```

Ответ — пустой.
# Общие объекты

Объекты, возвращаемые сервером в callback-ответах и push-событиях.

## Соглашения

- **Id** — `UUIDv7` (`маленькими буквами`).
- **Дата/время** — ISO 8601 (`2026-09-21T12:34:56.789Z`).
- **Null** — поле отсутствует (не «0», не пустая строка), если явно не указано иное.
- **Токенизированный файл** — объект [File](./file.md); токен истекает (по умолчанию
  несколько минут) и подлежит обновлению через HTTP
  `GET /api/v1/storage/:document` (см. [http/../storage](../http/storage.md)).
- В объектах, связанных с пользователем, поле `avatar` — токенизированный файл или `null`.

## Объекты

| Объект | Описание | Где встречается |
| --- | --- | --- |
| [User](./user.md) | Пользователь (клиент или бот). | `[user]`, `[contact]`, `[search]`, диалоги. |
| [Channel](./channel.md) | Канал: диалог, группа, канал, тема, избранное, чаты. | `[channel]`, `[group]`, `[dialog]`, `[search]`. |
| [Message](./message.md) | Сообщение. | `[message]`, push `[message]: *`. |
| [Comment](./comment.md) | Комментарий под постом сообщества. | `[comment]`, push `[comment]: *`. |
| [Reaction](./reaction.md) | Реакция на сообщение или комментарий. | `[message]: send reaction`, `[comment]: send reaction`, `get reactions`. |
| [File](./file.md) | Токенизированный файл/документ. | вложения, аватары, облако. |
| [Invite](./invite.md) | Приглашение-ссылка. | `[invite]`, `[channel]: create invite`, `[broadcast]`, `[meet]`. |
| [Folder](./folder.md) | Папка каналов. | `[main]`. |
| [Session](./session.md) | Сессия устройства. | `[session]: get sessions`. |
| [Bot](./bot.md) | Бот. | `[bot]`, `[bots-apps]`, `[search]`. |
| [Broadcast](./broadcast.md) | Трансляция. | `[broadcast]`. |
| [Meet](./meet.md) | Конференция. | `[meet]`. |
| [Theme](./theme.md) | Тема оформления. | `[theme]`. |
| [StickerPak](./stickerpak.md) | Пак стикеров. | `[sticker]`. |
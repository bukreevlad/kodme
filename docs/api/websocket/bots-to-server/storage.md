# storage — обработка файлов

События раздела `[storage]` для соединения бота отсутствуют: бот загружает
файлы через события своих разделов —

`[bot]: get upload avatar url`, `[broadcast]: get upload thumb url`,
`[message]: get upload attach url` — и сохраняет их соответствующими
`save`-событиями. Подготовка загрузки, метадата, цели `targets[]` и ошибки —
общие для всех каналов, см. [руководство по файлам](../../guides/upload.md) и
[хранилище у клиента](../client-to-server/storage.md).
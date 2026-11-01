# События сервера (S2C, push)

Сервер самостоятельно рассылает события соединениям, подписанным на комнаты
(см. [топики в connection.md](../../connection.md)). Формат push-кадра:

```json
{
  "type": "event",
  "event": "[domain]: action",
  "data": { ... },
  "timestamp": "2026-09-21T12:34:56.789Z"
}
```

Push-кадры не имеют `callbackId` и не требуют ответа.

## Доставка

| Куда | Что приходит |
| --- | --- |
| `user::<user_id>` | Личные события: сообщения диалогов (`тип 1, 5, 8`), статусы онлайн, новые/удалённые каналы, прочтения в диалогах. |
| `channel::<channel_id>` | События каналов/групп: сообщения (`тип 2, 3, 4, 6, 7`), обновления канала, typing, участники. |
| `bot::<bot_id>` | Сообщения и формы ботов. |
| `broadcast::<cast_id>` | Обновления статуса трансляции (комната подписывается событием `[broadcast]: open`). |
| `cast_online_chat::<cast_id>` | Сообщения чата онлайн-трансляции (`тип 7`). |
| `meet::<meet_id>` | Вход/выход участников конференции (комната подписывается через `[meet]: open`). |

Часть событий (`[call]: *`) доставляется **на конкретное
соединение** собеседника, а не через комнату — они описаны в [calls.md](./calls.md).

События, получаемые **самим ботом** через его соединение `/api/v1/wss/bot`
(`[message]: new / update / click button`, `[form]: click button`),
описаны в [bots-to-server](../bots-to-server/README.md).

## Список событий

| Событие | Страница |
| --- | --- |
| `[message]: new`, `[message]: update`, `[message]: remove`, `[message]: clear history` | [messages.md](./messages.md) |
| `[comment]: new`, `[comment]: update`, `[comment]: remove`, `[comment]: update post commenting` | [comments.md](./comments.md) |
| `[comment-member]: update last viewed comment` | [comments-members.md](./comments-members.md) |
| `[channel]: new`, `[channel]: update`, `[channel]: remove`, `[channel]: user typing` | [channels.md](./channels.md) |
| `[channel-member]: typing status`, `[channel-member]: update last viewed message`, `[channel-member]: update participant viewed message` | [channels-members.md](./channels-members.md) |
| `[user]: online status` | [users.md](./users.md) |
| `[broadcast]: update` | [broadcasts.md](./broadcasts.md) |
| `[meet]: user enter`, `[meet]: user exit` | [meets.md](./meets.md) |
| `[bot][form]: new / update / close / replace` | [bots.md](./bots.md) |
| `[call]: incoming / accept / decline / hangup / sdp` | [calls.md](./calls.md) |

Прогресс загрузки файлов **не пушится**: шкалу клиент считает сам из своих
XHR-запросов к S3, сервер хранит только отметки
жизненного цикла загрузки (см. [руководство по файлам](../../guides/upload.md)).
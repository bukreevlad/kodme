# События клиента (C2S)

Формат:

```json
{
  "type": "event",
  "event": "[domain]: action",
  "data": { ... },
  "callbackId": "1"
}
```

Ответ приходит callback-кадром (см. [connection.md](../../connection.md)). Если `callbackId` не указан — ответ не приходит.

> События **отдельного соединения бота** (`/api/v1/wss/bot`) описаны в
> [bots-to-server](../bots-to-server/README.md).

Список доменов:

- [messages.md](./messages.md) — сообщения, реакции, вложения, кнопки.
- [comments.md](./comments.md) — комментарии под постами сообществ, реакции, вложения.
- [comments-members.md](./comments-members.md) — позиция возврата в ветку комментариев.
- [channels.md](./channels.md) — открытие каналов, настройки, инвайты.
- [channels-members.md](./channels-members.md) — подписки, прочитанные, typing.
- [users.md](./users.md) — профиль и настройки.
- [main.md](./main.md) — папки.
- [contacts.md](./contacts.md) — контакты.
- [sessions.md](./sessions.md) — сессии, push.
- [security.md](./security.md) — 2FA (TOTP) и ключи доступа (Passkey).
- [search.md](./search.md) — поиск.
- [dialogs.md](./dialogs.md) — личные диалоги.
- [groups.md](./groups.md) — группы.
- [groups-topics.md](./groups-topics.md) — темы групп.
- [channel-profile.md](./channel-profile.md) — медиа канала.
- [invites.md](./invites.md) — приглашения.
- [broadcasts.md](./broadcasts.md) — трансляции.
- [broadcasts-members.md](./broadcasts-members.md) — участники трансляций.
- [meets.md](./meets.md) — конференции.
- [meets-members.md](./meets-members.md) — участники конференций.
- [calls.md](./calls.md) — звонки (LiveKit).
- [secret-chats.md](./secret-chats.md) — секретные чаты (сигналинг, присутствие).
- [secret-calls.md](./secret-calls.md) — секретные звонки (сигналинг).
- [bots.md](./bots.md) — боты.
- [bots-apps.md](./bots-apps.md) — мини-приложения ботов.
- [themes.md](./themes.md) — темы.
- [stickers.md](./stickers.md) — стикер-паки (паки, стикеры, подписки).
- [storage.md](./storage.md) — файлы.
- [cloud.md](./cloud.md) — личное облако (папки, файлы, ссылки).
- [system.md](./system.md) — служебные, админ.
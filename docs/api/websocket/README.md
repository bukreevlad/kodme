# WebSocket API

Основной API платформы. Соединение: `wss://kodme.ru/api/v1/wss/client`.
Описание транспорта, кадров и комнат — в [connection.md](../connection.md).

## Два потока событий

- **[client-to-server](./client-to-server/README.md)** — события от клиента серверу (`C2S events`). Все имеют вид `[domain]: action`, принимают `data` и, при указании `callbackId`, возвращают ответ.
- **[server-to-client](./server-to-client/README.md)** — события сервера клиенту (`S2C events`, push). Сервер сам рассылает их подписанным соединениям.

## Отдельное соединение бота

Помимо клиентского соединения есть выделенный роут `/api/v1/wss/bot` для серверной
логики ботов — см. **[bots-to-server](./bots-to-server/README.md)**. Бот управляет
своими настройками и сообщениями через собственные C2S-события
и получает действия пользователей отдельным набором S2C-событий.

## Соглашения

### Данные

- Все действия выполняются от имени **текущего авторизованного пользователя** — его идентификатор нигде в `data` передавать не нужно.
- Поля, не переданные клиентом, получают значения по умолчанию, указанные в описании метода.
- Лишние поля в `data` игнорируются.
- `null`-значения в ответах означают отсутствие данных (не «0»).

### Пагинация списков

Списки загружаются порциями на основе id строк (UUIDv7):

| Поле | Тип | Описание |
| --- | --- | --- |
| `direction` | `string` | `"prev"` — более старые записи (вниз), `"next"` — более новые (вверх). Если не указано — с самого начала (как `"next"`). |
| `cursor_id` | `UUIDv7 \| null` | id записи, относительно которой загружается порция. |
| `offset` | `int` | Размер порции. По умолчанию и ограничения — у каждого метода (обычно 35 или 100, диапазон 1–100; у приглашений — 1–300). |

Каждый следующий запрос передаёт `cursor_id` = id последней записи предыдущей порции
(для `"prev"` — первой).

### Права

Действия, доступные не всем участникам (владельцы, модераторы), помечены в описании
методов пометками: *только владелец*, *только модератор*, *только участник* и т.п.
При нехватке прав сервер возвращает `ACCESS_DENIED`.

## Домены

| Раздел | События |
| --- | --- |
| [messages](./client-to-server/messages.md) | Сообщения, реакции, вложения, кнопки. |
| [channels](./client-to-server/channels.md) | Каналы (тип 3): создание, настройки, инвайты. |
| [channels-members](./client-to-server/channels-members.md) | Подписки, уведомления, прочитанные сообщения, typing. |
| [users](./client-to-server/users.md) | Профиль, настройки, приватность. |
| [main](./client-to-server/main.md) | Папки. |
| [contacts](./client-to-server/contacts.md) | Контакты. |
| [sessions](./client-to-server/sessions.md) | Сессии и push-подписки. |
| [security](./client-to-server/security.md) | Двухфакторная авторизация (TOTP), ключи доступа (Passkey). |
| [search](./client-to-server/search.md) | Поиск. |
| [dialogs](./client-to-server/dialogs.md) | Личные диалоги. |
| [groups](./client-to-server/groups.md) | Группы, модераторы, темы. |
| [groups-topics](./client-to-server/groups-topics.md) | Темы групп. |
| [channel-profile](./client-to-server/channel-profile.md) | Медиа и ссылки канала. |
| [invites](./client-to-server/invites.md) | Приглашения. |
| [broadcasts](./client-to-server/broadcasts.md) | Трансляции. |
| [broadcasts-members](./client-to-server/broadcasts-members.md) | Участники трансляций. |
| [meets](./client-to-server/meets.md) | Конференции. |
| [meets-members](./client-to-server/meets-members.md) | Участники конференций. |
| [calls](./client-to-server/calls.md) | Звонки (WebRTC). |
| [bots](./client-to-server/bots.md) | Боты. |
| [bots-apps](./client-to-server/bots-apps.md) | Мини-приложения ботов. |
| [themes](./client-to-server/themes.md) | Темы оформления. |
| [storage](./client-to-server/storage.md) | Обработка файлов. |
| [comments](./client-to-server/comments.md) | Комментарии под постами сообществ, реакции, вложения. |
| [comments-members](./client-to-server/comments-members.md) | Позиция возврата в ветку комментариев. |
| [system](./client-to-server/system.md) | Служебные (ping, админ). |
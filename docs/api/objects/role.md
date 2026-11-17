# Role / Permission — роли и права

Роли и права — модель разрешений платформы. Пользователь или бот получают
платформенную роль (поле [`role_id` объекта User](./user.md); у ботов —
роль `bot`), а в конкретном
канале (сообществе, группе, теме) — канальные роли, назначенные на пару
«пользователь + канал». Права действуют только через роль: отдельных
персональных флагов прав у пользователя нет.

## Role — роль

```json
{
  "id": "UUIDv7",
  "name": "channel_moderator_pin",
  "scope": "channel",
  "description": "Модератор: закрепление сообщений",
  "is_default": false
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `id` | `UUIDv7` | Id роли. |
| `name` | `string` | Имя роли, уникальное в пределах `scope`. |
| `scope` | `"channel" \| "platform"` | Канальная роль действует в канале, где назначена; платформенная — на всей платформе. |
| `description` | `string \| null` | Описание роли. |
| `is_default` | `boolean` | Роль по умолчанию в своём `scope`: платформенная назначается пользователю при регистрации. |

## Permission — право

```json
{
  "code": "messages.delete",
  "module": "messages",
  "name": "Удаление чужих",
  "description": "Удаление сообщений других участников"
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `code` | `string` | Код права — уникальный идентификатор. |
| `module` | `string` | Модуль платформы, к которому относится право. |
| `name` | `string` | Название права. |
| `description` | `string \| null` | Описание права. |

## Платформенные роли и срезы

| Роль | Кому назначается | Срез |
| --- | --- | --- |
| `user` (`is_default`) | человек при регистрации | базовый срез + полные списки |
| `admin` | администратор | все права |
| `bot` | бот при создании | базовый срез, **без** `list_all` |

Базовый срез: `channels.create`, `channels.manage`, `meets.create`,
`broadcasts.create`, `streams.publish` — создание каналов, групп и тем,
управление ими, создание конференций и трансляций (чаты сущностей
создаются вместе с ними) и вещание своих трансляций.

Полные списки (`meets.list_all`, `broadcasts.list_all`) есть только у
`user` и `admin`: без права список конференций и трансляций субъекта —
только созданные им (у бота — всегда только свои).

### Права и исполняющие их события

Платформенное право — **необходимое условие поверх обычных правил**:
права «на создание» достаточно сам по себе, а для действий «управление»
и «удаление» субъект должен быть ещё и создателем сущности. Права без
владения и владение без права доступа не дают.

| Право | События, требующие права |
| --- | --- |
| `channels.create` | создание: `[channel]: create`, `[group]: create`, `[group]: topic create` |
| `channels.manage` | управление каналом: `[channel]: get settings`, `[channel]: save settings`, `[channel]: save link`, `[channel]: save avatar`, `[channel]: remove avatar`, `[channel]: get upload avatar url`, `[channel]: remove`; управление группой: `[group]: get settings`, `[group]: save settings`, `[group]: save link`, `[group]: save avatar`, `[group]: remove avatar`, `[group]: get upload avatar url`, `[group]: remove`, `[group]: add moderator`, `[group]: remove moderator`, `[group]: save moderator settings`; управление темой: `[group-topic]: save settings`, `[group-topic]: save avatar`, `[group-topic]: remove avatar`, `[group-topic]: get upload avatar url`, `[group-topic]: remove` |
| `meets.create` | создание: `[meet]: create` |
| `meets.manage` | управление встречей: `[meet]: get settings`, `[meet]: save settings`, `[meet]: remove`, `[meet]: save thumb`, `[meet]: remove thumb`, `[meet]: get upload thumb url`, `[meet]: mute participant`, `[meet]: mute all participants`, `[meet]: remove participant`, `[meet]: set focus`, `[meet]: set layout`, `[meet]: add cast to meet`, `[meet]: remove cast from meet`, `[meet]: create invite`, `[meet]: get invites`, `[meet]: remove invite` |
| `broadcasts.create` | создание: `[broadcast]: create` |
| `broadcasts.manage` | управление трансляцией: `[broadcast]: get settings`, `[broadcast]: save settings`, `[broadcast]: remove`, `[broadcast]: save thumb`, `[broadcast]: remove thumb`, `[broadcast]: get upload thumb url`, `[broadcast]: create invite`, `[broadcast]: get invites`, `[broadcast]: remove invite` |

Назначение и удаление модераторов группы (`[group]: add moderator`,
`[group]: remove moderator`, `[group]: save moderator settings`) —
дополнительно только для создателя группы.

Инвайт-ссылки канала и группы (создание, список, отзыв) — канальное
право `members.invite` (см. «Модераторские роли канала»): доступны
создателю сущности либо модератору с этим правом — у бота это работает
так же, как у человека. Инвайт-ссылки встреч и трансляций требуют
`meets.manage` / `broadcasts.manage` и доступны только создателю
сущности.

## Назначение роли

```json
{ "user_id": "UUIDv7", "role_id": "UUIDv7", "channel_id": "UUIDv7" }
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `user_id` | `UUIDv7` | Кому назначена роль. |
| `role_id` | `UUIDv7` | Какая роль назначена ([Role](#role--роль)). |
| `channel_id` | `UUIDv7 \| null` | Канал назначения; `null` — платформенное назначение. |

> Платформенная роль живёт в поле `users.role_id`; назначения
> `_role_assignments` используются для канальных ролей.

## Модераторские роли канала

Модератор канала — пользователь, которому назначена любая роль
`channel_moderator_*` этого канала. Каждая узкая роль даёт одно право;
полный набор прав — это все узкие роли сразу (они набираются галочками
при создании модератора):

| Роль | Права |
| --- | --- |
| `channel_moderator_delete` | `messages.delete` |
| `channel_moderator_clean` | `messages.clean` |
| `channel_moderator_post` | `messages.post` |
| `channel_moderator_restrict` | `members.restrict` |
| `channel_moderator_invite` | `members.invite` |
| `channel_moderator_pin` | `messages.pin` |
| `channel_member` | прав нет — участник по умолчанию (`is_default`) |

Канальные роли наследуются темой от своей родительской группы: назначение в
группе действует и в её темах.

## Чтение прав участника

Явного запроса «права участника в канале» нет — они видны по косвенным
полям в ответах:

- `is_moderator: boolean` — есть ли у пользователя модераторская роль канала:
  в элементах `[channel-member]: get members`, в ответах
  `[group]: get moderators` и `[group]: get moderator settings`, а также
  у автора в объектах [Message](./message.md) и [Comment](./comment.md);
- `can_*: boolean` — фактический набор прав из ролей: в ответах
  `[group]: get moderators` и `[group]: get moderator settings` (права
  модератора) и в данных канала (права текущего пользователя):

| Поле | Право |
| --- | --- |
| `can_deleted_message` | `messages.delete` |
| `can_clean_messages` | `messages.clean` |
| `can_posting_messages` | `messages.post` |
| `can_restrict_members` | `members.restrict` |
| `can_invite_users` | `members.invite` |
| `can_pin_messages` | `messages.pin` |

Изменить права модератора можно событиями `[group]: add moderator` и
`[group]: save moderator settings` (см. [groups](../websocket/client-to-server/groups.md)).

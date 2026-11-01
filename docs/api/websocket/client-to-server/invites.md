# invites — приглашения

События раздела `[invite]`. Объект приглашения — [Invite](../../objects/invite.md).

## `[invite]: get info` — информация по ссылке-приглашению

```json
{ "invite": "invite-link" }
```

`invite` — значение `link` приглашения (канала, трансляции или конференции).

Ответ зависит от `entity_type` приглашения:

**Канал** (`"channel"`):

```json
{
  "channel_id": "UUIDv7",
  "channel_type": 3,
  "display_name": "Название канала",
  "about": null,
  "total_members": 42
}
```

**Трансляция** (`"broadcast"`):

```json
{ "broadcast_id": "UUIDv7", "name": "Трансляция", "about": null }
```

**Конференция** (`"meet"`):

```json
{ "meet_id": "UUIDv7", "name": "Конференция", "about": null }
```

Ошибки: `INVITE_INVALID`, `INVITE_EXPIRED`, `INVITE_MAX_USES_EXHAUSTED`.
# server-to-client: трансляции

События раздела `[broadcast]`. Доставляются в комнату `broadcast::<cast_id>`, на
которую соединение подписывается событием `[broadcast]: open`.

## `[broadcast]: update` — смена статуса трансляции

**Трансляция началась:**

```json
{
  "id": "UUIDv7",
  "is_live": true,
  "started_at": "2026-09-21T12:34:56.789Z"
}
```

**Трансляция завершилась:**

```json
{ "id": "UUIDv7", "is_live": false }
```
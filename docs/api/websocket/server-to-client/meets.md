# server-to-client: конференции

События раздела `[meet]`. Доставляются в комнату `meet::<meet_id>`, на которую
соединение подписывается событием `[meet]: open`.

## `[meet]: user enter` — участник вошёл в конференцию

```json
{
  "meet_id": "UUIDv7",
  "user_id": "UUIDv7",
  "display_name": "Иван Петров",
  "first_name": "Иван",
  "last_name": "Петров",
  "avatar_host_url": null
}
```

`avatar_host_url` — id документа аватарки участника (может отсутствовать).

## `[meet]: user exit` — участник покинул конференцию

```json
{ "meet_id": "UUIDv7", "user_id": "UUIDv7" }
```
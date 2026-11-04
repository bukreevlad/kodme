# server-to-client: секретные звонки

Push-события раздела `[secret-call]`. Доставляются **конкретному устройству**
(`target_device_id`) — так же, как сигнальные события
[секретных чатов](./secret-chats.md).

## `[secret-call]: signal` — WebRTC-сигнал звонка (SDP/ICE)

```json
{
  "call_id": "UUIDv7",
  "from_user_id": "UUIDv7",
  "from_device_id": "UUIDv7",
  "type": "offer",
  "sdp": "v=0…",
  "candidate": null
}
```

| Поле | Тип | Описание |
| --- | --- | --- |
| `call_id` | `string` | Id звонка. |
| `from_user_id` | `string` | Отправитель сигнала. |
| `from_device_id` | `string` | Устройство отправителя (session_id) — адресат ответных сигналов. |
| `type` | `string` | `"offer"` \| `"answer"` \| `"candidate"` \| `"hangup"`. |
| `sdp` | `string \| null` | SDP (для `offer`/`answer`). |
| `candidate` | `string \| null` | ICE-кандидат, JSON-строка (для `candidate`). |

`offer` — это входящий вызов (на каждое онлайн-устройство собеседника);
`hangup` до ответа — отказ/отмена, после ответа — завершение разговора.

# HTTP API

Вспомогательный HTTP-интерфейс. Основной транспорт — [WebSocket](../websocket/README.md).

- Базовый путь: `https://domain.ru/api/v1`
- Только POST (кроме скачивания файлов).

## Обёртка ответов

Большинство эндпоинтов использует ту же обёртку, что и WebSocket-callback'и:

**Успех (200):**

```json
{
  "data": { ... },
  "status": true,
  "timestamp": "2026-09-21T12:34:56.789Z"
}
```

**Ошибка (400 / 401 / 500):** объект ошибки [как в WebSocket](../errors.md):

```json
{
  "status": false,
  "message": "EMAIL_ALREADY_TAKEN :: 126801",
  "type": "error",
  "code": "126801",
  "reason": null,
  "details": null,
  "timestamp": "2026-09-21T12:34:56.789Z"
}
```

## Эндпоинты

| Метод | Путь | Назначение | Страница |
| --- | --- | --- | --- |
| `POST` | `/auth/reg` | Регистрация. | [auth.md](./auth.md) |
| `POST` | `/auth/login` | Вход по паролю (шаг 1). | [auth.md](./auth.md) |
| `POST` | `/auth/confirm` | Подтверждение входа кодом (шаг 2). | [auth.md](./auth.md) |
| `POST` | `/auth/check` | Проверка токена, данные пользователя и сервера. | [auth.md](./auth.md) |
| `POST` | `/auth/refresh` | Обновление access-токена. | [auth.md](./auth.md) |
| `POST` | `/auth/forgot-password/send` | Восстановление пароля: код. | [auth.md](./auth.md) |
| `POST` | `/auth/forgot-password/confirm` | Восстановление пароля: проверка кода. | [auth.md](./auth.md) |
| `POST` | `/auth/forgot-password/set-password` | Восстановление пароля: новый пароль. | [auth.md](./auth.md) |
| `POST` | `/auth/login/qrcode/gen-auth-session` | QR-вход: создать сессию. | [auth.md](./auth.md) |
| `POST` | `/auth/login/qrcode/scanned` | QR-вход: код отсканирован. | [auth.md](./auth.md) |
| `POST` | `/auth/login/qrcode/confirm` | QR-вход: подтверждение с телефона. | [auth.md](./auth.md) |
| `POST` | `/auth/login/qrcode/polling` | QR-вход: опрос статуса. | [auth.md](./auth.md) |
| `POST` | `/auth/passkey/login/begin` | Вход по ключу доступа (Passkey): challenge, шаг 1. | [auth.md](./auth.md) |
| `POST` | `/auth/passkey/login/finish` | Вход по ключу доступа (Passkey): проверка и токены, шаг 2. | [auth.md](./auth.md) |
| `GET` | `/storage/:document` | Скачивание файла. | [storage.md](./storage.md) |
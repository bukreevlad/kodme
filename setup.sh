#!/bin/bash
# ===========================================================================
# Первичная настройка стенда Kodme
#
# Делает два шага:
#   1. Подставляет ваш домен во все конфиги (вместо domain.ru).
#   2. Генерирует уникальные секреты вместо плейсхолдеров __ИМЯ__
#      (пароли БД/Redis, JWT, TURN, S3, LiveKit, SRS).
#
# Запускайте ДО первого `podman-compose up -d`: пароль PostgreSQL применяется
# при первой инициализации базы (initdb) и позже автоматически не меняется.
#
# Использование:
#   ./setup.sh                  # спросит домен и сгенерирует секреты
#   ./setup.sh example.com      # то же, но домен берётся из аргумента
# ===========================================================================
set -e

cd "$(dirname "$0")"

# Файлы, в которых подставляются секреты (плейсхолдеры __ИМЯ__)
SECRET_FILES=(
    "compose.yml"
    "kodme/config.yaml"
    "livekit/livekit.yaml"
    "livekit/ingress.yaml"
    "coturn/turnserver.conf"
)

# --------------------------------------------------------------------------
# Генерация секрета: 32 байта случайных данных в hex
# --------------------------------------------------------------------------
gen_secret() {
    if command -v openssl > /dev/null 2>&1; then
        openssl rand -hex 32
    else
        head -c 32 /dev/urandom | od -An -tx1 | tr -d ' \n'
    fi
}

# --------------------------------------------------------------------------
# Файлы для обработки: все, кроме .git, docs/ и исключений ниже.
# В именах файлов могут быть пробелы — работаем через массив.
# Пересобирается после переименования файлов (см. шаг 1).
# --------------------------------------------------------------------------
load_files() {
    mapfile -t FILES < <(find . -type f \
        ! -path "./.git/*" \
        ! -path "./docs/*" \
        ! -name "README.md" \
        ! -name "LICENSE" \
        ! -name "setup.sh" \
        | sort)
}

load_files

# ==========================================================================
# 1. Домен платформы
# ==========================================================================
DOMAIN="${1:-}"
if [ -z "$DOMAIN" ]; then
    read -rp "🌐 Домен платформы (Enter — оставить domain.ru): " DOMAIN
fi

if [ -n "$DOMAIN" ]; then
    DOMAIN="$(echo "$DOMAIN" | tr '[:upper:]' '[:lower:]')"
    if ! echo "$DOMAIN" | grep -qE '^[a-z0-9]([a-z0-9.-]*[a-z0-9])?$'; then
        echo "❌ Недопустимый домен: $DOMAIN"
        exit 1
    fi

    # Есть ли ещё файлы с исходным доменом (сам этот скрипт не входит в FILES)
    NEED_DOMAIN=0
    for file in "${FILES[@]}"; do
        if grep -q "domain\.ru" "$file"; then
            NEED_DOMAIN=1
            break
        fi
    done

    if [ "$NEED_DOMAIN" -eq 0 ]; then
        echo "ℹ️  Домен уже настроен (domain.ru не найден) — пропускаю."
    else
        # Замена в содержимом: s3.domain.ru, stun:domain.ru и пр. заменяются
        # тем же правилом (вхождение «domain.ru» → ваш домен)
        for file in "${FILES[@]}"; do
            sed -i "s/domain\.ru/$DOMAIN/g" "$file"
        done

        # Переименование конфигов nginx с доменом в имени
        for file in nginx/conf.d/*domain.ru*; do
            [ -e "$file" ] || continue
            mv "$file" "${file//domain.ru/$DOMAIN}"
        done

        # Имена файлов изменились — пересобираем список
        load_files

        echo "✅ Домен подставлен: domain.ru → $DOMAIN"
    fi
else
    echo "ℹ️  Домен не менялся (остался domain.ru)."
fi

# ==========================================================================
# 2. Секреты
# ==========================================================================
PLACEHOLDERS="$(grep -hoE '__[A-Z0-9_]+__' "${SECRET_FILES[@]}" 2>/dev/null | sort -u)"

if [ -z "$PLACEHOLDERS" ]; then
    echo "ℹ️  Плейсхолдеры секретов не найдены — секреты уже настроены."
    echo "   Для ручной генерации значения: openssl rand -hex 32"
else
    COUNT=0
    for p in $PLACEHOLDERS; do
        s="$(gen_secret)"
        for file in "${SECRET_FILES[@]}"; do
            [ -f "$file" ] && sed -i "s/$p/$s/g" "$file"
        done
        COUNT=$((COUNT + 1))
        echo "✅ $p — секрет сгенерирован"
    done
    echo "🔐 Сгенерировано секретов: $COUNT"
fi

# Проверка: не осталось ли незаменённых плейсхолдеров
LEFTOVER=0
for file in "${FILES[@]}"; do
    if grep -q '__[A-Z0-9_]\+__' "$file"; then
        echo "⚠️  Остался незаменённый плейсхолдер: $file"
        LEFTOVER=1
    fi
done
[ "$LEFTOVER" -eq 1 ] && exit 1

# ==========================================================================
# Готово — следующие шаги
# ==========================================================================
echo ""
echo "🎉 Настройка завершена! Дальше:"
echo "   1. Выпустите TLS-сертификаты — см. README.md (раздел «TLS-сертификаты»)"
echo "   2. При необходимости отредактируйте kodme/config.yaml:"
echo "      почта, push-уведомления, администраторы"
echo "   3. podman pull ghcr.io/bukreevlad/kodme:latest"
echo "   4. podman-compose up -d"
echo ""
echo "Подробности — в README.md и Управление.md"

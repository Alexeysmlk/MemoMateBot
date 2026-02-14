# MemoMate

<p align="left">
  <img alt="Laravel" src="https://img.shields.io/badge/Laravel-12-FF2D20?style=flat-square&logo=laravel&logoColor=white">
  <img alt="PHP" src="https://img.shields.io/badge/PHP-8.4-777BB4?style=flat-square&logo=php&logoColor=white">
  <img alt="Docker" src="https://img.shields.io/badge/Docker-Compose-2496ED?style=flat-square&logo=docker&logoColor=white">
  <img alt="PostgreSQL" src="https://img.shields.io/badge/PostgreSQL-17-4169E1?style=flat-square&logo=postgresql&logoColor=white">
  <img alt="Redis" src="https://img.shields.io/badge/Redis-7-DC382D?style=flat-square&logo=redis&logoColor=white">
</p>

Лаконичное Laravel-окружение в Docker: поднял контейнеры и сразу работаешь.

## Содержание
- [Быстрый старт](#быстрый-старт)
- [Стек](#стек)
- [Команды](#команды)
- [Xdebug](#xdebug)
- [Troubleshooting](#troubleshooting)

## Быстрый старт

```bash
cp .env.example .env
docker compose up -d --build
docker compose exec app composer install
docker compose exec app php artisan key:generate
docker compose exec app php artisan migrate
```

Приложение: `http://localhost:8080`

## Стек

| Сервис | Версия | Роль |
|---|---|---|
| PHP-FPM | 8.4 | Выполнение Laravel |
| Nginx | 1.27 | HTTP-сервер |
| PostgreSQL | 17 | База данных |
| Redis | 7 | Кэш, сессии, очереди |
| Composer | 2 | Управление PHP-зависимостями |
| Xdebug | 3 | Отладка кода |

## Команды

```bash
# Статус контейнеров
docker compose ps

# Логи
docker compose logs -f app nginx db redis

# Artisan
docker compose exec app php artisan about

# Composer
docker compose exec app composer require vendor/package

# Остановить контейнеры
docker compose down
```

## Xdebug

- Конфиг: `docker/php/conf.d/xdebug.ini`
- Порт: `9003`
- Для Linux `host.docker.internal` уже добавлен через `extra_hosts` в `compose.yml`

## Troubleshooting

| Проблема | Что сделать |
|---|---|
| `Port is already allocated` | Освободите порт (`8080`, `5432`, `6379`) или измените его в `compose.yml` |
| Laravel не пишет в `storage` | Выполните: `docker compose exec app chmod -R 775 storage bootstrap/cache` |
| Xdebug не ловится IDE | Проверьте, что IDE слушает порт `9003` и выбран корректный path mapping |

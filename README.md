# MemoMate

Уютный Telegram-бот на Laravel, который помогает не забывать важные даты: хранит дни рождения и сам вовремя присылает напоминания 🎂

<p align="left">
  <img alt="Laravel" src="https://img.shields.io/badge/Laravel-12-FF2D20?style=flat-square&logo=laravel&logoColor=white">
  <img alt="PHP" src="https://img.shields.io/badge/PHP-8.4-777BB4?style=flat-square&logo=php&logoColor=white">
  <img alt="Docker" src="https://img.shields.io/badge/Docker-Compose-2496ED?style=flat-square&logo=docker&logoColor=white">
  <img alt="PostgreSQL" src="https://img.shields.io/badge/PostgreSQL-17-4169E1?style=flat-square&logo=postgresql&logoColor=white">
  <img alt="Redis" src="https://img.shields.io/badge/Redis-7-DC382D?style=flat-square&logo=redis&logoColor=white">
</p>

## Технологии

Небольшой и практичный стек для стабильной разработки и запуска ✨

| Технология | Версия | Для чего используется |
|---|---|---|
| Laravel | 12 | Основа приложения и бизнес-логики бота |
| PHP-FPM | 8.4 | Выполняет PHP-код приложения |
| Nginx | 1.27 | Принимает HTTP-запросы и проксирует их в приложение |
| PostgreSQL | 17 | Хранит пользователей, даты и настройки напоминаний |
| Redis | 7 | Используется для кэша, сессий и очередей |
| Docker Compose | актуальный | Поднимает весь проект одной командой |
| Composer | 2 | Устанавливает и обновляет PHP-зависимости |

## Старт

1. Подготовьте окружение:

```bash
cp .env.example .env
```

2. Поднимите dev-стек:

```bash
docker compose -f compose.yml -f compose.dev.yml up -d --build
```

3. Установите зависимости и инициализируйте приложение:

```bash
docker compose -f compose.yml -f compose.dev.yml exec app composer install
docker compose -f compose.yml -f compose.dev.yml exec app php artisan key:generate
docker compose -f compose.yml -f compose.dev.yml exec app php artisan migrate
```

После запуска приложение доступно по адресу: `http://localhost:8080` 🚀

Порты по умолчанию (из `.env.example`):
- App: `FORWARD_APP_PORT=8080`
- PostgreSQL: `FORWARD_DB_PORT=5432`
- Redis: `FORWARD_REDIS_PORT=6379`

## Полезные команды

Самые нужные команды на каждый день:

```bash
make up        # поднять dev-стек
make ps        # проверить статус
make logs      # посмотреть логи
make down      # остановить dev-стек
```

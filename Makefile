COMPOSE=docker compose -f compose.yml

.PHONY: up down build rebuild logs ps shell composer artisan

up:
	$(COMPOSE) up -d

down:
	$(COMPOSE) down

build:
	$(COMPOSE) build app

rebuild:
	$(COMPOSE) up -d --build

logs:
	$(COMPOSE) logs -f app nginx db redis

ps:
	$(COMPOSE) ps

shell:
	$(COMPOSE) exec app sh

composer:
	$(COMPOSE) exec app composer $(cmd)

artisan:
	$(COMPOSE) exec app php artisan $(cmd)

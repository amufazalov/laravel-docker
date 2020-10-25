# Laravel Docker

## Laravel + Nginx + PHP 7.3 + Mysql 5.7 + Redis + XDebug

### Локальная разработка
1. Склонировать существующий проект в папку `./src/`
2. Переименовать `cp .env.example .env`. Установить нужные переменные окружения
3. Переименовать `cp src/.env.example src/.env`. Установить нужные переменные окружения
4. Запустить `bin/start`
5. Выполнить `bin/composer install`
6. Выполнить `bin/composer artisan key:generate`
7. Выполнить `bin/artisan migrate --seed`
8. Выполнить `bin/artisan ide-helper:generate`
9. Выполнить `bin/npm install`
10. Выполнить остальные команды вашего проекта
11. Писать код :)

Запуск artisan-команд в контейнере `bin/artisan command-name`

### Чистая установка (новый проект)
1. Склонировать репозиторий `git clone https://github.com/amufazalov/laravel-docker.git`
2. Выполнить команду `bin/install`
3. Писать код :)

#### Переменные окружения:
Environment variable  | Description                     | Default
--------------------  | -----------                     | -------
MYSQL_HOSTNAME        | MySQL hostname                  | db
MYSQL_USERNAME        | MySQL username                  | root
MYSQL_ROOT_PASSWORD   | MySQL password                  | root
MYSQL_DATABASE        | MySQL database                  | laravel
REDIS_HOST            | Redis                           | redis
VIRTUAL_HOST          | Доменное имя                    | project.test
VIRTUAL_PORT          | Порт                            | 80
SERVER_SSL            | Использование ssl (on/off)      | off
USER_HOME             | Home dir юзера в контейнере     | /var/www/laravel
SERVER_ROOT           | Директория с кодом в контейнере | /var/www/laravel/src
PHP_MEMORY_LIMIT      | Memory limit для php-fpm        | 2G

Данные переменные окружения выставляются для docker-инфраструктуры.
Их можно использовать в переменных окружениях laravel в `src/.env` файле.
Например:
```
...
DB_CONNECTION=mysql
DB_HOST="${MYSQL_HOSTNAME}"
DB_PORT=3306
DB_DATABASE="${MYSQL_DATABASE}"
DB_USERNAME=root
DB_PASSWORD="${MYSQL_ROOT_PASSWORD}"
REDIS_HOST="${REDIS_HOST}"
...
```

### Шаги по регулярному ручному деплою
1. Перевести приложение в режим обслуживания `bin/artisan down`
2. Получить изменения (в папке, `src`) `git pull origin master`
3. Выполнить `bin/composer install --no-dev --no-interaction --optimize-autoloader`
4. Выполнить `bin/artisan optimize:clear`
5. Выполнить `bin/artisan view:clear`
6. Выполнить `bin/artisan migrate`
7. Вывести приложение из режима обслуживания `bin/artisan up`

### Дополнительно о сборке
В папке docker лежит makefile и исходные данные образов. 
Можно конфигурировать как душе угодно, а затем запустить `make build`. 
Данна команда создаст обновленные образы на ваше локальной машине.

#### Вспомогательные скрипты:
Необходимы права на исполнение

* `bin/install` - Загрузка и установка **laravel** последней версии с помощью композера.
* `bin/log` - Просмотр логов (`bin/log <container_name>`)
* `bin/npm` - Работа с npm менеджером (`bin/npm install`)
* `bin/start` - запуск контейнеров
* `bin/stop` - остановка контейнеров
* `bin/down` - уничтожение контейнеров
* `bin/db-backup` - создание дампа текущей БД проекта `dump.sql` в папке `backup`
* `bin/db-recreate` - создание чистой БД
* `bin/db-restore` - импортирует БД `dump.sql` из папки `backup`. И заменяет базовый url на MAGENTO_BASE_URL
* `bin/composer` - работа с композером 
* `bin/x-debug` - вкл / выкл XDebug. Меняет значение переменной PHP_ENABLE_XDEBUG на противоположное и перезапускает контейнеры.

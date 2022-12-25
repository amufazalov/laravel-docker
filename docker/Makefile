IMAGE_CLI := kunrag/laravel-php-8.1-cli
IMAGE_FPM := kunrag/laravel-php-8.1-fpm
IMAGE_NGINX := kunrag/laravel-nginx
IMAGE_REDIS := kunrag/laravel-redis

.PHONY: all
all: build push

.PHONY: build
build: cli fpm nginx

.PHONY: push
push:
	@docker push $(IMAGE_CLI):latest
	@docker push $(IMAGE_FPM):latest
	@docker push $(IMAGE_NGINX):latest

# Make php cli image
.PHONY: cli
cli:
	@docker build -t $(IMAGE_CLI) 8.1-cli

# Make php fpm image
.PHONY: fpm
fpm:
	@docker build -t $(IMAGE_FPM) 8.1-fpm

# Make nginx image
.PHONY: nginx
nginx:
	@docker build -t $(IMAGE_NGINX) nginx

# Make redis image
.PHONY: redis
redis:
	@docker build -t $(IMAGE_REDIS) redis

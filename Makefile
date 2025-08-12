# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aubertra <aubertra@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/08/01 16:53:55 by aubertra          #+#    #+#              #
#    Updated: 2025/08/08 12:20:02 by aubertra         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

WORDPRESS_DATA = /home/data/wordpress
MARIADB_DATA = /home/data/mariadb

all: up

re: clean up

up: build
	docker-compose up -d

build:
	mkdir -p  $(WORDPRESS_DATA)
	mkdir -p $(MARIADB_DATA)
	docker-compose build -d

down:
	docker-compose down -d

start:
	docker-compose start -d

stop:
	docker-compose stop -d

clean:
	docker stop $$(docker ps -qa) || true
	docker rm $$(docker ps -qa) || true
	docker rmi -f $$(docker images -qa) || true
	docker volume rm $$(docker volumes ls -q) || true
	docker network rm $$(docker network ls -q) || true
	rm -rf $(WORDPRESS_DATA) || true
	rm -rf $(MARIADB_DATA) || true

prune: clean
	docker system prune -a --volumes -f


.PHONY: all up build down start stop clean

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

WORDPRESS_DATA = /home/$${USER}/data/wordpress
MARIADB_DATA = /home/$${USER}/data/mariadb

all: up

re: clean up

up: build
	mkdir -p  $(WORDPRESS_DATA)
	mkdir -p $(MARIADB_DATA)
	docker-compose -f ./srcs/docker-compose.yml up -d

build:
	docker-compose -f ./srcs/docker-compose.yml build

down:
	docker-compose -f ./srcs/docker-compose.yml down

start:
	docker-compose -f ./srcs/docker-compose.yml start

stop:
	docker-compose -f ./srcs/docker-compose.yml stop

clean:
	docker stop $$(docker ps -qa) || true
	docker rm $$(docker ps -qa) || true
	docker rmi -f $$(docker images -qa) || true
	docker volume rm $$(docker volumes ls -q) || true
	docker network rm $$(docker network ls -q) || true

prune: clean
	docker system prune -a --volumes -f


.PHONY: all up build down start stop prune re clean

# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aubertra <aubertra@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/07/24 16:04:41 by aubertra          #+#    #+#              #
#    Updated: 2025/07/24 17:28:12 by aubertra         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.21

RUN apk update
RUN apk upgrade

RUN apk add curl
RUN adduser -S -G www-data www-data

RUN apk add php82 php82-mysqli\
	php82-curl php82-fpm\
	php82-phar mariadb-client

RUN ln -s /usr/bin/php82 /usr/bin/php

RUN echo "memory_limit = 256M" >> /etc/php82/php.ini

COPY ./conf/wordpress.sh ./wordpress.sh

RUN chmod +x wordpress.sh

ENTRYPOINT [ "./wordpress.sh"]

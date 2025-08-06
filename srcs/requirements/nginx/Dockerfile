# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aubertra <aubertra@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/07/24 16:04:56 by aubertra          #+#    #+#              #
#    Updated: 2025/07/24 17:56:46 by aubertra         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM debian:bullseye

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get clean

RUN apt-get apt-utils
RUN apt-get install nginx openssl 

RUN mkdir -p /etc/nginx/ssli

RUN openssl req -x509 -nodes \
    -out /etc/nginx/ssl/inception.crt \
    -keyout /etc/nginx/ssl/inception.key \
    -subj "/C=FR/ST=Île-de-France/L=Paris/O=42/OU=42/CN=aubertra.42.fr/UID=aubertra"

COPY ./conf/nginx.conf /nginx.conf

RUN adduser -S -G www-data www-data
RUN mkdir -p /var/www/wordpress
RUN chown -R www-data:www-data /var/www/wordpress

ENTRYPOINT [ "nginx", "-g", "daemon off;"]


# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aubertra <aubertra@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2025/07/24 16:05:22 by aubertra          #+#    #+#              #
#    Updated: 2025/07/24 17:28:21 by aubertra         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

FROM alpine:3.21

RUN apk update
RUN apk upgrade

RUN apk add mariadb mariadb-client

COPY ./conf/mdb_conf.sh /usr/local/bin/mdb_conf.sh

RUN chmod +x /usr/local/bin/mdb_conf.sh


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

FROM debian:bullseye

RUN apt-get -y update
RUN apt-get -y upgrade
RUN apt-get clean

RUN apt-get install apt-utils
	
RUN apt-get install php82 php82-mysqli\
	php82-curl php82-fpm\
	php82-phar mariadb-client

COPY ./conf/wordpress.sh ./wordpress.sh

RUN chmod +x wordpress.sh

ENTRYPOINT [ "./wordpress.sh"]

#!/bin/sh

service mariadb start

sleep 5

mariadb -e "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DB\`;"
mariadb -e "CREATE USER IF NOT EXISTS '$MYSQL_USR'@'%' IDENTIFIED BY '$MYSQL_PASSWRD';"
mariadb -e "GRANT ALL PRIVILEGES ON \`$MYSQL_DB\`.* TO '$MYSQL_USR'@'%';"
mariadb -e "FLUSH PRIVILEGES;"

mariadb-admin -u root -p"$MYSQL_ROOT_PASSWRD" shutdown

exec mariadbd --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'


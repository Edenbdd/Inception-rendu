#!/bin/sh

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

sleep 5

if [ ! -d /var/lib/mysql/mysql ]; then
    echo "Initializing MariaDB data directory..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

mariadb --user=mysql & pid="$!"

# Wait for MariaDB to be ready
echo "⏳ Waiting for MariaDB to be ready...\n"
until mariadb-admin ping -h127.0.0.1 --silent; do
    sleep 1
done
echo "✅ MariaDB is ready and accepting connections.\n" 

wait

mariadb -e "CREATE DATABASE IF NOT EXISTS $MYSQL_DB"
mariadb -e "CREATE USER IF NOT EXISTS $MYSQL_USR IDENTIFIED BY $MYSQL_PASSWRD"
mariadb -e "GRANT ALL PRIVILEGES ON $MYSQL_DB TO $MYSQL_USR"
mariadb -e "FLUSH PRIVILEGES"

mariadb-admin -u root -p$MYSQL_ROOT_PASSWRD shutdown

exec mariadbd --port=3306 --bind-address=0.0.0.0 --datadir='/var/lib/mysql'

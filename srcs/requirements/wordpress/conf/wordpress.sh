#!/bin/sh

#Installing WP CLI

#-O means the file will be saved with the same name as on the server
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/bin/wp

#Getting ready for WP installation
mkdir -p /var/www/wordpress
cd /var/www/wordpress
chmod -R 755 /var/www/wordpress
chown -R www-data:www-data /var/www/wordpress

# Wait for MariaDB to become available
echo "⏳ Waiting for MariaDB to be ready..."
until mysqladmin ping -hmariadb --silent; do
    sleep 1
done
echo "✅ MariaDB is ready!"

#WP installation and set up
wp core download --allow-root

wp core config \
	--dbhost=mariadb:3306\
	--dbname="$MYSQL_DB" \
    	--dbuser="$MYSQL_USR"\
	--dbpass="$MYSQL_PASSWRD"\
	--allow-root

wp core install\
	--url="$DOMAIN_NAME"\
	--title="$WP_TITLE"\
	--admin_user="$WP_ADMIN_USR"\
    	--admin_password="$WP_ADMIN_PASSWRD"\
	--admin_email="$WP_ADMIN_MAIL"\
	--allow-root

wp user create\
	"$WP_USR"\
	"$WP_USR_MAIL"\
	--user_pass="$WP_USR_PASSWRD"\
    	--role="$WP_USR_ROLE"\
	--allow-root

#Config PHP
#make sure php is installed on the VM
sed -i 's|^listen = .*|listen = 9000|' /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php
#-F means it starts in the foreground 
/usr/sbin/php-fpm7.4 -F

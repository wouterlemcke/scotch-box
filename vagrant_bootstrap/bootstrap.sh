#!/usr/bin/env bash

# Update repositories for xdebug
sudo apt-get update
# Install php5-dev for phpize
sudo apt-get -y install php5-dev
sudo pecl install xdebug
echo "zend_extension=/usr/lib/php5/20131226/xdebug.so" >> /etc/php5/apache2/php.ini
echo "; xdebug
xdebug.remote_connect_back = 1
xdebug.remote_enable = 1
xdebug.remote_handler = \"dbgp\"
xdebug.remote_port = 9000
xdebug.var_display_max_children = 512
xdebug.var_display_max_data = 1024
xdebug.var_display_max_depth = 10
xdebug.idekey = \"PHPSTORM\"" >> /etc/php5/apache2/php.ini

# sccs
sudo npm install -global gulp

# install phpmyadmin and give password(s) to installer
# for simplicity I'm using the same password for mysql and phpmyadmin
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/dbconfig-install boolean true"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/app-password-confirm password root"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/admin-pass password root"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/mysql/app-pass password root"
sudo debconf-set-selections <<< "phpmyadmin phpmyadmin/reconfigure-webserver multiselect apache2"
sudo apt-get -y install phpmyadmin

# sed 's#DocumentRoot /var/www/public#DocumentRoot /var/www/app#g' /etc/apache2/sites-available/000-default.conf > /etc/apache2/sites-available/000-default.conf.tmp
# mv /etc/apache2/sites-available/000-default.conf.tmp /etc/apache2/sites-available/000-default.conf

# URL='https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.90.13.deb'; FILE=`mktemp`; wget "$URL" -qO $FILE && dpkg -i $FILE; rm $FILE

# Finally, restart apache
service apache2 restart

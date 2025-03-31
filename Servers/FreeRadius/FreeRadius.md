# FreeRadius Debian 12
```html
apt --no-install-recommends install mariadb-server
mariadb-secure-installation
mariadb -u root -p

CREATE DATABASE raddb;                                                                                                  ### example
CREATE USER 'radius'@'localhost' IDENTIFIED BY 'STR0NGP@SSW0RD';
GRANT ALL ON raddb.* TO 'radius'@'localhost';
FLUSH PRIVILEGES;
EXIT;

systemctl enable mariadb
apt install freeradius-mysql mariadb-client -y
cd /etc/freeradius/mods-config/sql/main/mysql/
mariadb -u radiususer -p raddb < schema.sql
```
```html
nano /etc/freeradius/mods-available/sql

dialect = "mysql"
driver = "rlm_sql_${dialect}"
...
server = "localhost"
port = 3306
login = "radius"
password = "STR0NGP@SSW0RD"
radius_db = "raddb"
```
```html
sed -Ei '/^[\t\s#]*tls\s+\{/, /[\t\s#]*\}/ s/^/#/' /etc/freeradius/mods-available/sql
```
```html
nano /etc/freeradius/mods-available/sql

read_clients = yes
client_table = "nas"
```
```html
ln -s /etc/freeradius/mods-available/sql /etc/freeradius/mods-enabled/
systemctl enable freeradius
systemctl restart freeradius
```
# DaloRadius
```html
apt --no-install-recommends install apache2 php libapache2-mod-php \
 php-mysql php-zip php-mbstring php-common php-curl \
 php-gd php-db php-mail php-mail-mime \
 mariadb-client freeradius-utils rsyslog
 
apt --no-install-recommends install git
cd /var/www
git clone https://github.com/lirantal/daloradius.git
mkdir -p /var/log/apache2/daloradius/{operators,users}
```
```html
cat <<EOF >> /etc/apache2/envvars
# daloRADIUS users interface port
export DALORADIUS_USERS_PORT=8000

# daloRADIUS operators interface port
export DALORADIUS_OPERATORS_PORT=80

# daloRADIUS package root directory
export DALORADIUS_ROOT_DIRECTORY=/var/www/daloradius 

# daloRADIUS administrator's email
export DALORADIUS_SERVER_ADMIN=admin@daloradius.local
EOF
```
```html
cat <<EOF > /etc/apache2/ports.conf

# daloRADIUS
Listen \${DALORADIUS_USERS_PORT}
Listen \${DALORADIUS_OPERATORS_PORT}
EOF
```
```html
cat <<EOF > /etc/apache2/sites-available/operators.conf
<VirtualHost *:\${DALORADIUS_OPERATORS_PORT}>
 ServerAdmin \${DALORADIUS_SERVER_ADMIN}
 DocumentRoot \${DALORADIUS_ROOT_DIRECTORY}/app/operators
  
 <Directory \${DALORADIUS_ROOT_DIRECTORY}/app/operators>
 Options -Indexes +FollowSymLinks
 AllowOverride All
 Require all granted
 </Directory>

 <Directory \${DALORADIUS_ROOT_DIRECTORY}>
 Require all denied
 </Directory>

 ErrorLog \${APACHE_LOG_DIR}/daloradius/operators/error.log
 CustomLog \${APACHE_LOG_DIR}/daloradius/operators/access.log combined
</VirtualHost>
EOF
```
```html
cat <<EOF > /etc/apache2/sites-available/users.conf
<VirtualHost *:\${DALORADIUS_USERS_PORT}>
  ServerAdmin \${DALORADIUS_SERVER_ADMIN}
  DocumentRoot \${DALORADIUS_ROOT_DIRECTORY}/app/users

  <Directory \${DALORADIUS_ROOT_DIRECTORY}/app/users>
    Options -Indexes +FollowSymLinks
    AllowOverride None
    Require all granted
  </Directory>

  <Directory \${DALORADIUS_ROOT_DIRECTORY}>
    Require all denied
  </Directory>

  ErrorLog \${APACHE_LOG_DIR}/daloradius/users/error.log
  CustomLog \${APACHE_LOG_DIR}/daloradius/users/access.log combined
</VirtualHost>
EOF
```
```html
cd /var/www/daloradius/app/common/includes
cp daloradius.conf.php.sample daloradius.conf.php
chown www-data:www-data daloradius.conf.php 
chmod 664 daloradius.conf.php
chown www-data:www-data /var/www/daloradius/contrib/scripts/dalo-crontab

nano daloradius.conf.php

...  
$configValues['FREERADIUS_VERSION'] = '3';
$configValues['CONFIG_DB_ENGINE'] = 'mysqli';
$configValues['CONFIG_DB_HOST'] = 'localhost';
$configValues['CONFIG_DB_PORT'] = '3306';
$configValues['CONFIG_DB_USER'] = 'radius';
$configValues['CONFIG_DB_PASS'] = 'STR0NGP@SSW0RD';
$configValues['CONFIG_DB_NAME'] = 'raddb'; 
...


cd /var/www/daloradius/
mkdir -p var/{log,backup}
chown -R www-data:www-data var 
chmod -R 775 var


cd /var/www/daloradius/contrib/db
mariadb -u radiususer -p raddb < fr3-mariadb-freeradius.sql
mariadb -u radiususer -p raddb < mariadb-daloradius.sql

a2dissite 000-default.conf 
a2ensite operators.conf users.conf
systemctl enable apache2
systemctl restart apache2
chmod 755 /var/log/freeradius/

default: administrator/radius
```
```html
#Juniper >22R1
add /etc/freeradius/users:
DEFAULT
        Message-Authenticator = 0
```
```html
/var/www/daloradius/app/operators/mng-rad-nas-new.php (add exec string)                                                 ### reboot freeradius after add/edit/delete NAS
$logAction .= "Successfully added nas [$nashost] on page: ";
                exec('sudo systemctl restart freeradius.service &');
/var/www/daloradius/app/operators/mng-rad-nas-edit.php (add exec string)
$logAction .= "Successfully updated attributes for nas [$nashost] on page: ";
                exec('sudo systemctl restart freeradius.service &');
/var/www/daloradius/app/operators/mng-rad-nas-del.php
$logAction .= "Successfully updated attributes for nas [$nashost] on page: ";
                exec('sudo systemctl restart freeradius.service &');

nano /etc/sudoers
www-data ALL=(ALL) NOPASSWD: /usr/bin/systemctl restart freeradius.service
```
# Troubleshooting:
```html
freeradius -X
```
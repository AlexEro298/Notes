# facileManager:
**https://github.com/WillyXJ/facileManager**

```html
dnf install php mysql

php = 8.0.30-2.el9
mysql = 8.0.41-2.el9



# cd /opt
# wget http://facilemanager.com/download/facilemanager-complete-3.4.2.tar.gz
# tar -zxvf facilemanager-complete-2.2.1.tar.gz
mysql_secure_installation
mysql –u root –p
CREATE DATABASE dns;
CREATE USER 'dnsadmin'@'localhost' IDENTIFIED BY 'Password';
GRANT ALL PRIVILEGES ON dns.* TO 'dnsadmin'@'localhost';
flush privileges;
quit
# cp -r /opt/facileManager/server/ /var/www/html/dnsadmin
# chown www-data -R /var/www/html/dnsadmin
# chmod 755 -R /var/www/html/dnsadmin
# vim /etc/apache2/sites-available/dnsadmin.conf
Alias /dnsadmin /var/www/html/dnsadmin
<Directory /var/www/html/dnsadmin/>
 Options FollowSymLinks
 AllowOverride All

# For Apache = 2.3:
 #Order allow,deny
 #allow from all

 # For Apache = 2.4
  Require all granted
</Directory>

# ln -s /etc/apache2/sites-available/dnsadmin.conf  /etc/apache2/sites-enabled/
# apachectl configtest  ## Check the configuration for apache.
# a2enmod rewrite
# /etc/init.d/apache2 restart
# chkconfig apache2 on
Try to access with below link for further access.
http://<server ip>/dnsadmin/
```

```html
# cd /opt
# wget http://facilemanager.com/download/facilemanager-complete-3.4.2.tar.gz
# tar -zxvf facilemanager-complete-2.2.1.tar.gz
# cp -r /opt/facileManager/client/facileManager /usr/local/
# php /usr/local/facileManager/fmDNS/client.php install
Now enter the fmDNS Web-UI URL :  http://fmDNS server Ip/dnsadmin/
```
# Troubleshooting:
```html

```

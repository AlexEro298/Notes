# facileManager:
**https://github.com/WillyXJ/facileManager**
## Server
```html
dnf install php mysql mysql-server httpd php-process php-mysqlnd -y

php = 8.0.30-2.el9
mysql = 8.0.41-2.el9
mysql-server = 8.0.41-2.el9
httpd = 2.4.62-4.el9

systemctl start mysqld
systemctl enable mysqld
systemctl status mysqld

mysql_secure_installation (always press y)
mysql -u root -p

CREATE DATABASE dns;
CREATE USER 'dnsadmin'@'localhost' IDENTIFIED BY 'Password';
GRANT ALL PRIVILEGES ON dns.* TO 'dnsadmin'@'localhost';
flush privileges;
quit


CREATE DATABASE facileManager;
CREATE USER 'facileManager'@'localhost' IDENTIFIED BY 'Password';
GRANT ALL PRIVILEGES ON facileManager.* TO 'facileManager'@'localhost';
flush privileges;
quit

systemctl enable httpd
systemctl start httpd
systemctl status httpd

[root@testpanel opt]# httpd -M | grep rewrite
 rewrite_module (shared)

if error: AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 100.100.130.70. Set the 'ServerName' directive globally to suppress this message
#nano /etc/httpd/conf/httpd.conf 
#ServerName localhost

cd /opt
wget http://facilemanager.com/download/facilemanager-complete-5.3.2.tar.gz
tar -zxvf facilemanager-complete-5.3.2.tar.gz

cp -r /opt/facileManager/server/ /var/www/html/facileManager
chown root:apache -R /var/www/html/facileManager
chmod 750 -R /var/www/html/facileManager
```
nano  /etc/httpd/conf.d/facilemanager.conf
```html
Alias /facileManager /var/www/html/facileManager 
<Directory "/var/www/html/facileManager"> 
  AllowOverride All 
 
</Directory>
```

```html
systemctl enable httpd
systemctl restart httpd
Now enter the fmDNS Web-UI URL :  http://fmDNS server Ip/facileManager
```
## Client
```html
dnf install php -y

cd /opt
wget http://facilemanager.com/download/facilemanager-complete-5.3.2.tar.gz
tar -zxvf facilemanager-complete-5.3.2.tar.gz
cp -r /opt/facileManager/client/facileManager /usr/local/
php /usr/local/facileManager/fmDNS/client.php install

http://<ip-fm-server>/facileManager
```

# Troubleshooting:
```html

```

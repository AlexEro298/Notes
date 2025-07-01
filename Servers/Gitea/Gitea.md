# Gitea
```html
https://docs.gitea.com/installation/database-prep
```
## MySQL
```html
https://dev.mysql.com/downloads/repo/yum/

-> https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm (Red Hat Enterprise Linux 9 / Oracle Linux 9 (Architecture Independent), RPM Package (mysql84-community-release-el9-1.noarch.rpm))
```
```html
dnf update -y
dnf install -y https://dev.mysql.com/get/mysql84-community-release-el9-1.noarch.rpm
dnf repolist enabled | grep mysql.*-community
dnf search mysql-community-server -v
dnf install mysql-community-server -y
systemctl start mysqld
systemctl enable mysqld
systemctl status mysqld

grep 'temporary password' /var/log/mysqld.log

mysql -uroot -p
ALTER USER 'root'@'localhost' IDENTIFIED BY 'MyNewPass4!';
exit;

mysql_secure_installation
- nyyyy
```
# Example:
```html
[root@centos-alexero alexero]# dnf repolist enabled | grep mysql.*-community

mysql-8.4-lts-community       MySQL 8.4 LTS Community Server
mysql-connectors-community    MySQL Connectors Community
mysql-tools-8.4-lts-community MySQL Tools 8.4 LTS Community
```
```html
[root@centos-alexero alexero]# dnf search mysql-community-server -v
Loaded plugins: builddep, changelog, config-manager, copr, debug, debuginfo-install, download, generate_completion_cache, groups-manager, kpatch, needs-restarting, notify-packagekit, playground, repoclosure, repodiff, repograph, repomanage, reposync, system-upgrade
DNF version: 4.14.0
cachedir: /var/cache/dnf
Last metadata expiration check: 0:01:59 ago on Mon 30 Jun 2025 15:25:42 +05.
====================================================================== Name Exactly Matched: mysql-community-server =======================================================================
mysql-community-server.x86_64 : A very fast and reliable SQL database server
Repo        : mysql-8.4-lts-community
Matched from:
Provide    : mysql-community-server = 8.4.5-1.el9

========================================================================== Name Matched: mysql-community-server ===========================================================================
mysql-community-server-debug.x86_64 : The debug version of MySQL server
Repo        : mysql-8.4-lts-community
Matched from:
Provide    : mysql-community-server-debug = 8.4.5-1.el9
```
```html
[root@centos-alexero alexero]# grep 'temporary password' /var/log/mysqld.log
2025-06-30T10:41:16.808654Z 6 [Note] [MY-010454] [Server] A temporary password is generated for root@localhost: d4f-iZ4SNX5s
```
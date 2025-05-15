# Bind9:
```html
dnf install epel-release
dnf install isc-bind
source scl_source enable isc-bind
```
```html
isc-bind-bind, который содержит named двоичный файл, rndc инструмент, утилиты DNSSEC и связанные с ними файлы конфигурации/системы/
isc-bind-bind-utils, который содержит другие утилиты BIND 9, в первую очередь dig и nsupdate.
```
```html
Файл конфигурации можно найти по адресу: /etc/opt/isc/scls/isc-bind/named.conf
Параметры командной строки для демона могут быть указаны в: /etc/opt/isc/scls/isc-bind/sysconfig/named
Чтобы запустить демон, выполните systemctl start isc-bind-named.
Если вы хотите, чтобы демон запускался при загрузке, выполните systemctl enable isc-bind-named.
```

# Bind9 dnf:

```html
dnf install bind bind-utils bind-devel bind-libs -y

systemctl enable named
systemctl start named
systemctl status named

firewall-cmd --permanent --add-service=dns
firewall-cmd --permanent --reload
```
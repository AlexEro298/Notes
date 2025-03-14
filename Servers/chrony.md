# Chrony:
```html
dnf install chrony -y
systemctl enable chronyd --now                                                                                          ### Auto-start services

nano /etc/chrony.conf
server ntp.msk-ix.ru iburst
server 0.ru.pool.ntp.org iburst
server 1.ru.pool.ntp.org iburst
server 2.ru.pool.ntp.org iburst
server 3.ru.pool.ntp.org iburst
allow 192.168.0.0/16
allow 10.0.0.0/8
allow 172.16.0.0/12

systemctl restart chronyd
```
# Troubleshooting:
```html
chronyc sources
```
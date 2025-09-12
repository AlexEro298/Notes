## Ubuntu time-zone
```html
timedatectl set-timezone Asia/Yekaterinburg
```
# NTP (Debian/Ubuntu):
```html
date
apt install tzdata
dpkg-reconfigure tzdat                                                                                                  ### config time-zone

apt install ntpdate                                                                                                     ### manual synchronization, one-time
ntpdate-debian                                                                                                          ### perform synchronization

apt install ntp                                                                                                         ### auto synchronization

nano /etc/ntpsec/ntp.conf
comment #pool 0.debian.pool.ntp.org iburst
uncomment #statsdir /var/log/ntpsec/
server ntp.msk-ix.ru iburst
server ntp1.niiftri.irkutsk.ru iburst
server ntp2.niiftri.irkutsk.ru iburst
server 0.ru.pool.ntp.org iburst
server 1.ru.pool.ntp.org iburst
server 2.ru.pool.ntp.org iburst
server 3.ru.pool.ntp.org iburst
restrict default kod nomodify nopeer noquery limited ignore                                                             ### add ignore
restrict source kod nomodify nopeer noquery limited                                                                     ### add rows
restrict 192.168.0.0 mask 255.255.0.0
restrict 172.16.0.0 mask 255.240.0.0
restrict 10.0.0.0 mask 255.0.0.0

cd /var/log
mkdir -p ntpsec
chown ntpsec:ntpsec ntpsec/
ls -la ntpsec
systemctl restart ntp
```
# Troubleshooting:
```html
ntpq -p
```
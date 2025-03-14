# FastNetMon Centos 9
```html
wget https://install.fastnetmon.com/installer -Oinstaller
sudo chmod +x installer
sudo ./installer -install_community_edition
```
your **work** email, example: alexero@work.ru
```html
nano /etc/networks_list                                                                                                 ### add all of your networks in CIDR notation (11.22.33.0/24), form of one prefix per line
nano /etc/networks_whitelist                                                                                            ### ignore some network you may add
nano /etc/fastnetmon.conf                                                                                               ### enable netflow
systemctl restart fastnetmon
```
## Notify script
```html
sudo wget https://raw.githubusercontent.com/pavel-odintsov/fastnetmon/master/src/notify_about_attack.sh -O/usr/local/bin/notify_about_attack.sh
sudo chmod 755 /usr/local/bin/notify_about_attack.sh
nano /usr/local/bin/notify_about_attack.sh fix email_notify, example email_notify=alexero@work.ru
```
## Grafana
```html
sudo ./installer -install_graphic_stack_community                                                                       ### web - grafana
16:27:31 Please login into http://your.ip.ad.dr.ess:81 with login admin and password p@ssw0rd                           ### login/pass from the script installation
comment line in :/etc/nginx/sites-available/grafana.conf
#  auth_basic "Restricted";
#  auth_basic_user_file /etc/nginx/.htpasswd;
systemctl restart nginx
```
## FastNetMonApi
```html
config in /etc/fastnetmon.conf: enable_api = on
systemctl restart fastnetmon
systemctl status fastnetmon
example ban:
cd /opt/fastnetmon-community/app/bin/
fastnetmon_api_client ban 178.216.152.1                                                                                 ### ban <ip_address>
fastnetmon_api_client ban 192.168.1.1                                                                                   ### Query failed This IP does not belong to our subnets (not in /etc/networks_list)
fastnetmon_api_client get_banlist                                                                                       ### get ban list
fastnetmon_api_client unban 178.216.152.1                                                                               ### unban <ip_address>
```
# Troubleshooting:
```html
fastnetmon_client - monitor FastNetMon’s performance you can use client
fastnetmon --version
tail -n 1000 /var/log/fastnetmon.log
```
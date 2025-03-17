# Zabbix CentOS 9
```html
systemctl status zabbix-server                                                                                          ### status server
systemctl start zabbix-server                                                                                           ### stop server
systemctl stop zabbix-server                                                                                            ### start server
```
## Upgrade between minor versions
```html
It is possible to upgrade between Zabbix 7.0.x minor versions (for example, from 7.0.1 to 7.0.3).

dnf upgrade 'zabbix-*' -y

To upgrade Zabbix server only, replace 'zabbix-*' with 'zabbix-server-*' in the command.
To upgrade Zabbix proxy only, replace 'zabbix-*' with 'zabbix-proxy-*' in the command.
To upgrade Zabbix agent only, replace 'zabbix-*' with 'zabbix-agent-*' in the command.
To upgrade Zabbix agent 2 only, replace 'zabbix-*' with 'zabbix-agent2-*' in the command.
```
## Zabbix agent
```html
/etc/zabbix/zabbix_agentd.conf 
Server=127.0.0.1,10.10.13.0/24                                                                                          ### example
Hostname=***

firewall-cmd --permanent --new-service=zabbix
firewall-cmd --permanent --service=zabbix --add-port=10050/tcp
firewall-cmd --permanent --service=zabbix --set-short="Zabbix Agent"
firewall-cmd --permanent --add-service=zabbix
firewall-cmd --reload
```
# Troubleshooting:
```html
/var/log/zabbix/                                                                                                        ### logs file
/etc/zabbix/                                                                                                            ### config file
```
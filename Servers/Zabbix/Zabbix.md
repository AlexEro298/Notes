# Zabbix CentOS 9
```html
systemctl status zabbix-server                                                                                          # status server
systemctl start zabbix-server                                                                                           # stop server
systemctl stop zabbix-server                                                                                            # start server
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
# Troubleshooting:
```html
/var/log/zabbix/                                                                                                        # logs file
/etc/zabbix/                                                                                                            # config file
```
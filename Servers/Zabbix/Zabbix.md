# Zabbix CentOS 9

> https://www.zabbix.com/download?zabbix=7.0&os_distribution=centos&os_version=9&components=agent&db=&ws=

```html
systemctl status zabbix-server                                                                                          ### status server
systemctl start zabbix-server                                                                                           ### stop server
systemctl stop zabbix-server                                                                                            ### start server
```

## Install 7.0 Zabbix Agent

> nano /etc/yum.repos.d/epel.repo
```html
[epel]
...
excludepkgs=zabbix*
```
```html
rpm -Uvh https://repo.zabbix.com/zabbix/7.0/centos/9/x86_64/zabbix-release-latest-7.0.el9.noarch.rpm
dnf clean all
dnf install zabbix-agent -y
systemctl enable zabbix-agent
```

## Zabbix Agent config

> /etc/zabbix/zabbix_agentd.conf 
```html
Server=127.0.0.1,10.10.13.0/24                                                                                          ### example
#Hostname=***
```
```html
firewall-cmd --permanent --new-service=zabbix
firewall-cmd --permanent --service=zabbix --add-port=10050/tcp
firewall-cmd --permanent --service=zabbix --set-short="Zabbix Agent"
firewall-cmd --permanent --add-service=zabbix --zone=home
firewall-cmd --reload
```
```html
systemctl restart zabbix-agent
systemctl enable zabbix-agent
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
/var/log/zabbix/                                                                                                        ### logs file
/etc/zabbix/                                                                                                            ### config file
```
# Config
> Enable mgmt_junos
```html
set routing-instances mgmt_junos description MNGMT
set system management-instance
```

> Optionally
```html
edit routing-instances mgmt_junos routing-options static 
set route 10.0.0.0/8 next-hop 10.10.3.245
set route 172.16.0.0/12 next-hop 10.10.3.245 
set route 192.168.0.0/16 next-hop 10.10.3.245
```

> NTP
```html
set system ntp server server-address routing-instance mgmt_junos
```

> RADIUS
```html
set system radius-server server-address routing-instance mgmt_junos
set system accounting destination radius server server-address routing-instance mgmt_junos
```

> Syslog
```html
set system syslog host <ip-address> routing-instance mgmt_junos
```

> SNMP
```html
set snmp routing-instance-access access-list mgmt_junos
set snmp community public routing-instance mgmt_junos
```
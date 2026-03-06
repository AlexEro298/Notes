# Remote access

> Config root password and enable ssh

```html
set system services netconf ssh
set system services ssh root-login allow
set system services ssh protocol-version v2
```

# Configure Dual Routing Engines

> https://www.juniper.net/documentation/us/en/software/junos/automation-scripting/topics/example/junos-script-automation-commit-script-configuring-dual-routing-engines.html
 
```html
set groups re0 apply-flags omit
set groups re0 system host-name mx480-re0
set groups re0 interfaces fxp0 unit 0 family inet address x.x.x.1/24 master-only
set groups re0 interfaces fxp0 unit 0 family inet address x.x.x.2/24
set groups re1 apply-flags omit
set groups re1 system host-name mx480-re1
set groups re1 interfaces fxp0 unit 0 family inet address x.x.x.1/24 master-only
set groups re1 interfaces fxp0 unit 0 family inet address x.x.x.2/24
set apply-groups re0
set apply-groups re1
```

* Delete old global config "system host-name" and "interface fxp0.0"
* Verify:
> show version invoke-on all-routing-engines | match "Hostname|boot"

# Config Management Instance
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
top
```

> NTP
```html
set system ntp server <server-address> routing-instance mgmt_junos
```

> RADIUS
```html
set system radius-server <server-address> routing-instance mgmt_junos
set system accounting destination radius server <server-address> routing-instance mgmt_junos
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
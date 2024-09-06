**Vlan**
```html
create vlan *** tag ***

config vlan vlanid *** add untagged ***
config vlan vlanid *** add tagged ***               ### example: vid:4090, port 5-6

config vlan *** add untagged ***
config vlan *** add tagged ***

config vlan vlanid *** delete ***                   ### example: vid:4090, port 5-6
config vlan *** delete ***

delete vlan vlanid ***                              ### VID
delete vlan ***                                     ### Name
```

**Ports**
```html
config ports 2 medium_type copper state enable
```

**System config**
```html
create account admin ***
password:***
again password:***
config ipif System vlan default state enable ipaddress *.*.*.*/*
create iproute default *.*.*.* 1
enable snmp
config snmp system_contact ***
config snmp system_name *** 
config snmp system_location ***
config sntp primary *.*.*.* poll-interval 3600              ### poll-interval 30-99999 seconds 
enable jumbo_frame
config ddm log enable
enable ssh
```

**Troubleshooting**
```html
disable/enable clipaging            ### scrolling config cli
show config effective
show vlan vlanid ***
show vlan ports *
show fdb
```
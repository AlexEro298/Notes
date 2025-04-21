# DGS series config:
## Vlan
```html
create vlan <vlan_name> tag <vlan_id> 

config vlan vlanid <vlan_id> add untagged <port_number>
config vlan vlanid <vlan_id> add tagged <port_number>                                                                   ### example: vid:4090, port 5-6

config vlan <vlan_name> add untagged <port_number>
config vlan <vlan_name> add tagged <port_number>

config vlan vlanid <vlan_id> delete <port_number>                                                                       ### example: vid:4090, port 5-6
config vlan <vlan_name> delete <port_number>

delete vlan vlanid <vlan_id>                                                                                            ### VID
delete vlan <vlan_name>                                                                                                 ### Name
```

## Ports
```html
config ports <port_number> medium_type copper state enable                                                              ### Enable Port
config ports <port_number> medium_type copper state disable                                                             ### Disable Port
```

## System config
```html
create account admin <account_name>
password: <account_password>
again password: <account_password>
config ipif System vlan default state enable ipaddress *.*.*.*/*
create iproute default <ip_address_gateway>
enable snmp
config snmp system_contact <SysContact>
config snmp system_name <SysName>
config snmp system_location <SysLocation>
config sntp primary <ip_address_ntp_server> secondary <ip_address_ntp_server> poll-interval <poll_interval>             ### poll-interval 30-99999 seconds 
enable jumbo_frame
config ddm log enable
enable ssh
```

# Troubleshooting
```html
disable/enable clipaging                                                                                                ### scrolling config cli
show config effective
show vlan vlanid <vlan_id>
show vlan ports <port_number>
show switch
show iproute
show fdb
```
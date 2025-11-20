# SNR example config:
```html
service password-encryption
hostname <SysName>
sysLocation <SysLocation>
sysContact <SysContact>
clock timezone <name_timezone> add <hour> <min>                                                                         ### Name of time zone, Hours - 0-23, Minutes - 0-59
username admin privilege 15 password 7 <password>
authentication line console login local
ssh-server enable
ssh-server timeout 30
snmp-server enable
snmp-server securityip <ip_address>                                                                                     ### allow ip get snmp
snmp-server community ro 7 <community_name>
snmp-server ddm-mib enable                                                                                              ### allow ddm statistic on snmp
mtu 9216                                                                                                                ### Config mtu all interface
Interface Ethernet0                                                                                                     ### Management interface
vlan <vlan_id>                                                                                                          ### Id vlan (2-4094)
 name <vlan_name>                                                                                                       ### Name Vlan
Interface Ethernet1/0/1                                                                                                 ### Example access port
 media-type copper                                                                                                      ### Combo port, only copper
 description "test"
 switchport access vlan 100
Interface Ethernet1/0/5                                                                                                 ### Example trunk port
 description "test"                 
 switchport mode trunk
 switchport trunk allowed vlan 100;200
 switchport trunk native vlan 300
interface Vlan100                                                                                                       ### Example L3 vlan
 ip address <ip_address> <mask> 
ip route <ip_network>/<mask> <ip_address_gatewey>
ntp enable
ntp syn-interval 3600
ntp server <ip_address_ntp>
```

# Example edit config:

```html
sw-snr>enable
sw-snr#conf t
sw-snr(config)#hostname <SysName>
sw-snr(config)#sysLocation <SysLocation>
sw-snr(config)#sysContact <SysContact> 
sw-snr(config)#clock timezone <name_timezone> add <hour> <min>   
sw-snr(config)#interface vlan 100
sw-snr(config-if-vlan100)#ip address <ip_address> <mask>
sw-snr(config-if-vlan100)#exit
sw-snr(config)#no interface vlan 100                                                                                    ### Example removed vlan
sw-snr(config)#interface ethernet 1/0/11
sw-snr(config-if-ethernet1/0/11)#switchport mode access                                                                 ### Example access
sw-snr(config-if-ethernet1/0/11)#switchport access vlan <vlan_id>

sw-snr(config-if-ethernet1/0/11)#switchport mode trunk
sw-snr(config-if-ethernet1/0/11)#switchport trunk allowed vlan <vlan_id>                                                ### Allowed vlan
sw-snr(config-if-ethernet1/0/11)#switchport trunk allowed vlan add <vlan_id>                                            ### Add vlan trunk
sw-snr(config-if-ethernet1/0/11)#switchport trunk native vlan <vlan_id>                                                 ### Native vlan
sw-snr(config-if-ethernet1/0/11)#switchport trunk allowed vlan remove <vlan_id>                                         ### Example remove vlan trunk

example:
(config)#no telnet-server enable
(config)#no ip http server
```

# SNR LAG (SNR-S2995G-12FX Device)

## Create and add port to Port Channel

```html
SNR-2995G-12FX(config)#port-group 1
SNR-2995G-12FX(config)#interface ethernet 1/0/16
SNR-2995G-12FX(config-if-ethernet1/0/16)#port-group 1 mode active 
```
>
```html
SNR-2995G-12FX(config)#

port-group <port-group-number>

no port-group <port-group-number>  - deletes the all aggregation config, leaving ports with the aggregation config
```
```html
SNR-2995G-12FX(config-if-ethernet1/0/16)#

port-group <port-group-number> mode {active | passive | on}
    
no port-group

active - LACP LAG
passive - LACP LAG
on - Static LAG
```

## Load Balance

```html
SNR-2995G-12FX(config)#load-balance ?
  dst-src-ip      Destination and source ip address
  dst-src-mac     Destination and source MAC address
  dst-src-mac-ip  Destination and source MAC address, IP address
  ingress-port    Ingress port

load-balance {src-mac | dst-mac |
dst-src-mac | src-ip | dst-ip |
dst-src-ip | ingress-port | dstsrc-mac-ip }

no load-balance
```
> Default:  src-mac

## LACP system priority

```html
SNR-2995G-12FX(config)#lacp system-priority ?
  <0-65535>  System priority <0-65535>

lacp system-priority <systempriority>
    
no lacp system-priority
```
> Default:  32768

## LACP Port priority

```html
SNR-2995G-12FX(config-if-ethernet1/0/16)#lacp port-priority ?
  <0-65535>  Port priority <0-65535>

lacp port-priority <port-priority>
    
no lacp port-priority
```
> Default:  32768

## LACP timeout

```html
SNR-2995G-12FX(config-if-ethernet1/0/16)#lacp timeout ?     
  long   Set LACP long timeout
  short  Set LACP short timeout

lacp timeout {short | long}

no lacp timeout
```
> Default:  long

## Notest

### The created Port Channel inherits the port configuration.

> Example:
```html
SNR-2995G-12FX(config-if-ethernet1/0/16)#show run
...
Interface Ethernet1/0/16
 switchport mode trunk
 switchport trunk allowed vlan 705 
!
Interface Port-Channel1
!
```
> Add port to Port Channel
```html
SNR-2995G-12FX(config-if-ethernet1/0/16)#port-group 1 mode active 
SNR-2995G-12FX(config-if-ethernet1/0/16)#show run
...
Interface Ethernet1/0/16
 switchport mode trunk
 switchport trunk allowed vlan 705 
 port-group 1 mode active
!
Interface Port-Channel1
 switchport mode trunk
 switchport trunk allowed vlan 705 
!
...
```
> Edit Port Channel
```html
SNR-2995G-12FX(config-if-ethernet1/0/16)#exit
SNR-2995G-12FX(config)#interface port-channel 1
SNR-2995G-12FX(config-if-port-channel1)#switchport trunk allowed vlan add 704
set the trunk port Port-Channel1 allowed vlan successfully.
SNR-2995G-12FX(config-if-port-channel1)#show run
...
!
Interface Ethernet1/0/16
 switchport mode trunk
 switchport trunk allowed vlan 704-705 
 port-group 1 mode active
!
Interface Port-Channel1
 switchport mode trunk
 switchport trunk allowed vlan 704-705 
!
...
```
> Remove Port in Port Channel
```html
SNR-2995G-12FX(config-if-port-channel1)#exit
SNR-2995G-12FX(config)#interface ethernet 1/0/16
SNR-2995G-12FX(config-if-ethernet1/0/16)#no port-group 
SNR-2995G-12FX(config-if-ethernet1/0/16)#show run
...
Interface Ethernet1/0/16
 switchport mode trunk
 switchport trunk allowed vlan 704-705 
!
Interface Port-Channel1
!
```

### If the settings do not match, it will not allow you to add a port.

```html
SNR-S2995G-12FX(config-if-ethernet1/0/16)#port-group 1 mode active 
Error: The VLAN property on port Ethernet1/0/16 is different from port-group 1!

Interface Ethernet1/0/15
 port-group 1 mode active
!
Interface Ethernet1/0/16
 switchport mode trunk
 switchport trunk allowed vlan 704-705 
!
Interface Port-Channel1
!
```

### When you remove a port from an aggregation, the configuration on it remains the same as in the aggregation.

```html
Interface Ethernet1/0/15
 switchport mode trunk
 switchport trunk allowed vlan 705 
 port-group 1 mode active
!
Interface Ethernet1/0/16
 switchport mode trunk
 switchport trunk allowed vlan 705 
 port-group 1 mode active
!
Interface Port-Channel1
 switchport mode trunk
 switchport trunk allowed vlan 705 
!
```
```html
SNR-S2995G-12FX(config)#interface ethernet 1/0/15
SNR-S2995G-12FX(config-if-ethernet1/0/15)#no port-group 
SNR-S2995G-12FX(config-if-ethernet1/0/15)#exit
SNR-S2995G-12FX(config)#show run
```
```html
Interface Ethernet1/0/15
 switchport mode trunk
 switchport trunk allowed vlan 705 
!
Interface Ethernet1/0/16
 switchport mode trunk
 switchport trunk allowed vlan 705 
 port-group 1 mode active
!
Interface Port-Channel1
 switchport mode trunk
 switchport trunk allowed vlan 705 
!
```
### Example fast create LAG:
```html
SNR-S2995G-12FX(config)#port-group 1
SNR-S2995G-12FX(config)#interface ethernet 1/0/15-16    
SNR-S2995G-12FX(config-if-port-range)#port-group 1 mode active 
SNR-S2995G-12FX(config-if-port-range)#interface port-channel 1
SNR-S2995G-12FX(config-if-port-channel1)#
```
### Troubleshooting LAG:
```html
show port-group 1 detail
```

# Troubleshooting:

```html
show running-config
show transceiver
show mac-address-table
show run current-mode                                                                                                   ### display current edit config
```
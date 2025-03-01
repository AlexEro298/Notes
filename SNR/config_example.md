```html
service password-encryption
hostname ***
sysLocation "***"
sysContact "***"
clock timezone *** add * *                                      ### Name of time zone, Hours - 0-23, Minutes - 0-59
username admin privilege 15 password 7 ***
authentication line console login local
ssh-server enable
ssh-server timeout 30
snmp-server enable
snmp-server securityip *.*.*.*                                  ### allow ip get snmp
snmp-server community ro 7 ***
snmp-server ddm-mib enable                                      ### allow ddm statistic on snmp
mtu 9216                                                        ### Config mtu all interface
Interface Ethernet0                                             ### Management interface
vlan *                                                          ### Id vlan (2-4094)
 name ***                                                       ### Name Vlan
Interface Ethernet1/0/1                                         ### Example access port
 media-type copper                                              ### Combo port, only copper
 description "test"
 switchport access vlan 100
Interface Ethernet1/0/5                                         ### Example trunk port
 description "test"                 
 switchport mode trunk
 switchport trunk allowed vlan 100;200
 switchport trunk native vlan 300
interface Vlan100                                               ### Example L3 vlan
 ip address *.*.*.* *.*.*.*
ip route *.*.*.*/* *.*.*.*
sntp polltime *
sntp server *.*.*.*
```

```html
sw-snr>enable
sw-snr#conf t
sw-snr(config)#hostname ***
sw-snr(config)#sysLocation ***
sw-snr(config)#sysContact *** 
sw-snr(config)#clock timezone *** add * *  
sw-snr(config)#interface vlan 100
sw-snr(config-if-vlan100)#ip address *.*.*.* *.*.*.*
sw-snr(config-if-vlan100)#exit
sw-snr(config)#no interface vlan 100                                        ### Example removed vlan
sw-snr(config)#interface ethernet 1/0/11
sw-snr(config-if-ethernet1/0/11)#switchport mode access                     ### Example access
sw-snr(config-if-ethernet1/0/11)#switchport access vlan ***

sw-snr(config-if-ethernet1/0/11)#switchport mode trunk
sw-snr(config-if-ethernet1/0/11)#switchport trunk allowed vlan ***          ### Allowed vlan
sw-snr(config-if-ethernet1/0/11)#switchport trunk allowed vlan add ***      ### Add vlan trunk
sw-snr(config-if-ethernet1/0/11)#switchport trunk native vlan ***           ### Native vlan
sw-snr(config-if-ethernet1/0/11)#switchport trunk allowed vlan remove ***   ### Example remove vlan trunk

example:
(config)#no telnet-server enable
(config)#no ip http server
```
**Troubleshooting**
```html
show running-config
show transceiver
show mac-address-table
```
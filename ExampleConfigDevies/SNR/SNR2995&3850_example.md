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
# Troubleshooting:
```html
show running-config
show transceiver
show mac-address-table
show run current-mode                                                                                                   ### display current edit config
```
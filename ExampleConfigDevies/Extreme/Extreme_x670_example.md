# Extreme_x670 example config:
## Ports
```html
configure ports <port_number> display-string <description>                                                              ### config ports display string ( description )
enable ports <port_number>                                                                                              ### enable port
disable ports <port_number>                                                                                             ### disable port 
```

## Vlan and L3vlan
```html
create vlan <vlan_name> tag <vlan_id>                                                                                   ### create vlan
configure vlan <vlan_name> add ports <port_number> tagged
configure vlan <vlan_name> add ports <port_number> untagged
configure vlan <vlan_name> delete ports <port_number>
configure vlan <vlan_name> delete                                                                                       ### delete vlan
delete vlan <vlan_name>


configure vlan <vlan_name> ipaddress <ip_address> <mask>                                                                ### example: 10.10.1.1 255.255.255.0
enable ipforwarding vlan <vlan_name>
configure ip-mtu <vlan_mtu> vlan <vlan_name>                                                                            ### mtu: 1600 - for ospf vlan
```

## QinQ
```html
configure vman ethertype 0x8100                                                                                         ### VLAN-tagged frame (IEEE 802.1Q) 
configure vman ethertype 0x8100 secondary                                                                               ### example: 0x88A8 - Service VLAN tag identifier (S-Tag) on Q-in-Q tunnel. 

create vman <vman_name>
configure vman <vman_name> tag <vman_id>
configure vman <vman_name> add ports <port_number>  untagged
```

## Jumbo-frame and sharing
```html
enable jumbo-frame ports all
configure sharing address-based custom hash-algorithm crc-32 lower
configure sharing address-based custom ipv4 source-and-destination

enable sharing 48 grouping 46,48 algorithm address-based custom lacp                                                    ### enable sharing example: port 48 Master port

configure sharing <MASTER-PORT> add ports <port-list>
configure sharing <MASTER-PORT> delete ports <port-list>

configure sharing <MASTER-PORT> lacp activity-mode passive

disable sharing <MASTER-PORT>                                                                                           ### disable sharing
```

## SNMP
```html
configure snmp sysName "<SysName>"
configure snmp sysLocation "<SysLocation>"
configure snmp sysContact "<SysContact>"
configure timezone <minutes> autodst                                                                                    ### minutes example: configure timezone 300 autodst (+5 GMT)

configure snmp delete community readonly public
configure snmp add community readonly <community_string>
```

## SNTP
```html
configure sntp-client primary <IP-server-sntp> vr VR-Default
configure sntp-client secondary <IP-server-sntp> vr VR-Default
enable sntp-client
```

## Radius && default user && syslog
```html
configure radius mgmt-access primary server <ip_address_radius> 1812 client-ip <ip_address_lo0_switch> vr VR-Default
configure radius mgmt-access primary shared-secret encrypted "***"
enable radius mgmt-access
configure account admin encrypted "***"

configure syslog add <ip_address_syslog>:1515 vr VR-Default local0
enable log target syslog <ip_address_syslog>:1515 vr VR-Default local0
configure log target syslog <ip_address_syslog>:1515 vr VR-Default local0 from <ip_address_lo0_switch>
configure log target syslog <ip_address_syslog>:1515 vr VR-Default local0 filter DefaultFilter severity Debug-Data
configure log target syslog <ip_address_syslog>:1515 vr VR-Default local0 match Any
configure log target syslog <ip_address_syslog>:1515 vr VR-Default local0 format timestamp seconds date Mmm-dd event-name none priority tag-name
```

## OSPF && MPLS
```html
configure ospf routerid <ip_address_vlan_loopback>
enable ospf
configure ospf add vlan <vlan_name> area 0.0.0.0
configure ospf add vlan <loopback> area 0.0.0.0 link-type point-to-point passive

enable mpls
enable mpls protocol ldp
enable mpls protocol rsvp-te
configure mpls lsr-id <IP_lo0.0>

        
configure mpls add vlan <vlan_name>
enable mpls vlan <vlan_name>
enable mpls rsvp-te vlan <vlan_name>
enable mpls ldp vlan <vlan_name>

create mpls rsvp-te lsp <lsp_name> destination <ip_address_loopback_destination> 
create mpls rsvp-te path <lsp_path_name_prinary_or_secondary>
configure mpls rsvp-te path <lsp_path_name_prinary_or_secondary> add ero include <ip_address_link_next_hop>/32 loose order 100
configure mpls rsvp-te path <lsp_path_name_prinary_or_secondary> add ero include <ip_address_link_next_hop>/32 strict order 105
configure mpls rsvp-te lsp "TEST" add path <lsp_path_name_prinary_or_secondary> primary
```

## VPLS, VPWS (L2VPN)
```html
create l2vpn vpls <vpls_name> fec-id-type pseudo-wire <vpls_number>                                                     ### create l2vpn
configure l2vpn vpls <vpls_name> add service vlan <vlan_name>
configure l2vpn vpls <vpls_name> mtu 9216
configure l2vpn vpls <vpls_name> add peer <ip_address_loopback_destination> core full-mesh
disable l2vpn vpls <vpls_name>                                                                                          ### disable l2vpn vpls
delete l2vpn vpls <vpls_name>                                                                                           ### delete l2vpn
```

## Policy
```html
edit policy <policy-name>
```
```html
Для начала редактирования нужно нажать клавишу «i».
Команды, используемы для редактирования ACL:
dd — To delete the current line
yy — To copy the current line
p — To paste the line copied
:w — To write (save) the file
:q — To quit the file if no changes were made
:q! — To forcefully quit the file without saving changes
:wq — To write and quit the file
```
```html
check policy <policy-name>
refresh policy <policy-name>
show policy {<policy-name> | detail}
```

> Example:
```html
# show policy "snmp_restrict" 
Policies at Policy Server:
Policy: snmp_restrict
entry AllowTheseSubnets { 
if match any { 
    source-address 10.10.105.0 /24 ;
    source-address 10.10.3.0 /24 ;
}
then {
    permit  ;
}
}
Number of clients bound to policy: 1
Client: snmpMaster bound once
```
```html
# show policy "snmp_restrict" 
Policies at Policy Server:
Policy: snmp_restrict
entry AllowTheseSubnets { 
if match all { 
    source-address 10.10.105.0 /24 ;
}
then {
    permit  ;
}   
}
Number of clients bound to policy: 1
Client: snmpMaster bound once
```
```html
configure snmp access-profile snmp_restrict readonly
```

# Unconfigure OSPF, MPLS
```html
 # show configuration | include <VLAN>
create vlan "<VLAN>"
configure vlan <VLAN> tag <VLANID>
configure vlan <VLAN> ipaddress <IP> <NETMASK>
enable ipforwarding vlan <VLAN>
configure ip-mtu 1600 vlan <VLAN>
configure mpls add vlan "<VLAN>"
enable mpls vlan "<VLAN>"
enable mpls rsvp-te vlan "<VLAN>"
enable mpls ldp vlan "<VLAN>"
configure ospf add vlan <VLAN> area 0.0.0.0 
```

```html
configure ospf delete vlan "<VLAN>"
configure mpls delete vlan "<VLAN>"
delete vlan <VLAN>
```

## Reboot
```html
reboot time 10 27 2025 13 35 00 

reboot cancel
```
# Troubleshooting
```html
show configuration
show configuration | include
show fdb
show sharing
show ports transceiver information
```
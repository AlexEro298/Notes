**Ports**
```html
configure ports * display-string ***
enable ports *
disable ports *
```

**Vlan and L3vlan**
```html
configure vlan *** tag ***
configure vlan *** add ports *** tagged
configure vlan *** add ports *** untagged
configure vlan *** delete ports ***
configure vlan *** delete                                               ### delete vlan


###L3 vlan
configure vlan *** ipaddress *.*.*.* *.*.*.*
enable ipforwarding vlan ***
configure ip-mtu *** vlan ***                                           ### 1600
```

**QinQ**
```html
configure vman ethertype 0x8100 secondary

create vman "***"
configure vman *** tag ***
configure vman *** add ports * untagged
```

**Jumbo-frame and sharing**
```html
enable jumbo-frame ports all
configure sharing address-based custom hash-algorithm crc-32 lower
configure sharing address-based custom ipv4 source-and-destination

enable sharing 48 grouping 46,48 algorithm address-based custom lacp

configure sharing logic-port add ports port-list
configure sharing logic-port delete ports port-list

configure sharing 21 lacp activity-mode passive

disable sharing MASTER-PORT
```

**SNMP**
```html
configure snmp sysName "***"
configure snmp sysLocation "***"
configure snmp sysContact "***"
configure timezone *** autodst                                          ### minutes
```
**Radius && default user && syslog**
```html
configure radius mgmt-access primary server *.*.*.* 1812 client-ip *.*.*.* vr VR-Default
configure radius mgmt-access primary shared-secret encrypted "***"
enable radius mgmt-access
configure account admin encrypted "***"

configure syslog add *.*.*.*:1515 vr VR-Default local0
enable log target syslog *.*.*.*:1515 vr VR-Default local0
configure log target syslog *.*.*.*:1515 vr VR-Default local0 from *.*.*.*
configure log target syslog *.*.*.*:1515 vr VR-Default local0 filter DefaultFilter severity Debug-Data
configure log target syslog *.*.*.*:1515 vr VR-Default local0 match Any
configure log target syslog *.*.*.*:1515 vr VR-Default local0 format timestamp seconds date Mmm-dd event-name none priority tag-name
```
**OSPF && MPLS**
```html
configure ospf routerid *.*.*.*
enable ospf
configure ospf add vlan OSPF_VLAN area 0.0.0.0
configure ospf add vlan loopback area 0.0.0.0 link-type point-to-point passive

enable mpls
enable mpls protocol ldp
enable mpls protocol rsvp-te

configure mpls add vlan "***"
enable mpls vlan "***"
enable mpls rsvp-te vlan "***"
enable mpls ldp vlan "***"

create mpls rsvp-te lsp "TEST" destination *.*.*.*                                                              ### IP neighbor
create mpls rsvp-te path "TEST-path"
configure mpls rsvp-te path TEST-path add ero include *.*.*.*/32 loose order 100
configure mpls rsvp-te path TEST-path add ero include *.*.*.*/32 strict order 105
configure mpls rsvp-te lsp "TEST" add path "TEST-path" primary
```

**VPLS, VPWS (L2VPN)**
```html
delete l2vpn vpls *                                              ### delete l2vpn
create l2vpn vpls * fec-id-type pseudo-wire *                    ### create l2vpn
configure l2vpn vpls * add service vlan cam
configure l2vpn vpls * mtu 1600
configure l2vpn vpls * add peer *.*.*.* core full-mesh
```

**Troubleshooting**
```html
show configuration
show configuration | include
show fdb
show sharing
show ports transceiver information
```
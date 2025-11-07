# Extreme_x670 example config:

## Default config
```html
enable cli-config-logging
configure banner after-login
==================================
             Welcome!
  Do not make any configuration
  changes in Friday and Drink :)
==================================

configure idletimeout 60
```

## Ports
```html
configure ports <port_number> display-string <description>                                                              ### config ports display string ( description )
enable ports <port_number>                                                                                              ### enable port
disable ports <port_number>                                                                                             ### disable port
```
> Example:
```html
* x670.test.44 # config ports 1 description-string test
* x670.test.45 # config ports 1 display-string test1
* x670.test.46 # show ports 1 description 
Port   Display String        Description String                                
=====  ====================  ==================================================
1      test1                 test
=====  ====================  ==================================================

* x670.test.47 # unconfigure ports 1 description-string
Port   Display String        Description String                                
=====  ====================  ==================================================
1      test1                 
=====  ====================  ==================================================
* x670.test.50 # unconfigure ports 1 display-string 
* x670.test.51 # show ports 1 description 
Port   Display String        Description String                                
=====  ====================  ==================================================
1                            
=====  ====================  ==================================================
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

config vlan <vlan_name> name <new_vlan_name>                                                                            ### rename VLAN
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
configure timezone <minutes> noautodst                                                                                  ### minutes example: configure timezone 300 autodst (+5 GMT)

configure snmp delete community readonly public
configure snmp add community readonly <community_string>
```

## SNTP
```html
configure sntp-client primary <IP-server-sntp> vr VR-Default
configure sntp-client secondary <IP-server-sntp> vr VR-Default 
configure sntp-client update-interval 3600 
enable sntp-client
```
> Example disable/enable:
```html
x670.test.1 # disable sntp-client

x670.test.2 # enable sntp-client
```

## Radius && default user && syslog
```html
configure radius mgmt-access primary server <ip_address_radius> 1812 client-ip <ip_address_lo0_switch> vr VR-Default
configure radius mgmt-access primary shared-secret encrypted "***"
enable radius mgmt-access
configure account admin encrypted "***"

configure log filter DefaultFilter add events FDB.MACTracking.MACMove
configure syslog add <ip_address_syslog>:1515 vr VR-Default local0
enable log target syslog <ip_address_syslog>:1515 vr VR-Default local0
configure log target syslog <ip_address_syslog>:1515 vr VR-Default local0 from <ip_address_lo0_switch>
configure log target syslog <ip_address_syslog>:1515 vr VR-Default local0 filter DefaultFilter severity Debug-Data
configure log target syslog <ip_address_syslog>:1515 vr VR-Default local0 match Any
configure log target syslog <ip_address_syslog>:1515 vr VR-Default local0 format timestamp seconds date Mmm-dd event-name none priority tag-name
```
> Example (Primary ver: 16.2.5.4 patch1-31):
```html
* x670.test.1 # configure radius mgmt-access secondary server <ip_radius_server> 1812 client-ip <ip_nas_extreme> vr "VR-Mgmt" shared-secret <secret_nas> 
Note: Shared secrets created with EXOS 16.1 and greater are not compatible with EXOS 15.x and earlier.


* x670.test.2 # show configuration "aaa" 
#
# Module aaa configuration.
#
configure radius mgmt-access secondary server <ip_radius_server> 1812 client-ip <ip_nas_extreme> vr VR-Mgmt
configure radius mgmt-access secondary shared-secret encrypted <secret_nas_encrypted> 
enable radius mgmt-access
configure account admin encrypted <admin_password>


* x670.test.3 # unconfigure radius server secondary 
```

## BFD
```html
enable bfd vlan "<vlan>"
unconfigure bfd vlan "<vlan>"

enable iproute bfd 10.10.105.1 vr VR-Default
disable iproute bfd 10.10.105.1 vr "VR-Default"
```
> После отключения iproute bfd в show некоторое время будует показываться сессия, потом исчезнет (минут 10-20 наверное)
```html
x670.test.77 # show bfd session 
Neighbor       Interface      Clients  Detection  Status       VR 
=============================================================================
10.10.105.1    mng            -----      0        Admin Down   VR-Default     
=============================================================================
Clients Flag: m - MPLS, o - OSPF, s - Static
NOTE: All timers in milliseconds.
x670.test.78 # show sw | i "Current Time:"
Current Time:     Fri Nov  7 08:43:16 2025
x670.test.79 # show bfd session 
Neighbor       Interface      Clients  Detection  Status       VR 
=============================================================================
10.10.105.3    mng            -----      0        Admin Down   VR-Default     
=============================================================================
Clients Flag: m - MPLS, o - OSPF, s - Static
NOTE: All timers in milliseconds.
x670.test.80 # show sw | i "Current Time:"
Current Time:     Fri Nov  7 08:46:32 2025
x670.test.81 # show bfd session 

x670.test.82 # show sw | i "Current Time:"
Current Time:     Fri Nov  7 08:50:24 2025
```

## Meter
```html
create meter test
configure meter "test" committed-rate 2 Gbps max-burst-size 250 Mb out-actions drop
```
> vi test_meter.pol
```html
entry meter1 {
if match all {
}
then {
    meter test;
}
}
```
```html
configure access-list test_meter vlan "<vlan_name>" ingress
```
```html
* x670.test.100 # configure access-list test_meter ports 1
Note: An unconditional PERMIT action on an EAPS or STP blocked port will result in a loop. Adding an explicit match criteria such as ethernet-type will avoid these rules matching EAPS and STP PDUs.
 done!
```
> show access-list meter vlan "<vlan_name>"
> show access-list meter ports 1

```html
unconfigure access-list "test_meter"
delete meter "test"
```
```html
* x670.test.126 # ls
-rw-r--r--    1 admin    admin          67 Nov 20  2013 metro.pol
-rw-rw-rw-    1 root     root       388504 Nov  7 08:40 primary.cfg
-rw-r--r--    1 admin    admin         133 Oct 28 10:30 snmp_restrict.pol
-rw-r--r--    1 admin    admin          59 Nov  7 10:01 test_meter.pol
drwxr-xr-x    2 root     root            0 Oct 29 10:29 vmt

 1K-blocks      Used Available Use%
    121824      3088    118736   3%
* x670.test.127 # rm
  rm              Remove files
  rmdir           Remove empty directory
* x670.test.127 # rm test_meter.pol 
Remove test_meter.pol from /usr/local/cfg? (y/N) Yes
```

## Static Route
```html
configure iproute add 10.10.13.248 255.255.255.255 10.10.3.245 vr VR-Mgmt

configure iproute delete 10.10.13.248 255.255.255.255  10.10.3.245  vr VR-Mgmt
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
configure mpls rsvp-te path <lsp_path_name_prinary_or_secondary> add ero include <ip_address_link_next_hop>/32 loose
configure mpls rsvp-te path <lsp_path_name_prinary_or_secondary> add ero include <ip_address_link_next_hop>/32 strict
configure mpls rsvp-te lsp "TEST" add path <lsp_path_name_prinary_or_secondary> primary
```

> Example:

```html
x670.test.66 # create mpls rsvp-te lsp <test_lsp> destination 10.240.1.1 

* x670.test.68 # create mpls rsvp-te path <testpath>
* x670.test.70 # config mpls rsvp-te path "<testpath>" add ero include 10.240.2.2/32 strict
* x670.test.75 # config mpls rsvp-te path "<testpath>" add ero include 10.240.2.3/32 strict

* x670.test.77 # configure mpls rsvp-te lsp "<test_lsp>" add path "<testpath>" primary

* x670.test.78 # show configuration "mpls"
                
create mpls rsvp-te path "<testpath>"
configure mpls rsvp-te path <testpath> add ero include 10.240.2.2/32 strict order 100
configure mpls rsvp-te path <testpath> add ero include 10.240.2.3/32 strict order 200
create mpls rsvp-te lsp "<test_lsp>" destination 10.240.1.1
configure mpls rsvp-te lsp "<test_lsp>" add path "<testpath>" primary
```
> Example unconfig:
```html
* x670.test.80 # configure mpls rsvp-te lsp "test" delete path "<testpath>" 
* x670.test.81 # delete mpls rsvp-te path "<testpath>" 
* x670.test.82 # delete mpls rsvp-te lsp "<test_lsp>" 
```
> Example:
```html
* x670.test.84 # disable mpls rsvp-te lsp "<test_lsp>" 
* x670.test.88 # enable mpls rsvp-te lsp "<test_lsp>"
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
edit policy <policy-name>                                                                                               ### также создаст файл если его нет
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

> example create:
```html
x670# edit policy snmp_restrict

egrep: snmp_restrict.pol: No such file or directory
Entry AllowTheseSubnets {
if match any {
   source-address 10.10.105.0 /24;
   source-address 10.10.3.0 /24;
}
then
{
   permit;
}

:w
:q


x670# check policy snmp_restrict
Policy file check successful.


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
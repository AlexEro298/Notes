# SNR example config default:

```html
SNR-S5210G-8TX-DC(config)#show run
!
hostname SNR-S5210G-8TX-DC
!
logging executed-commands 2
!
no ip domain-lookup
spanning-tree mode rstp
clock timezone Asia/Yekaterinburg add 5 0
feature telnet
feature ssh
no feature tacacs+
snmp-server enable snmp
username <admin> role network-admin password encrypted <string_passw0rd>
set lldp system-name SNR-S5210G-8TX-DC
spanning-tree shutdown
!
snmp-server configuration
  snmp-server view all .1 included
  snmp-server community 7 <community> group network-operator 
  snmp-server securityip enable
  snmp-server securityip <secure_ip>
  snmp-server location <SysLocation>
  snmp-server contact <SysContact>
!
interface ge1
!
interface ge2
!
interface ge3
!
interface ge4
!
interface ge5
!
interface ge6
!
interface ge7
!
interface ge8
!
interface xe1
!
interface xe2
!
interface xe3
!
interface xe4
!
interface vlan1
 ip address 192.168.192.19/24
!
ip route 0.0.0.0/0 192.168.192.245
!
ntp enable
ntp server 192.168.192.245 
ntp server 192.168.192.249 
!
logging server time-format local
logging server 10.10.13.243 
!
line con 0
 login
line vty 0 39
 login
!
end
```

# Example config LAG

> create LACP channel-group
```html
SNR-S5210G-8TX-DC(config)#show run int xe4
!
interface xe4
!

SNR-S5210G-8TX-DC(config)#interface xe4
SNR-S5210G-8TX-DC(config-if)#channel-group 1 mode active 

SNR-S5210G-8TX-DC(config)#show run
...
!
interface xe4
 channel-group 1 mode active
!
interface po1
!
...
```
```html
SNR-S5210G-8TX-DC(config)#interface po1
SNR-S5210G-8TX-DC(config-if)#description LAG_LACP
SNR-S5210G-8TX-DC(config-if)#switchport mode trunk
SNR-S5210G-8TX-DC(config-if)#switchport trunk allowed vlan add 2
```
> Default load balance - src-dst-mac.
```html
SNR-S5210G-8TX-DC(config)#port-channel load-balance ?
  dst-ip        Destination IP address based load balancing
  dst-mac       Destination Mac address based load balancing
  dst-port      Destination TCP/UDP port based load balancing
  src-dst-ip    Source and Destination IP address based load balancing
  src-dst-mac   Source and Destination Mac address based load balancing
  src-dst-port  Source and Destination TCP/UDP port based load balancing
  src-ip        Source IP address based load balancing
  src-mac       Source Mac address based load balancing
  src-port      Source TCP/UDP port based load balancing
```
> Default LACP system priority 32768
```html
SNR-S5210G-8TX-DC(config)#lacp system-priority ?
  <1-65535>  LACP system priority <1-65535> default 32768
```
> Default port-priority - 32768, timeout - long
```html
SNR-S5210G-8TX-DC(config)#interface xe4
SNR-S5210G-8TX-DC(config-if)#lacp port-priority ?
  <1-65535>  LACP port priority

SNR-S5210G-8TX-DC(config-if)#lacp timeout ?
  long   Set LACP long timeout
  short  Set LACP short timeout
```

## Example delete ports in LAG:

```html
SNR-TEST(config)#interface xe3
SNR-TEST(config-if)#no channel-group 
```
> When the last port is deleted from the LAG, 
> the Port-Channel configuration is deleted from the configuration.

> When removing a port from LAG, 
> its configuration will be the same as LAG (it is best to shutdown the port and remove it from LAG)

## Troubleshooting LAG

```html
show etherchannel
show etherchannel 1
show etherchannel load-balance 
show lacp sys-id
show lacp-counter
```
```html
SNR-S5210G-8TX-DC#show etherchannel
% Lacp Aggregator: po1
% Member:
   xe3
   xe4
SNR-S5210G-8TX-DC#show etherchannel 1
% Aggregator po1 100001 Admin Key: 0001 - Oper Key 0001
% Partner LAG ID: 0x0000,00-00-00-00-00-00,0x0000
% Partner Oper Key 0000
SNR-S5210G-8TX-DC#show etherchannel load-balance 
Source and Destination Mac address
SNR-S5210G-8TX-DC#show lacp sys-id
% System 8000,f8-f0-82-d6-34-68
SNR-S5210G-8TX-DC#show lacp-counter
% Traffic statistics 
   Port        LACPDUs         Marker        Marker-Rsp        Pckt err
            Sent    Recv    Sent    Recv    Sent    Recv    Sent    Recv
% Aggregator po1 100001 
xe3         0       0       0       0       0       0       0       0       
xe4         0       0       0       0       0       0       0       0       
```

# Troubleshooting:

```html
show running-config
show transceiver
show vlan static
show mac address-table
```
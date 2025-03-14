# Config Juniper:
**JunOS firewall in box**
```html
set interfaces lo0 unit 0 family inet filter input-list accept-common-services
set interfaces lo0 unit 0 family inet filter input-list discard-all
set interfaces lo0 unit 0 family inet6 filter input-list accept-v6-common-services
set interfaces lo0 unit 0 family inet6 filter input-list discard-v6-all
```
## Prefix-List
```html
set policy-options prefix-list router-ipv4 apply-path "interfaces <*> unit <*> family inet address <*>"
set policy-options prefix-list router-ipv4-logical-systems apply-path "logical-systems <*> interfaces <*> unit <*> family inet address <*>"
set policy-options prefix-list ospf 224.0.0.5/32
set policy-options prefix-list ospf 224.0.0.6/32 
set policy-options prefix-list MGMT-locals apply-path "interfaces fxp0 unit 0 family inet address <*>"
set policy-options prefix-list vrrp 224.0.0.18/32
set policy-options prefix-list multicast-all-routers 224.0.0.2/32
set policy-options prefix-list RADIUS-servers apply-path "system radius-server <*>"
set policy-options prefix-list TACPLUS-servers apply-path "system tacplus-server <*>"
set policy-options prefix-list NTP-servers-v4 apply-path "system ntp server <*.*>"
set policy-options prefix-list NTP-servers-v6 apply-path "system ntp server <*:*>"
set policy-options prefix-list SNMP-clients apply-path "snmp client-list <*> <*>"
set policy-options prefix-list SNMP-community-clients apply-path "snmp community <*> clients <*>"
set policy-options prefix-list localhost-v4 127.0.0.0/8
set policy-options prefix-list localhost-v6 ::1/128
set policy-options prefix-list DNS-servers-v4 apply-path "system name-server <*.*>"
set policy-options prefix-list DNS-servers-v6 apply-path "system name-server <*:*>"
set policy-options prefix-list BGP-locals-v4 apply-path "protocols bgp group <*> neighbor <*.*> local-address <*.*>"
set policy-options prefix-list BGP-locals-v4-gr apply-path "protocols bgp group <*> local-address <*.*>"
set policy-options prefix-list BGP-locals-v6 apply-path "protocols bgp group <*> neighbor <*:*> local-address <*:*>"
set policy-options prefix-list BGP-locals-v6-gr apply-path "protocols bgp group <*> local-address <*:*>"
set policy-options prefix-list BGP-neighbors-v4 apply-path "protocols bgp group <*> neighbor <*.*>"
set policy-options prefix-list BGP-neighbors-v6 apply-path "protocols bgp group <*> neighbor <*:*>"
set policy-options prefix-list MGMT-remote 10.10.0.0/16
set policy-options prefix-list router-ipv6 apply-path "interfaces <*> unit <*> family inet6 address <*>"
set policy-options prefix-list INTERNAL-locals <fxp0.0>/32
set policy-options prefix-list INTERNAL-locals <lo0.0>/32
set policy-options prefix-list MGMT-locals <lo0.0>/32
set policy-options prefix-list localhost-v4 <lo0.0>/32
set policy-options prefix-list loopback-prefix <lo0.0>/32
```
## Family inet
### filter accept-common-services**
```html
set firewall family inet filter accept-common-services apply-flags omit
set firewall family inet filter accept-common-services term protect-TRACEROUTE filter accept-traceroute
set firewall family inet filter accept-common-services term protect-ICMP filter accept-icmp
set firewall family inet filter accept-common-services term protect-SSH filter accept-ssh
set firewall family inet filter accept-common-services term protect-SNMP filter accept-snmp
set firewall family inet filter accept-common-services term protect-NTP filter accept-ntp
set firewall family inet filter accept-common-services term protect-DNS filter accept-dns
set firewall family inet filter accept-common-services term protect-TACACS filter accept-tacacs
set firewall family inet filter accept-common-services term protect-radius filter accept-radius
set firewall family inet filter accept-common-services term protect-bgp filter accept-bgp
set firewall family inet filter accept-common-services term protect-api filter accept-api
set firewall family inet filter accept-common-services term accept-sh-bfd filter accept-sh-bfd
set firewall family inet filter accept-common-services term accept-vrrp filter accept-vrrp
set firewall family inet filter accept-common-services term accept-rsvp filter accept-rsvp
set firewall family inet filter accept-common-services term accept-ldp filter accept-ldp
set firewall family inet filter accept-common-services term accept-ospf filter accept-ospf
set firewall family inet filter accept-common-services term accept-ftp filter accept-ftp
deactivate firewall family inet filter accept-common-services term accept-ftp
```
### filter accept-traceroute
```html
set firewall family inet filter accept-traceroute apply-flags omit
set firewall family inet filter accept-traceroute term accept-traceroute-udp from destination-prefix-list router-ipv4
set firewall family inet filter accept-traceroute term accept-traceroute-udp from destination-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-traceroute term accept-traceroute-udp from protocol udp
set firewall family inet filter accept-traceroute term accept-traceroute-udp from ttl 1
set firewall family inet filter accept-traceroute term accept-traceroute-udp from destination-port 33434-33450
set firewall family inet filter accept-traceroute term accept-traceroute-udp then policer management-1m
set firewall family inet filter accept-traceroute term accept-traceroute-udp then count accept-traceroute-udp
set firewall family inet filter accept-traceroute term accept-traceroute-udp then accept
set firewall family inet filter accept-traceroute term accept-traceroute-icmp from destination-prefix-list router-ipv4
set firewall family inet filter accept-traceroute term accept-traceroute-icmp from destination-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-traceroute term accept-traceroute-icmp from protocol icmp
set firewall family inet filter accept-traceroute term accept-traceroute-icmp from ttl 1
set firewall family inet filter accept-traceroute term accept-traceroute-icmp from icmp-type echo-request
set firewall family inet filter accept-traceroute term accept-traceroute-icmp from icmp-type timestamp
set firewall family inet filter accept-traceroute term accept-traceroute-icmp from icmp-type time-exceeded
set firewall family inet filter accept-traceroute term accept-traceroute-icmp then policer management-1m
set firewall family inet filter accept-traceroute term accept-traceroute-icmp then count accept-traceroute-icmp
set firewall family inet filter accept-traceroute term accept-traceroute-icmp then accept
set firewall family inet filter accept-traceroute term accept-traceroute-tcp from destination-prefix-list router-ipv4
set firewall family inet filter accept-traceroute term accept-traceroute-tcp from destination-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-traceroute term accept-traceroute-tcp from protocol tcp
set firewall family inet filter accept-traceroute term accept-traceroute-tcp from ttl 1
set firewall family inet filter accept-traceroute term accept-traceroute-tcp then policer management-1m
set firewall family inet filter accept-traceroute term accept-traceroute-tcp then count accept-traceroute-tcp
set firewall family inet filter accept-traceroute term accept-traceroute-tcp then accept
```
### filter accept-icmp
```html
set firewall family inet filter accept-icmp apply-flags omit
set firewall family inet filter accept-icmp term discard-icmp-fragments from is-fragment
set firewall family inet filter accept-icmp term discard-icmp-fragments from protocol icmp
set firewall family inet filter accept-icmp term discard-icmp-fragments then count discard-icmp-fragments
set firewall family inet filter accept-icmp term discard-icmp-fragments then discard
set firewall family inet filter accept-icmp term accept-icmp from protocol icmp
set firewall family inet filter accept-icmp term accept-icmp from ttl-except 1
set firewall family inet filter accept-icmp term accept-icmp from icmp-type echo-reply
set firewall family inet filter accept-icmp term accept-icmp from icmp-type echo-request
set firewall family inet filter accept-icmp term accept-icmp from icmp-type time-exceeded
set firewall family inet filter accept-icmp term accept-icmp from icmp-type unreachable
set firewall family inet filter accept-icmp term accept-icmp from icmp-type source-quench
set firewall family inet filter accept-icmp term accept-icmp from icmp-type router-advertisement
set firewall family inet filter accept-icmp term accept-icmp from icmp-type parameter-problem
set firewall family inet filter accept-icmp term accept-icmp then policer management-1m
set firewall family inet filter accept-icmp term accept-icmp then count accept-icmp
set firewall family inet filter accept-icmp term accept-icmp then accept
```
### filter accept-ssh
```html
set firewall family inet filter accept-ssh apply-flags omit
set firewall family inet filter accept-ssh term accept-ssh from source-prefix-list MGMT-remote
set firewall family inet filter accept-ssh term accept-ssh from destination-prefix-list MGMT-locals
set firewall family inet filter accept-ssh term accept-ssh from protocol tcp
set firewall family inet filter accept-ssh term accept-ssh from destination-port ssh
set firewall family inet filter accept-ssh term accept-ssh from destination-port 830
set firewall family inet filter accept-ssh term accept-ssh then policer management-5m
set firewall family inet filter accept-ssh term accept-ssh then count accept-ssh
set firewall family inet filter accept-ssh term accept-ssh then accept
set firewall family inet filter accept-ssh term discard from protocol tcp
set firewall family inet filter accept-ssh term discard from destination-port ssh
set firewall family inet filter accept-ssh term discard then reject
set firewall family inet filter accept-ssh term accept-ssh-out from source-prefix-list MGMT-locals
set firewall family inet filter accept-ssh term accept-ssh-out from destination-prefix-list MGMT-remote
set firewall family inet filter accept-ssh term accept-ssh-out from protocol tcp
set firewall family inet filter accept-ssh term accept-ssh-out from source-port ssh
set firewall family inet filter accept-ssh term accept-ssh-out then policer management-5m
set firewall family inet filter accept-ssh term accept-ssh-out then count accept-ssh-output
set firewall family inet filter accept-ssh term accept-ssh-out then accept
```
### filter accept-snmp
```html
set firewall family inet filter accept-snmp apply-flags omit
set firewall family inet filter accept-snmp term accept-snmp from source-prefix-list SNMP-clients
set firewall family inet filter accept-snmp term accept-snmp from source-prefix-list SNMP-community-clients
set firewall family inet filter accept-snmp term accept-snmp from destination-prefix-list INTERNAL-locals
set firewall family inet filter accept-snmp term accept-snmp from protocol udp
set firewall family inet filter accept-snmp term accept-snmp from destination-port snmp
set firewall family inet filter accept-snmp term accept-snmp from destination-port snmptrap
set firewall family inet filter accept-snmp term accept-snmp then count accept-snmp
set firewall family inet filter accept-snmp term accept-snmp then accept
set firewall family inet filter accept-snmp term discard from protocol udp
set firewall family inet filter accept-snmp term discard from destination-port snmp
set firewall family inet filter accept-snmp term discard from destination-port snmptrap
set firewall family inet filter accept-snmp term discard then reject
```
### filter accept-ntp
```html
set firewall family inet filter accept-ntp apply-flags omit
set firewall family inet filter accept-ntp term accept-ntp from source-prefix-list NTP-servers-v4
set firewall family inet filter accept-ntp term accept-ntp from source-prefix-list localhost-v4
set firewall family inet filter accept-ntp term accept-ntp from destination-prefix-list localhost-v4
set firewall family inet filter accept-ntp term accept-ntp from destination-prefix-list router-ipv4
set firewall family inet filter accept-ntp term accept-ntp from destination-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-ntp term accept-ntp from protocol udp
set firewall family inet filter accept-ntp term accept-ntp from port ntp
set firewall family inet filter accept-ntp term accept-ntp then policer management-512k
set firewall family inet filter accept-ntp term accept-ntp then count accept-ntp
set firewall family inet filter accept-ntp term accept-ntp then accept
```
### filter accept-dns
```html
set firewall family inet filter accept-dns apply-flags omit
set firewall family inet filter accept-dns term accept-dns from source-prefix-list DNS-servers-v4
set firewall family inet filter accept-dns term accept-dns from destination-prefix-list router-ipv4
set firewall family inet filter accept-dns term accept-dns from protocol udp
set firewall family inet filter accept-dns term accept-dns from protocol tcp
set firewall family inet filter accept-dns term accept-dns from source-port 53
set firewall family inet filter accept-dns term accept-dns then policer management-1m
set firewall family inet filter accept-dns term accept-dns then count accept-dns
set firewall family inet filter accept-dns term accept-dns then accept
```
### filter accept-tacacs
```html
set firewall family inet filter accept-tacacs apply-flags omit
set firewall family inet filter accept-tacacs term accept-tacacs from source-prefix-list TACPLUS-servers
set firewall family inet filter accept-tacacs term accept-tacacs from destination-prefix-list INTERNAL-locals
set firewall family inet filter accept-tacacs term accept-tacacs from protocol tcp
set firewall family inet filter accept-tacacs term accept-tacacs from protocol udp
set firewall family inet filter accept-tacacs term accept-tacacs from source-port tacacs
set firewall family inet filter accept-tacacs term accept-tacacs from source-port tacacs-ds
set firewall family inet filter accept-tacacs term accept-tacacs from tcp-established
set firewall family inet filter accept-tacacs term accept-tacacs then policer management-1m
set firewall family inet filter accept-tacacs term accept-tacacs then count accept-tacacs
set firewall family inet filter accept-tacacs term accept-tacacs then accept
```
### filter accept-radius
```html
set firewall family inet filter accept-radius apply-flags omit
set firewall family inet filter accept-radius term accept-radius from source-prefix-list RADIUS-servers
set firewall family inet filter accept-radius term accept-radius from destination-prefix-list INTERNAL-locals
set firewall family inet filter accept-radius term accept-radius from protocol udp
set firewall family inet filter accept-radius term accept-radius from source-port radius
set firewall family inet filter accept-radius term accept-radius from source-port radacct
set firewall family inet filter accept-radius term accept-radius then policer management-1m
set firewall family inet filter accept-radius term accept-radius then count accept-radius
set firewall family inet filter accept-radius term accept-radius then accept
```
### filter accept-bgp
```html
set firewall family inet filter accept-bgp apply-flags omit
set firewall family inet filter accept-bgp interface-specific
set firewall family inet filter accept-bgp term accept-bgp from source-prefix-list BGP-neighbors-v4
set firewall family inet filter accept-bgp term accept-bgp from destination-prefix-list BGP-locals-v4
set firewall family inet filter accept-bgp term accept-bgp from destination-prefix-list BGP-locals-v4-gr
set firewall family inet filter accept-bgp term accept-bgp from protocol tcp
set firewall family inet filter accept-bgp term accept-bgp from protocol udp
set firewall family inet filter accept-bgp term accept-bgp from port bgp
set firewall family inet filter accept-bgp term accept-bgp from port 4784
set firewall family inet filter accept-bgp term accept-bgp from port 3785
set firewall family inet filter accept-bgp term accept-bgp from port 3784
set firewall family inet filter accept-bgp term accept-bgp then count accept-bgp
set firewall family inet filter accept-bgp term accept-bgp then accept
```
### filter accept-api
```html
set firewall family inet filter accept-api apply-flags omit
set firewall family inet filter accept-api term accept-api from source-prefix-list MGMT-remote
set firewall family inet filter accept-api term accept-api from destination-prefix-list MGMT-locals
set firewall family inet filter accept-api term accept-api from protocol tcp
set firewall family inet filter accept-api term accept-api from destination-port 3000
set firewall family inet filter accept-api term accept-api then policer management-5m
set firewall family inet filter accept-api term accept-api then count accept-api
set firewall family inet filter accept-api term accept-api then accept
set firewall family inet filter accept-api term discard from protocol tcp
set firewall family inet filter accept-api term discard from destination-port 3000
set firewall family inet filter accept-api term discard then reject
```
### filter accept-sh-bfd
```html
set firewall family inet filter accept-sh-bfd apply-flags omit
set firewall family inet filter accept-sh-bfd term accept-sh-bfd from source-prefix-list router-ipv4
set firewall family inet filter accept-sh-bfd term accept-sh-bfd from source-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-sh-bfd term accept-sh-bfd from destination-prefix-list router-ipv4
set firewall family inet filter accept-sh-bfd term accept-sh-bfd from destination-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-sh-bfd term accept-sh-bfd from protocol udp
set firewall family inet filter accept-sh-bfd term accept-sh-bfd from source-port 49152-65535
set firewall family inet filter accept-sh-bfd term accept-sh-bfd from destination-port 3784-3785
set firewall family inet filter accept-sh-bfd term accept-sh-bfd then count accept-sh-bfd
set firewall family inet filter accept-sh-bfd term accept-sh-bfd then accept
```
### filter accept-vrrp
```html
set firewall family inet filter accept-vrrp apply-flags omit
set firewall family inet filter accept-vrrp term accept-vrrp from source-prefix-list router-ipv4
set firewall family inet filter accept-vrrp term accept-vrrp from source-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-vrrp term accept-vrrp from destination-prefix-list vrrp
set firewall family inet filter accept-vrrp term accept-vrrp from protocol vrrp
set firewall family inet filter accept-vrrp term accept-vrrp from protocol ah
set firewall family inet filter accept-vrrp term accept-vrrp then count accept-vrrp
set firewall family inet filter accept-vrrp term accept-vrrp then accept
```
### filter accept-rsvp
```html
set firewall family inet filter accept-rsvp apply-flags omit
set firewall family inet filter accept-rsvp term accept-rsvp from destination-prefix-list router-ipv4
set firewall family inet filter accept-rsvp term accept-rsvp from destination-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-rsvp term accept-rsvp from protocol rsvp
set firewall family inet filter accept-rsvp term accept-rsvp then count accept-rsvp
set firewall family inet filter accept-rsvp term accept-rsvp then accept
set firewall family inet filter accept-rsvp term accept-self-ping from destination-prefix-list router-ipv4
set firewall family inet filter accept-rsvp term accept-self-ping from destination-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-rsvp term accept-self-ping from protocol udp
set firewall family inet filter accept-rsvp term accept-self-ping from port 8503
set firewall family inet filter accept-rsvp term accept-self-ping then accept
set firewall family inet filter accept-rsvp term accept-mpls-echo from destination-prefix-list router-ipv4
set firewall family inet filter accept-rsvp term accept-mpls-echo from destination-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-rsvp term accept-mpls-echo from protocol udp
set firewall family inet filter accept-rsvp term accept-mpls-echo from port 3503
set firewall family inet filter accept-rsvp term accept-mpls-echo then accept
set firewall family inet filter accept-rsvp term accept-rsvp from destination-prefix-list localhost-v4
set firewall family inet filter accept-rsvp term accept-self-ping from destination-prefix-list localhost-v4
set firewall family inet filter accept-rsvp term accept-mpls-echo from destination-prefix-list localhost-v4
```
### filter accept-ldp
```html
set firewall family inet filter accept-ldp apply-flags omit
set firewall family inet filter accept-ldp term accept-ldp-discover from source-prefix-list router-ipv4
set firewall family inet filter accept-ldp term accept-ldp-discover from source-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-ldp term accept-ldp-discover from destination-prefix-list multicast-all-routers
set firewall family inet filter accept-ldp term accept-ldp-discover from protocol udp
set firewall family inet filter accept-ldp term accept-ldp-discover from destination-port ldp
set firewall family inet filter accept-ldp term accept-ldp-discover then count accept-ldp-discover
set firewall family inet filter accept-ldp term accept-ldp-discover then accept
set firewall family inet filter accept-ldp term accept-ldp-unicast from destination-prefix-list router-ipv4
set firewall family inet filter accept-ldp term accept-ldp-unicast from destination-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-ldp term accept-ldp-unicast from protocol tcp
set firewall family inet filter accept-ldp term accept-ldp-unicast from port ldp
set firewall family inet filter accept-ldp term accept-ldp-unicast then count accept-ldp-unicast
set firewall family inet filter accept-ldp term accept-ldp-unicast then accept
set firewall family inet filter accept-ldp term accept-tldp-discover from destination-prefix-list router-ipv4
set firewall family inet filter accept-ldp term accept-tldp-discover from destination-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-ldp term accept-tldp-discover from protocol udp
set firewall family inet filter accept-ldp term accept-tldp-discover from destination-port ldp
set firewall family inet filter accept-ldp term accept-tldp-discover then count accept-tldp-discover
set firewall family inet filter accept-ldp term accept-tldp-discover then accept
set firewall family inet filter accept-ldp term accept-ldp-igmp from source-prefix-list router-ipv4
set firewall family inet filter accept-ldp term accept-ldp-igmp from source-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-ldp term accept-ldp-igmp from destination-prefix-list multicast-all-routers
set firewall family inet filter accept-ldp term accept-ldp-igmp from protocol igmp
set firewall family inet filter accept-ldp term accept-ldp-igmp then count accept-ldp-igmp
set firewall family inet filter accept-ldp term accept-ldp-igmp then accept
```
### filter accept-ospf
```html
set firewall family inet filter accept-ospf apply-flags omit
set firewall family inet filter accept-ospf term accept-ospf from source-prefix-list router-ipv4
set firewall family inet filter accept-ospf term accept-ospf from source-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-ospf term accept-ospf from destination-prefix-list router-ipv4
set firewall family inet filter accept-ospf term accept-ospf from destination-prefix-list ospf
set firewall family inet filter accept-ospf term accept-ospf from destination-prefix-list router-ipv4-logical-systems
set firewall family inet filter accept-ospf term accept-ospf from protocol ospf
set firewall family inet filter accept-ospf term accept-ospf then count accept-ospf
set firewall family inet filter accept-ospf term accept-ospf then accept
```
### filter accept-ftp
```html
set firewall family inet filter accept-ftp apply-flags omit
set firewall family inet filter accept-ftp term accept-ftp from source-prefix-list MGMT-remote
set firewall family inet filter accept-ftp term accept-ftp from destination-prefix-list MGMT-locals
set firewall family inet filter accept-ftp term accept-ftp from protocol tcp
set firewall family inet filter accept-ftp term accept-ftp from port ftp
set firewall family inet filter accept-ftp term accept-ftp from port ftp-data
set firewall family inet filter accept-ftp term accept-ftp from port 49152-65534
set firewall family inet filter accept-ftp term accept-ftp then policer management-5m
set firewall family inet filter accept-ftp term accept-ftp then count accept-ftp
set firewall family inet filter accept-ftp term accept-ftp then count accept
```
### filter discard-all
```html
set firewall family inet filter discard-all apply-flags omit
set firewall family inet filter discard-all term discard-ip-options from ip-options any
set firewall family inet filter discard-all term discard-ip-options then count discard-ip-options
set firewall family inet filter discard-all term discard-ip-options then log
set firewall family inet filter discard-all term discard-ip-options then discard
set firewall family inet filter discard-all term discard-TTL_1-unknown from ttl 1
set firewall family inet filter discard-all term discard-TTL_1-unknown then count discard-TTL_1-unknown
set firewall family inet filter discard-all term discard-TTL_1-unknown then log
set firewall family inet filter discard-all term discard-TTL_1-unknown then discard
set firewall family inet filter discard-all term discard-tcp from protocol tcp
set firewall family inet filter discard-all term discard-tcp then count discard-tcp
set firewall family inet filter discard-all term discard-tcp then log
set firewall family inet filter discard-all term discard-tcp then discard
set firewall family inet filter discard-all term discard-udp from protocol udp
set firewall family inet filter discard-all term discard-udp then count discard-udp
set firewall family inet filter discard-all term discard-udp then log
set firewall family inet filter discard-all term discard-udp then discard
set firewall family inet filter discard-all term discard-icmp from destination-prefix-list router-ipv4
set firewall family inet filter discard-all term discard-icmp from protocol icmp
set firewall family inet filter discard-all term discard-icmp then count discard-icmp
set firewall family inet filter discard-all term discard-icmp then log
set firewall family inet filter discard-all term discard-icmp then discard
set firewall family inet filter discard-all term discard-unknown then count discard-unknown
set firewall family inet filter discard-all term discard-unknown then log
set firewall family inet filter discard-all term discard-unknown then discard
```
## Family inet6
### filter accept-v6-common-services
```html
set firewall family inet6 filter accept-v6-common-services apply-flags omit
set firewall family inet6 filter accept-v6-common-services term protect-TRACEROUTE filter accept-v6-traceroute
set firewall family inet6 filter accept-v6-common-services term protect-ICMP filter accept-v6-icmp
set firewall family inet6 filter accept-v6-common-services term protect-NTP filter accept-v6-ntp
set firewall family inet6 filter accept-v6-common-services term protect-DNS filter accept-v6-dns
set firewall family inet6 filter accept-v6-common-services term protect-bgp filter accept-v6-bgp
```
### filter accept-v6-traceroute
```html
set firewall family inet6 filter accept-v6-traceroute apply-flags omit
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-udp from destination-prefix-list router-ipv6
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-udp from next-header udp
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-udp from destination-port 33434-33450
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-udp from hop-limit 1
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-udp then policer management-1m
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-udp then count accept-v6-traceroute-udp
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-udp then accept
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-tcp from destination-prefix-list router-ipv6
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-tcp from next-header tcp
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-tcp from hop-limit 1
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-tcp then policer management-1m
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-tcp then count accept-v6-traceroute-tcp
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-tcp then accept
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from destination-prefix-list router-ipv6
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from next-header icmp6
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from icmp-type echo-reply
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from icmp-type echo-request
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from icmp-type router-advertisement
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from icmp-type parameter-problem
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from icmp-type destination-unreachable
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from icmp-type packet-too-big
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from icmp-type router-solicit
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from icmp-type neighbor-solicit
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from icmp-type neighbor-advertisement
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from icmp-type redirect
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp from hop-limit 1
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp then policer management-1m
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp then count accept-v6-traceroute-icmp
set firewall family inet6 filter accept-v6-traceroute term accept-v6-traceroute-icmp then accept
```
### filter accept-v6-icmp
```html
set firewall family inet6 filter accept-v6-icmp apply-flags omit
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp from next-header icmp6
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp from icmp-type echo-reply
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp from icmp-type echo-request
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp from icmp-type time-exceeded
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp from icmp-type router-advertisement
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp from icmp-type parameter-problem
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp from icmp-type destination-unreachable
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp from icmp-type packet-too-big
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp from icmp-type router-solicit
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp from icmp-type neighbor-solicit
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp from icmp-type neighbor-advertisement
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp from icmp-type redirect
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp then policer management-1m
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp then count accept-v6-icmp
set firewall family inet6 filter accept-v6-icmp term accept-v6-icmp then accept
```
### filter accept-v6-ntp
```html
set firewall family inet6 filter accept-v6-ntp apply-flags omit
set firewall family inet6 filter accept-v6-ntp term accept-v6-ntp from source-prefix-list NTP-servers-v6
set firewall family inet6 filter accept-v6-ntp term accept-v6-ntp from source-prefix-list localhost-v6
set firewall family inet6 filter accept-v6-ntp term accept-v6-ntp from destination-prefix-list localhost-v6
set firewall family inet6 filter accept-v6-ntp term accept-v6-ntp from destination-prefix-list router-ipv6
set firewall family inet6 filter accept-v6-ntp term accept-v6-ntp from next-header udp
set firewall family inet6 filter accept-v6-ntp term accept-v6-ntp from port ntp
set firewall family inet6 filter accept-v6-ntp term accept-v6-ntp then policer management-512k
set firewall family inet6 filter accept-v6-ntp term accept-v6-ntp then count accept-v6-ntp
set firewall family inet6 filter accept-v6-ntp term accept-v6-ntp then accept
```
### filter accept-v6-dns
```html
set firewall family inet6 filter accept-v6-dns apply-flags omit
set firewall family inet6 filter accept-v6-dns term accept-v6-dns from source-prefix-list DNS-servers-v6
set firewall family inet6 filter accept-v6-dns term accept-v6-dns from destination-prefix-list router-ipv6
set firewall family inet6 filter accept-v6-dns term accept-v6-dns from next-header udp
set firewall family inet6 filter accept-v6-dns term accept-v6-dns from next-header tcp
set firewall family inet6 filter accept-v6-dns term accept-v6-dns from source-port 53
set firewall family inet6 filter accept-v6-dns term accept-v6-dns then policer management-1m
set firewall family inet6 filter accept-v6-dns term accept-v6-dns then count accept-v6-dns
set firewall family inet6 filter accept-v6-dns term accept-v6-dns then accept
```
### filter accept-v6-bgp
```html
set firewall family inet6 filter accept-v6-bgp apply-flags omit
set firewall family inet6 filter accept-v6-bgp interface-specific
set firewall family inet6 filter accept-v6-bgp term accept-v6-bgp from source-prefix-list BGP-neighbors-v6
set firewall family inet6 filter accept-v6-bgp term accept-v6-bgp from destination-prefix-list BGP-locals-v6
set firewall family inet6 filter accept-v6-bgp term accept-v6-bgp from destination-prefix-list BGP-locals-v6-gr
set firewall family inet6 filter accept-v6-bgp term accept-v6-bgp from next-header tcp
set firewall family inet6 filter accept-v6-bgp term accept-v6-bgp from next-header udp
set firewall family inet6 filter accept-v6-bgp term accept-v6-bgp from port bgp
set firewall family inet6 filter accept-v6-bgp term accept-v6-bgp from port 4784
set firewall family inet6 filter accept-v6-bgp term accept-v6-bgp from port 3785
set firewall family inet6 filter accept-v6-bgp term accept-v6-bgp from port 3784
set firewall family inet6 filter accept-v6-bgp term accept-v6-bgp then count accept-v6-bgp
set firewall family inet6 filter accept-v6-bgp term accept-v6-bgp then accept
```
### filter discard-v6-all
```html
set firewall family inet6 filter discard-v6-all apply-flags omit
set firewall family inet6 filter discard-v6-all term discard-v6-tcp from next-header tcp
set firewall family inet6 filter discard-v6-all term discard-v6-tcp then count discard-v6-tcp
set firewall family inet6 filter discard-v6-all term discard-v6-tcp then log
set firewall family inet6 filter discard-v6-all term discard-v6-tcp then discard
set firewall family inet6 filter discard-v6-all term discard-v6-udp from next-header udp
set firewall family inet6 filter discard-v6-all term discard-v6-udp then count discard-v6-udp
set firewall family inet6 filter discard-v6-all term discard-v6-udp then log
set firewall family inet6 filter discard-v6-all term discard-v6-udp then discard
set firewall family inet6 filter discard-v6-all term discard-v6-icmp from destination-prefix-list router-ipv6
set firewall family inet6 filter discard-v6-all term discard-v6-icmp from next-header icmp6
set firewall family inet6 filter discard-v6-all term discard-v6-icmp then count discard-v6-icmp
set firewall family inet6 filter discard-v6-all term discard-v6-icmp then log
set firewall family inet6 filter discard-v6-all term discard-v6-icmp then discard
set firewall family inet6 filter discard-v6-all term discard-v6-unknown then count discard-v6-unknown
set firewall family inet6 filter discard-v6-all term discard-v6-unknown then log
set firewall family inet6 filter discard-v6-all term discard-v6-unknown then discard
```
# Troubleshooting
```html
show firewall log
show firewall terse
show firewall filter <filter_name>
```
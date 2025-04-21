# Config Juniper:
**> show configuration interfaces ae0.300**
```html
vlan-id 300;
family inet {;
    address <ip_address>/31;
}
family mpls;
```
**> show configuration interfaces ae1.301**
```html
vlan-id 301;
family inet {
    address <ip_address>/31;
}
family mpls;
```
## OSPF
**> show configuration protocols ospf**
```html
traffic-engineering;
area 0.0.0.0 {
    interface lo0.0 {
        passive;
    }
    interface ae0.300 {
        interface-type p2p
        bfd-liveness-detection {
            minimum-interval 300;
            multiplier 4;
            full-neighbors-only;
        }
    }
    interface ae1.301 {
        interface-type p2p
        bfd-liveness-detection {
            minimum-interval 300;
            multiplier 4;
            full-neighbors-only;
        }
    }
}
```
```html
set protocols ospf traffic-engineering
set protocols ospf area 0.0.0.0 interface lo0.0 passive
set protocols ospf area 0.0.0.0 interface ae0.300 interface-type p2p
set protocols ospf area 0.0.0.0 interface ae0.300 bfd-liveness-detection minimum-interval 300
set protocols ospf area 0.0.0.0 interface ae0.300 bfd-liveness-detection multiplier 4
set protocols ospf area 0.0.0.0 interface ae0.300 bfd-liveness-detection full-neighbors-only
set protocols ospf area 0.0.0.0 interface ae1.301 interface-type p2p
set protocols ospf area 0.0.0.0 interface ae1.301 bfd-liveness-detection minimum-interval 300
set protocols ospf area 0.0.0.0 interface ae1.301 bfd-liveness-detection multiplier 4
set protocols ospf area 0.0.0.0 interface ae1.301 bfd-liveness-detection full-neighbors-only
```
## MPLS
**> show configuration protocols mpls**
```html
interface lo0.0;                        
interface ae0.300;
interface ae1.301;
label-switched-path <lsp_name> {
    to <ip_address_lo0.0>;
    fast-reroute;
    primary <lsp_path_name_prinary_or_secondary>;
    secondary <lsp_path_name_prinary_or_secondary> {
        standby;
    }
}
path <lsp_path_name_prinary_or_secondary> {
    <ip_address_link_next_hop> strict;
    <ip_address_link_next_hop> strict;
}
path <lsp_path_name_prinary_or_secondary> {
    <ip_address_lo0.0_next_router>;
    <ip_address_link_next_hop> strict;
}
```
```html
set protocols mpls interface lo0.0
set protocols mpls interface ae0.300
set protocols mpls interface ae1.301
set protocols mpls path <lsp_path_name_prinary_or_secondary> <ip_address_link_next_hop> strict
set protocols mpls path <lsp_path_name_prinary_or_secondary> <ip_address_link_next_hop> strict
set protocols mpls label-switched-path <lsp_name> to <ip_address_lo0.0>
set protocols mpls label-switched-path <lsp_name> fast-reroute
set protocols mpls label-switched-path <lsp_name> primary <lsp_path_name_prinary_or_secondary>
set protocols mpls label-switched-path <lsp_name> secondary <lsp_path_name_prinary_or_secondary> standby
```
## RSVP
**> show configuration protocols rsvp**
```html
interface lo0.0;
interface ae0.300;
interface ae1.301;
```
```html
set protocols rsvp interface lo0.0
set protocols rsvp interface ae0.300
set protocols rsvp interface ae1.301
```
## LDP
**> show configuration protocols ldp**
```html
interface lo0.0;
interface ae0.300;
interface ae1.301;
```
```html
set protocols ldp interface lo0.0
set protocols ldp interface ae0.300
set protocols ldp interface ae1.301
```
# Troubleshooting
```html
show ospf neighbor
show ospf route
show ospf database
show mpls lsp
show ldp neighbor
show ldp database
show rsvp interface
show rsvp neighbor
ping mpls *
traceroute mpls *
```
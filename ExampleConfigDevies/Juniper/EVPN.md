# EVPN

## Type Route

* Type 1 - Ethernet Auto-Discovery (A-D) Route [It is used for multihoming mechanisms (altering, mass recall of routes, split-horizon)]
* Type 2 - MAC/IP Advertisement Route [Announces MAC addresses and optionally associated IP addresses.]
```html
2:10.240.1.3:400::104::88:30:37:39:73:a0/304 MAC/IP        
                   *[EVPN/170] 00:06:05
                       Indirect
2:10.240.1.3:400::104::88:30:37:39:73:a0::10.10.104.150/304 MAC/IP        
                   *[EVPN/170] 00:06:05
                       Indirect
2:10.240.1.6:400::104::d0:07:ca:75:2f:07/304 MAC/IP        
                   *[BGP/170] 00:06:06, localpref 100, from 10.240.1.6
                      AS path: I, validation-state: unverified
                    >  to 10.1.3.37 via xe-5/1/1.335, label-switched-path PE1_to_PE2
2:10.240.1.6:400::104::d0:07:ca:75:2f:07::10.10.104.245/304 MAC/IP        
                   *[BGP/170] 00:06:06, localpref 100, from 10.240.1.6
                      AS path: I, validation-state: unverified
                    >  to 10.1.3.37 via xe-5/1/1.335, label-switched-path PE1_to_PE2
```
* Type 3 - Inclusive Multicast Ethernet Tag Route [It is used to automatically detect all PE in the domain and organize the delivery of BUM traffic (Broadcast, Unknown unicast, Multicast)]
```html
3:10.240.1.3:400::104::10.240.1.3/248 IM            
                   *[EVPN/170] 17:19:37
                       Indirect
3:10.240.1.6:400::104::10.240.1.6/248 IM            
                   *[BGP/170] 00:06:05, localpref 100, from 10.240.1.6
                      AS path: I, validation-state: unverified
                    >  to 10.1.3.37 via xe-5/1/1.335, label-switched-path PE1_to_PE2
```
* Type 4 - Ethernet Segment Route [Allows PE to discover each other within the same Ethernet (ES) segment]
* Type 5 - IP Prefix Route [Announces IP prefixes (networks), used to build L3VPN on top of EVPN]

## Type EVPN Services

# Type EVPN-services (RFC 7432)

| Тип сервиса (Service Type) | Суть                                                 | VLAN → EVI | MAC Tables                  | VLAN in the package | VLAN translation |
| :--- |:-----------------------------------------------------|:-----------|:----------------------------| :--- | :--- |
| **VLAN-based** | One VLAN — One EVI                                   | 1:1        | One                         | Deleted | ✅ Yes |
| **VLAN-bundle** | Multiple VLAN — One EVI, one common MAC table      | N:1        | One common                 | Saved | ❌ No |
| **VLAN-aware bundle** | Multiple VLAN — One EVI, everyone has their own MAC table  | N:1        | N tables (one per VLAN) | Deleted | ✅ Yes |
| **Port-based** | The entire port is a single EVI (a special case of a VLAN bundle)   | All:1      | One                        | Saved | ❌ No |
| **Port-based VLAN-aware** | The entire port is one EVI, but each VLAN has its own table. | All:1      | N tables                    | Deleted | ❌ No |

## Core Network

![evpn_1.png](pictures/evpn_1.png)


* Сonfigure between P/PE router OSPF/IS-IS, MPLS, RSVP, LSP, BGP. Create LSP PE1 <---> PE2

* Example PE2 (10.240.1.6) OSPF:

```html
set interfaces xe-0/1/0 flexible-vlan-tagging
set interfaces xe-0/1/0 mtu 9216
set interfaces xe-0/1/0 encapsulation flexible-ethernet-services
set interfaces xe-0/1/0 unit 335 vlan-id 335
set interfaces xe-0/1/0 unit 335 family inet address 10.1.3.37/31
set interfaces xe-0/1/0 unit 335 family mpls
```
```html
set routing-options router-id 10.240.1.6
set protocols ldp interface xe-0/1/0.335
set protocols mpls interface xe-0/1/0.335
set protocols ospf traffic-engineering
set protocols ospf area 0.0.0.0 interface lo0.0 passive
set protocols ospf area 0.0.0.0 interface xe-0/1/0.335 interface-type p2p
set protocols rsvp interface xe-0/1/0.335
```
```html
set protocols mpls label-switched-path PE2_to_PE1 to 10.240.1.3
```
```html
set protocols bgp group IBGP type internal
set protocols bgp group IBGP local-address 10.240.1.6
set protocols bgp group IBGP family inet-vpn unicast
set protocols bgp group IBGP family l2vpn signaling
set protocols bgp group IBGP family evpn signaling
set protocols bgp group IBGP neighbor 10.240.1.3 description PE1
```

> ECMP (*optional)

```html
set policy-options policy-statement lb then load-balance per-packet
set routing-options forwarding-table export lb
```

## Configuring the VLAN-based EVPN service (one vlan that belongs to the same bridge domain) (instance-type evpn)

```html
VLAN 104  →  EVI 400
VLAN 105  →  EVI 401
```

### CE1 (CE2 similarly, except for the port number)

```html
set interfaces xe-0/0/46 flexible-vlan-tagging
set interfaces xe-0/0/46 mtu 9216
set interfaces xe-0/0/46 encapsulation extended-vlan-bridge
set interfaces xe-0/0/46 unit 104 vlan-id 104
```
```html
set interfaces irb unit 104 family inet address 10.10.104.150/24
```
```html
set vlans test_104 vlan-id 104
set vlans test_104 interface xe-0/0/46.104
set vlans test_104 l3-interface irb.104
```

### PE1 (PE2 similarly, except for the port number and RD)

```html
[edit interfaces xe-5/1/19]
+    unit 104 {
+        description CE1-EVPN-104;
+        encapsulation vlan-bridge;
+        vlan-id 104;
+        family bridge;
+    }
[edit routing-instances]
+   evpn_vlan104 {
+       instance-type evpn;
+       protocols {
+           evpn {
+               encapsulation mpls;
+               default-gateway advertise;
+           }
+       }
+       vlan-id 104;
+       interface xe-5/1/19.104;
+       route-distinguisher 10.240.1.3:400;
+       vrf-target target:65000:400;
+   }
```

```html
set interfaces xe-5/1/19.104 vlan-id 104
set interfaces xe-5/1/19.104 encapsulation vlan-bridge
set interfaces xe-5/1/19.104 description EVPN-104
set interfaces xe-5/1/19.104 family bridge
```
```html
set routing-instances evpn_vlan104 instance-type evpn
set routing-instances evpn_vlan104 vlan-id 104
set routing-instances evpn_vlan104 interface xe-5/1/19.104 
set routing-instances evpn_vlan104 route-distinguisher 10.240.1.3:400
set routing-instances evpn_vlan104 vrf-target target:65000:400
set routing-instances evpn_vlan104 protocols evpn encapsulation mpls 
set routing-instances evpn_vlan104 protocols evpn default-gateway advertise
```

### Example

```html
> show evpn database 

Instance: evpn_vlan104
VLAN  DomainId  MAC address        Active source                  Timestamp        IP address
104             64:64:9b:14:23:c1  10.240.1.6                     Mar 18 09:39:28  10.10.104.3
104             88:30:37:39:73:a0  xe-5/1/19.104                  Mar 18 09:39:00  10.10.104.150
104             d0:07:ca:75:2f:07  10.240.1.6                     Mar 18 09:38:59  10.10.104.245
104             dc:2c:6e:5b:a4:d3  10.240.1.6                     Mar 18 09:39:26  10.10.104.249
```
```html
> show evpn mac-table

MAC flags       (S -static MAC, D -dynamic MAC, L -locally learned, C -Control MAC
    O -OVSDB MAC, SE -Statistics enabled, NM -Non configured MAC, R -Remote PE MAC, P -Pinned MAC)

Routing instance : evpn_vlan104
 Bridging domain : __evpn_vlan104__, VLAN : 104
   MAC                 MAC      Logical          NH     MAC         active
   address             flags    interface        Index  property    source
   64:64:9b:14:23:c1   DC                        1048577            10.240.1.6                    
   88:30:37:39:73:a0   D        xe-5/1/19.104   
   d0:07:ca:75:2f:07   DC                        1048577            10.240.1.6                    
   dc:2c:6e:5b:a4:d3   DC                        1048577            10.240.1.6 
```
```html
> show evpn instance evpn_vlan104 

                            Intfs       IRB intfs         MH      MAC addresses
Instance                    Total   Up  Total   Up  Nbrs  ESIs    Local  Remote
evpn_vlan104                    2    2      0    0     1     0        1       3
```
```html
> show route table evpn_vlan104 evpn-mac-address 88:30:37:39:73:a0

evpn_vlan104.evpn.0: 10 destinations, 10 routes (10 active, 0 holddown, 0 hidden)
+ = Active Route, - = Last Active, * = Both

2:10.240.1.3:400::104::88:30:37:39:73:a0/304 MAC/IP        
                   *[EVPN/170] 00:02:03
                       Indirect
2:10.240.1.3:400::104::88:30:37:39:73:a0::10.10.104.150/304 MAC/IP        
                   *[EVPN/170] 00:02:03
                       Indirect
```

## Configuring the Vlan bundle EVPN service (Multiple VLANs — one EVI, one shared MAC table) (instance-type virtual-switch)

```html
VLAN 100
VLAN 200  →  EVI 500 (one common MAC table)
VLAN 300
```

All VLANs sit in the same "room" and see each other's MAC addresses. It is rarely used because it requires MAC uniqueness across all VLANs.

In BGP announcements: all MAC addresses from different VLANs will have the same MPLS tag.

## Configuring the Vlan-aware bundle EVPN service (Multiple VLANs — one EVI, each with its own MAC table) (instance-type virtual-switch)

```html
VLAN 104 → own MAC table
VLAN 105 → own MAC table  }  EVI 600 (One instance)
VLAN 106 → own MAC table
```
all VLANs live in the same instance, but each has its own separate MAC table. This is the gold standard for providers.

In BGP announcements: despite the fact that all VLANs have one EVI, the forwarding table (LFIB) shows how each VLAN is routed to its own table
```html
B2    1038234  [0]
                via AF, control word present
                     dot1q   vlan
                    | 1000 | 1000 |
                    | 1001 | 1001 |
```



### CE1 (CE2 similarly, except for the port number)

```html
set interfaces xe-0/0/46 flexible-vlan-tagging
set interfaces xe-0/0/46 mtu 9216
set interfaces xe-0/0/46 encapsulation extended-vlan-bridge
set interfaces xe-0/0/46 unit 24 vlan-id 24
set interfaces xe-0/0/46 unit 104 vlan-id 104

set vlans test_104 vlan-id 104
set vlans test_104 interface xe-0/0/46.104
set vlans test_104 l3-interface irb.104
set vlans test_24 vlan-id 24
set vlans test_24 interface xe-0/0/46.24
set vlans test_24 l3-interface irb.24

set interfaces irb unit 24 family inet address 10.10.4.200/24
set interfaces irb unit 104 family inet address 10.10.104.150/24
```

### PE1 (PE2 similarly, except for the port number and RD)

```html
set routing-instances evpn_vlan104 instance-type virtual-switch
set routing-instances evpn_vlan104 protocols evpn encapsulation mpls
set routing-instances evpn_vlan104 protocols evpn extended-vlan-list 24
set routing-instances evpn_vlan104 protocols evpn extended-vlan-list 104
set routing-instances evpn_vlan104 bridge-domains vlan104 vlan-id 104
set routing-instances evpn_vlan104 bridge-domains vlan104 interface xe-5/1/19.104
set routing-instances evpn_vlan104 bridge-domains vlan24 vlan-id 24
set routing-instances evpn_vlan104 bridge-domains vlan24 interface xe-5/1/19.24
set routing-instances evpn_vlan104 route-distinguisher 10.240.1.3:400
set routing-instances evpn_vlan104 vrf-target target:65000:400

set interfaces xe-5/1/19 flexible-vlan-tagging
set interfaces xe-5/1/19 mtu 9216
set interfaces xe-5/1/19 encapsulation flexible-ethernet-services
set interfaces xe-5/1/19 unit 24 encapsulation vlan-bridge
set interfaces xe-5/1/19 unit 24 vlan-id 24
set interfaces xe-5/1/19 unit 24 family bridge
set interfaces xe-5/1/19 unit 104 encapsulation vlan-bridge
set interfaces xe-5/1/19 unit 104 vlan-id 104
set interfaces xe-5/1/19 unit 104 family bridge
```

### Example

```html
> show evpn database    
20.03.2026 12:15:51 +0500
Instance: evpn_vlan104
VLAN  DomainId  MAC address        Active source                  Timestamp        IP address
24              00:05:fd:00:ab:f2  10.240.1.6                     Mar 20 11:55:25  10.10.4.170
24              00:05:fd:10:01:b3  10.240.1.6                     Mar 20 11:55:15
24              d0:07:ca:75:2f:07  10.240.1.6                     Mar 20 11:55:12  10.10.4.245
104             64:64:9b:14:23:c1  10.240.1.6                     Mar 20 12:15:29  10.10.104.3
104             88:30:37:39:73:a0  xe-5/1/19.104                  Mar 20 11:50:40  10.10.104.150
104             d0:07:ca:75:2f:07  10.240.1.6                     Mar 20 11:55:12  10.10.104.245
```
```html
> show bridge mac-table                                     
20.03.2026 12:40:43 +0500

MAC flags       (S -static MAC, D -dynamic MAC, L -locally learned, C -Control MAC
    O -OVSDB MAC, SE -Statistics enabled, NM -Non configured MAC, R -Remote PE MAC, P -Pinned MAC)

Routing instance : evpn_vlan104
 Bridging domain : vlan104, VLAN : 104
   MAC                 MAC      Logical          NH     MAC         active
   address             flags    interface        Index  property    source
   88:30:37:39:73:a0   DC                        1048574            10.240.1.3                    
   d0:07:ca:75:2f:07   D        ae4.104         

MAC flags       (S -static MAC, D -dynamic MAC, L -locally learned, C -Control MAC
    O -OVSDB MAC, SE -Statistics enabled, NM -Non configured MAC, R -Remote PE MAC, P -Pinned MAC)

Routing instance : evpn_vlan104
 Bridging domain : vlan24, VLAN : 24
   MAC                 MAC      Logical          NH     MAC         active
   address             flags    interface        Index  property    source
   88:30:37:39:73:a0   DC                        1048574            10.240.1.3
   d0:07:ca:75:2f:07   D        ae4.24           

```
```html
> show evpn instance evpn_vlan104 
20.03.2026 12:25:45 +0500
                            Intfs       IRB intfs         MH      MAC addresses
Instance                    Total   Up  Total   Up  Nbrs  ESIs    Local  Remote
evpn_vlan104                    3    3      0    0     1     0        2      21
```
```html
> show route table evpn_vlan104 evpn-mac-address 88:30:37:39:73:a0 
20.03.2026 12:25:50 +0500

evpn_vlan104.evpn.0: 40 destinations, 40 routes (40 active, 0 holddown, 0 hidden)
+ = Active Route, - = Last Active, * = Both

2:10.240.1.3:400::24::88:30:37:39:73:a0/304 MAC/IP        
                   *[EVPN/170] 00:35:06
                       Indirect
2:10.240.1.3:400::104::88:30:37:39:73:a0/304 MAC/IP        
                   *[EVPN/170] 00:35:10
                       Indirect
```

## Port-based and Port-based VLAN-aware

These are exotic options where the entire physical port is treated as a single service. Not supported by all vendors.

# VRF example

* Add irb.104 to VRF (and irb.104 EVPN)
```html
test_vrf {
    instance-type vrf;
    protocols {
        evpn {
            ip-prefix-routes {
                advertise direct-nexthop;
                encapsulation mpls;
            }
        }
    }
    interface irb.104;
    route-distinguisher 10.240.1.6:401;
    vrf-target target:65000:401;
    vrf-table-label;
}
```

# Troubleshooting

```html
> show evpn database
> show evpn mac-table 
> show evpn instance <evpn_instance> 
> show evpn show route table <table_evpn> evpn-mac-address <mac>
> show bridge mac-table
```
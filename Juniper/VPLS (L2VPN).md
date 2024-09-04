**It also works without the routing interface**  
**First activate family l2vpn signaling in iBGP**
```html
[edit protocols bgp]
set family l2vpn signaling
```


**>show configuration interfaces et-3/0/4.2000**
```html
encapsulation vlan-vpls;
vlan-id 2000;
family vpls;
```
**>show configuration interfaces irb.2000**
```html
family inet {
    address *.*.*.*/*;
}
family inet6 {
    address *:*:*::*:*/*;
}
```

**>show configuration routing-instances**
```html
NAME-instance {
    protocols {
        vpls {
            site-range 40;                              ### upper limit on the maximum site identifier that can be accepted to allow a pseudowire to be brought up.
            no-tunnel-services;                         ### create LSI (label-switched interface)
            site namerouter {                           ### Sites connected to this provider equipment
                automatic-site-id;                      ### Enable automatic assignment of site identifier
            }
        }
    }
    instance-type vpls;                                 ### VPLS routing instance
    vlan-id 2000;
    routing-interface irb.2000;                         ### Routing interface name for this routing-instance
    interface et-3/0/4.2000;                            ### Interface name for this routing instance
    route-distinguisher *.*.*.*:*;                      ### Number in (16 bit:32 bit) or (32 bit 'L':16 bit) or (IP address:16 bit) format
    vrf-target target:*:*;                              ### Community format target:AS Number:*
}
```

```html
set interfaces et-3/0/4 unit 2000 encapsulation vlan-vpls
set interfaces et-3/0/4 unit 2000 vlan-id 2000
set interfaces et-3/0/4 unit 2000 family vpls

set interfaces irb unit 2000 family inet address *.*.*.*/*
set interfaces irb unit 2000 family inet6 address *:*:*::*:*/*

set routing-instances NAME-instance protocols vpls site-range 40
set routing-instances NAME-instance protocols vpls no-tunnel-services
set routing-instances NAME-instance protocols vpls site namerouter automatic-site-id
set routing-instances NAME-instance instance-type vpls
set routing-instances NAME-instance vlan-id 2000
set routing-instances NAME-instance routing-interface irb.2000
set routing-instances NAME-instance interface et-3/0/4.2000
set routing-instances NAME-instance route-distinguisher *.*.*.*:*
set routing-instances NAME-instance vrf-target target:*:*
```
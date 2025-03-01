**> show configuration interfaces ae0.300**
```html
vlan-id 300;
family inet {;
    address *.*.*.*/31;
}
family mpls;
```
**> show configuration interfaces ae1.301**
```html
vlan-id 301;
family inet {
    address *.*.*.*/31;
}
family mpls;
```

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
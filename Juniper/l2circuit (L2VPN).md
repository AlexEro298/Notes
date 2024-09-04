**>show configuration interfaces xe-1/3/0**     ### Name physical interfaces
```html
description "test"                              ### Description physical interfaces
flexible-vlan-tagging;                          ### Simultaneously supports transmission of 802.1Q VLAN single-tag and dual-tag frames on logical interfaces on the same Ethernet port.
mtu 9216;
encapsulation flexible-ethernet-services;       ### Allows you to use different family and different types of ethernet encapsulations on different units.
unit 100 {                                      ### Name logical interfaces
    description "test";                         ### Description logical interfaces
    encapsulation vlan-ccc;
    vlan-id 100;                                ### Vlan-id is usually equal to the logical interface
    family ccc;
}
```

**>show configuration protocols l2circuit**
```html
neighbor *.*.*.* {                              ### Neighbor ID
    interface xe-1/3/0.100 {                    ### Interface name
        virtual-circuit-id *;                   ### Identifier for this Layer 2 circuit (1..4294967295)
        description "test_l2circuit";           ### Description l2circuit
    }
```

```html
set interfaces xe-1/3/0 unit 100 description "test"
set interfaces xe-1/3/0 unit 100 encapsulation vlan-ccc
set interfaces xe-1/3/0 unit 100 vlan-id 100
set interfaces xe-1/3/0 unit 100 family ccc

set protocols l2circuit neighbor *.*.*.* interface xe-1/3/0.100 virtual-circuit-id ***
set protocols l2circuit neighbor *.*.*.* interface xe-1/3/0.100 description "test_l2circuit"
```
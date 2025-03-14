# Config Juniper:
**In a one or two tagged packet, the tags, tag 1 and tag 2 can carry any TPID values such as 0x8100, 0x88a8, 0x9100, and 0x9200.**
**>show configuration**
```html
interfaces {
    xe-0/3/1 {
        unit 1679 {
            vlan-id-list 1693-1695;                                                                                     ### VLAN identifier list can be used on C-VLAN interfaces (UNI - 
            input-vlan-map {                                                                                            ### VLAN map operation on input
                push;                                                                                                   ### Push a VLAN tag
                vlan-id 1679;                                                                                           ### VLAN ID to rewrite (0..4094)
            }
            output-vlan-map pop;                                                                                        ### VLAN map operation on output
        }
    }

```
```html
set interfaces xe-0/3/1 unit 1679 vlan-id-list 1693-1695
set interfaces xe-0/3/1 unit 1679 input-vlan-map push
set interfaces xe-0/3/1 unit 1679 input-vlan-map vlan-id 1679
set interfaces xe-0/3/1 unit 1679 output-vlan-map pop
```
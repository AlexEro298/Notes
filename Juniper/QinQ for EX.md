**In a one or two tagged packet, the tags, tag 1 and tag 2 can carry any TPID values such as 0x8100, 0x88a8, 0x9100, and 0x9200.**

**>show configuration**
```html
ethernet-switching-options {
    dot1q-tunneling {
        ether-type 0x8100;
    }
}
ge-4/0/16 {
    unit 0 {
        family ethernet-switching {
            port-mode access;
            vlan {
                members S-VLAN-NAME;
            }
        }
    }
}
vlans {
    S-VLAN-NAME {
        vlan-id 2000;
        dot1q-tunneling;
    }
}
```

```html
set vlans S-VLAN-NAME vlan-id 2000
set vlans S-VLAN-NAME dot1q-tunneling 2000
set interfaces ge-4/0/16 unit 0 family ethernet-switching port-mode access
set interfaces ge-4/0/16 unit 0 family ethernet-switching vlan members S-VLAN-NAME
set ethernet-switching-options dot1q-tunneling ether-type 0x8100                        ### 0x8100 - 802.1Q
```
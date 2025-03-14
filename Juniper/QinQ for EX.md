# Config Juniper:
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
                members <s_vlan_name>;
            }
        }
    }
}
vlans {
    <s_vlan_name> {
        vlan-id 2000;
        dot1q-tunneling {
            customer-vlans [ 1-1444 1446-4094 ];
        }
    }
}
```
```html
set vlans <s_vlan_name> vlan-id 2000
set vlans <s_vlan_name> dot1q-tunneling customer-vlans 1-1444
set vlans <s_vlan_name> dot1q-tunneling customer-vlans 1446-4094
set interfaces ge-4/0/16 unit 0 family ethernet-switching port-mode access
set interfaces ge-4/0/16 unit 0 family ethernet-switching vlan members <s_vlan_name>
set ethernet-switching-options dot1q-tunneling ether-type 0x8100                                                        ### 0x8100 - 802.1Q
```
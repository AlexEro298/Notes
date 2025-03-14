# Config Juniper:
```html
interfaces {
    ae0 {
        unit 2000 {
            encapsulation vlan-bridge;
            vlan-id 2000;
            family bridge;
        }
    }
}
    ae4 {
        unit 2000 {
            encapsulation vlan-bridge;
            vlan-id 2000;
            family bridge;
        }
    }
}
bridge-domains {
    NAME-BRIDGE-DOMAINS {
        domain-type bridge;
        vlan-id 2000;
        interface ae0.2000;
        interface ae4.2000;
    }
}
```
```html
set bridge-domains NAME-BRIDGE-DOMAINS domain-type bridge
set bridge-domains NAME-BRIDGE-DOMAINS vlan-id 2000
set bridge-domains NAME-BRIDGE-DOMAINS interface ae0.2000
set bridge-domains NAME-BRIDGE-DOMAINS interface ae4.2000
set interfaces ae4 unit 2000 encapsulation vlan-bridge
set interfaces ae4 unit 2000 vlan-id 2000
set interfaces ae4 unit 2000 family bridge
set interfaces ae0 unit 2000 encapsulation vlan-bridge
set interfaces ae0 unit 2000 vlan-id 2000
set interfaces ae0 unit 2000 family bridge
```
# Troubleshooting
```html
show bridge mac-table
show bridge statistics
```
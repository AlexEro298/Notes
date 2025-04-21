# Config Juniper:
**First add user radius and +attribute juniper local name (example name: remote).  
Tho steeps adding user remote in Juniper**
```html
system {
    ntp {
        server <ip_address_ntp_server>;
    }
    radius-server {
        <ip_address_radius_server> {
            secret "***"; 
            source-address <ip_address_lo0.0>;
        }
    }
}
snmp {
    community <community> {
        authorization read-only;
        clients {
            <ip_network>/<mask>;
        }
}

```
```html
set system ntp server <ip_address_ntp_server>
set system radius-server <ip_address_radius_server> secret "***"
set system radius-server <ip_address_radius_server> source-address <ip_address_lo0.0>
set snmp community <community> authorization read-only
set snmp community <community> clients <ip_network>/<mask>
```
# Troubleshooting
```html
show ntp associations
show snmp statistics
```
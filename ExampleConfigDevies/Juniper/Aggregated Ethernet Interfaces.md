# Config Juniper:
```html
chassis {
    aggregated-devices {
        ethernet {
            device-count <number_ae>;                                                                                   ### for MX Number of aggregated Ethernet devices (1..1000)
        }
interfaces {
    xe-0/0/0 {
        gigether-options {
            802.3ad ae0;                                                                                                ### example  
        }
    }
    ae0 {
    flexible-vlan-tagging;
    encapsulation flexible-ethernet-services;
    aggregated-ether-options {
        minimum-links 1;
        lacp {                                                                                                          ### LACP LAG
            passive;
            periodic fast;
    }
    unit <unit_number> {
        description <description>;
        vlan-id <vlan_id>;
    }
```
```html
set chassis aggregated-devices ethernet device-count <number_ae>
set interfaces xe-0/0/0 gigether-options 802.3ad ae0
set interfaces ae0 flexible-vlan-tagging
set interfaces ae0 encapsulation flexible-ethernet-services
set interfaces ae0 aggregated-ether-options minimum-links 1
set interfaces ae0 aggregated-ether-options lacp passive                                                                ### passive or active
set interfaces ae0 aggregated-ether-options lacp periodic fast                                                          ### fast or slow
set interfaces ae0 unit <unit_number> description <description>
set interfaces ae0 unit <unit_number> vlan-id <vlan_id>
```
# Troubleshooting
```html
show lacp interfaces
```
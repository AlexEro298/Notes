# BGP best path
```html
W - Weight (Juniper not; Cisco-specific parameter)
L - Local pref (more is better)
L - Locally originated via a network or aggregate BGP subcommand or through redistribution from an IGP
A - AS-path (shorter is better)
O - Origin type (IGP is lower than Exterior Gateway Protocol (EGP), and EGP is lower than INCOMPLETE)
M - MED (less is better)
N - Neighbor type (less is better)
I - IGP metric
```
**Juniper has a preference inside = -1 - Locar pref. Example lp=105, preference =-106**
example lp = 200
```html
8.8.8.0/24 (1 entry, 1 announced)
        *BGP    Preference: 170/-201
                Next hop type: Indirect, Next hop index: 0
                Address: 0x220283fc
                Next-hop reference count: 835633
                Source: <ip_address>
                Next hop type: Router, Next hop index: 1303
                Next hop: <ip_address> via <interface_name>, selected
                Session Id: 0x263
                Protocol next hop: <ip_address>
                Indirect next hop: 0x7721408 1048588 INH Session ID: 0x315
                State: <Active Int Ext>
                Local AS: <as_number> Peer AS: <as_number>
                Age: 11w6d 22:32:45     Metric: 0       Metric2: 0 
                Validation State: unverified 
                Task: BGP_<as_number>.<ip_address>
                Announcement bits (5): 0-KRT 4-Aggregate 5-BGP_RT_Background 6-Resolve tree 4 8-RT 
                AS path: 15169 I 
                Communities: <community>
                Accepted
                Localpref: 200
                Router ID: <ip_address_lo0.0>
                Thread: junos-main
```

# Config Juniper:
```html
group vpls {                                                                                                            ### Loopback
    type internal;
    local-address *.*.*.*;
    family inet-vpn {
        unicast;
    }
    family l2vpn {
        signaling;                                                                                                      ### L2VPN services
    }
    neighbor *.*.*.*;
}
group internal {                                                                                                        ### IRB, ip transit
    type internal;
    import ***;
    export ***;
    neighbor *.*.*.* {
        local-address *.*.*.*;
    }
group uplinks {
    type external;
    no-advertise-peer-as;
    neighbor *.*.*.* {
        local-address *.*.*.*;
        import ***;
        export ***;
        peer-as ***;
    }
group downlinks {
    neighbor *.*.*.* {
        local-address *.*.*.*;
        import ***;
        export ***;
        peer-as ***;
    }
}
group peers {
    type external;
    no-advertise-peer-as;
    neighbor *.*.*.* {
        local-address *.*.*.*;
        import ***;
        family inet {
            unicast {
                prefix-limit {
                    maximum 1000;                                                                                       ### example
                    teardown {
                        idle-timeout 2;                                                                                 ### Break BGP when the limit is reached, in minutes 1-2400
                    }
                }
            }
        }
        authentication-key <authentication-key>
        export ***;
        peer-as ***;
    }
group v6_internal {
    type internal;
    export ***;
    neighbor *:*:*:*:*:* {
        local-address *:*:*:*:*:*;
    }
group v6_uplinks {
    type external;
    no-advertise-peer-as;
    import ***;
    export ***;
    neighbor *:*:*:*:*:* {
        local-address *:*:*:*:*:*;
        peer-as ***;
    }
group v6_downlinks {
    type external;
    no-advertise-peer-as;
    neighbor *:*:*:*:*:* {
        local-address *:*:*:*:*:*;
        import ***
        export ***
        peer-as ***;
    }
group v6_peers {
    type external;
    no-advertise-peer-as;
    export ***
    neighbor *:*:*:*:*: {
        local-address *:*:*:*:*:;
        import ***;
        peer-as ***;
    }
```
# Troubleshooting
```html
show bgp summary
show bgp neighbor
show bgp group
```
**BGP best path**
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
**У Juniper под капотом preference = -1 - Locar pref. Example lp=105, preference =-106**

**> show configuration protocols bgp**
```html
group vpls {                                ### Loopback
    type internal;
    local-address *.*.*.*;
    family inet-vpn {
        unicast;
    }
    family l2vpn {
        signaling;                          ### L2VPN services
    }
    neighbor *.*.*.*;
}


group internal {                            ### IRB, ip transit
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
                    maximum 1000;                   ### example
                    teardown {
                        idle-timeout 2;             ### Break BGP when the limit is reached, in minutes 1-2400
                    }
                }
            }
        }
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

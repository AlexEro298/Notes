**BGP best path**
```html
W - Weight (Juniper not)
L - Local pref (больше лучше)
L -
A - AS-path (короче лучше)
O - Origin
M - MED (меньше лучше)
N - Neighbor type (меньше лучше)
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
        signaling;
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

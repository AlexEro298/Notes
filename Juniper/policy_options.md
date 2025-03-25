# Config Juniper:
**bogus-reject**                                                                                                        ##non-routable Internet addresses IPv4
```html
set policy-options policy-statement bogus-reject from route-filter 0.0.0.0/8 orlonger				#RFC3330		    # (this host on this network)
set policy-options policy-statement bogus-reject from route-filter 100.64.0.0/10 orlonger			#RFC6598		    # (IANA-Reserved IPv4 Prefix for Shared Address Space)
set policy-options policy-statement bogus-reject from route-filter 169.254.0.0/16 orlonger			#RFC3927		    # (Dynamic Configuration of IPv4 Link-Local Addresses)
set policy-options policy-statement bogus-reject from route-filter 192.0.0.0/24 orlonger			#RFC6890		    # (Special-Purpose IP Address Registries)
set policy-options policy-statement bogus-reject from route-filter 192.0.2.0/24 orlonger			#RFC5737		    # (IPv4 Address Blocks Reserved for Documentation)
set policy-options policy-statement bogus-reject from route-filter 198.51.100.0/24 orlonger			#RFC5737		    # (IPv4 Address Blocks Reserved for Documentation)
set policy-options policy-statement bogus-reject from route-filter 203.0.113.0/24 orlonger			#RFC5737		    # (IPv4 Address Blocks Reserved for Documentation)
set policy-options policy-statement bogus-reject from route-filter 192.88.99.0/24 orlonger			#RFC3068		    # (6to4 Relay Anycast) (отменен в RFC7526, но префикс также остается зарезервирован)
set policy-options policy-statement bogus-reject from route-filter 198.18.0.0/15 orlonger			#RFC2544		    # (Benchmarking Methodology for Network Interconnect Devices)
set policy-options policy-statement bogus-reject from route-filter 224.0.0.0/4 orlonger				#RFC5771		    # (Multicast)
set policy-options policy-statement bogus-reject from route-filter 240.0.0.0/4 orlonger 			#RFC1122		    # (Reserved)

set policy-options policy-statement bogus-reject from route-filter 127.0.0.0/8 orlonger				#RFC1122		    #loopback-address
set policy-options policy-statement bogus-reject from route-filter 172.16.0.0/12 orlonger			#RFC1918		    #localnet
set policy-options policy-statement bogus-reject from route-filter 192.168.0.0/16 orlonger			#RFC1918		    #localnet
set policy-options policy-statement bogus-reject from route-filter 10.0.0.0/8 orlonger				#RFC1918		    #localnet
set policy-options policy-statement bogus-reject then reject
```

**bogus-reject-v6**                                                                                                     ##non-routable Internet addresses IPv6
```html
64:ff9b::/96    IPv4-IPv6 Translat.         [RFC6052] 
::ffff:0:0/96   IPv4-mapped Address         [RFC4291]
100::/64        Discard-Only Address Block  [RFC6666]
2001::/23       IETF Protocol Assignments   [RFC2928] 
2001::/32       TEREDO                      [RFC4380]
2001:2::/48     Benchmarking                [RFC5180]
2001:db8::/32   Documentation               [RFC3849]
2001:10::/28    ORCHID                      [RFC4843]
2002::/16       6to4                        [RFC3056]
fc00::/7        Unique-Local                [RFC4193]
fe80::/10       Linked-Scoped Unicast       [RFC4291]
```
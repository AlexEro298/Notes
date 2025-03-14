# BGPQ4
```html
whois -T route -i origin as<number> | grep route                                                                        ### IPv4
whois -T route6 -i origin as<number> | grep route                                                                       ### IPv6
bgpq4 -Jf *** <as-set>                                                                                                  ### AS in AS-Set
```
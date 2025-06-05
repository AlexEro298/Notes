# BGPQ4
```html
whois -T route -i origin as<number> | grep route                                                                        ### IPv4
whois -T route6 -i origin as<number> | grep route                                                                      ### IPv6
whois --list-version
whois --show-version 1 as<number>        
        
bgpq4 -Jf *** <as-set>                                                                                                  ### AS in AS-Set
bgpq4 -4 -J -l <prefix_list_name> <as-set> 
```
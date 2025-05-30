# example config EoIP:
```html
config EoIP in WEB interface
```
```html
interface EoIP0/Vlan1
up
exit

interface FastEthernet0/Vlan1

interface Bridge0
include EoIP0/Vlan1
exit
```
# Troubleshooting:
```html
show ip name-server
show ip route

system configuration save
```
# GoBGP:
**copy https://github.com/osrg/gobgp/releases**
**last example: https://github.com/osrg/gobgp/releases/download/v3.37.0/gobgp_3.37.0_linux_amd64.tar.gz**
```html
mkdir -p /tmp/gobgp
cd /tmp/gobgp && curl -s -L -O https://github.com/osrg/gobgp/releases/download/v3.37.0/gobgp_3.37.0_linux_amd64.tar.gz
tar xvzf gobgp_3.37.0_linux_amd64.tar.gz
mv gobgp /usr/bin/
mv gobgpd /usr/bin/
```
```html
groupadd --system gobgpd
useradd --system -d /var/lib/gobgpd -s /bin/bash -g gobgpd gobgpd
mkdir -p /var/{lib,run,log}/gobgpd
chown -R gobgpd:gobgpd /var/{lib,run,log}/gobgpd
mkdir -p /etc/gobgpd
chown -R gobgpd:gobgpd /etc/gobgpd
```
nano /etc/gobgpd/gobgpd.conf 
```html
[global.config]
  as = 64512
  router-id = "10.10.13.78"

[[neighbors]]
  [neighbors.config]
    neighbor-address = "10.10.13.240"
    peer-as = 51028
    [neighbors.ebgp-multihop.config]
      enabled = true
    [[neighbors.afi-safis]]
    [neighbors.afi-safis.config]
      afi-safi-name = "ipv4-unicast"
#    [[neighbors.afi-safis]]
#    [neighbors.afi-safis.config]
#      afi-safi-name = "ipv6-unicast"
    [[neighbors.afi-safis]]
    [neighbors.afi-safis.config]
      afi-safi-name = "ipv4-flowspec"
#    [[neighbors.afi-safis]]
#    [neighbors.afi-safis.config]
#      afi-safi-name = "ipv6-flowspec"
```
nano /lib/systemd/system/gobgp.service
```html
[Unit]
Description=GoBGP Routing Daemon
Wants=network.target
After=network.target

[Service]
Type=notify
ExecStartPre=/usr/bin/gobgpd -f /etc/gobgpd/gobgpd.conf -d
ExecStart=/usr/bin/gobgpd -f /etc/gobgpd/gobgpd.conf --sdnotify
ExecReload=/usr/bin/kill -HUP $MAINPID
StandardOutput=journal
StandardError=journal
User=gobgpd
Group=gobgpd
AmbientCapabilities=CAP_NET_BIND_SERVICE

[Install]
WantedBy=multi-user.target
```
systemctl enable gobgp
systemctl start gobgp

# Edit route
```html
Add a route
$ gobgp global rib -a {ipv4-flowspec|ipv6-flowspec} add match <MATCH> then <THEN>
    <MATCH> : { destination <PREFIX> [<OFFSET>] |
                source <PREFIX> [<OFFSET>] |
                protocol <PROTOCOLS>... |
                fragment <FRAGMENTS>... |
                tcp-flags <TCP_FLAGS>... |
                port <ITEM>... |
                destination-port <ITEM>... |
                source-port <ITEM>... |
                icmp-type <ITEM>... |
                icmp-code <ITEM>... |
                packet-length <ITEM>... |
                dscp <ITEM>... |
                label <ITEM>... }...
    <PROTOCOLS> : [&] [<|<=|>|>=|==|!=] <PROTOCOL>
    <PROTOCOL> : egp, gre, icmp, igmp, igp, ipip, ospf, pim, rsvp, sctp, tcp, udp, unknown, <DEC_NUM>
    <FRAGMENTS> : [&] [=|!|!=] <FRAGMENT>
    <FRAGMENT> : dont-fragment, is-fragment, first-fragment, last-fragment, not-a-fragment
    <TCP_FLAGS> : [&] [=|!|!=] <TCP_FLAG>
    <TCP_FLAG> : F, S, R, P, A, U, E, C
    <ITEM> : [&] [<|<=|>|>=|==|!=] <DEC_NUM>
    <THEN> : { accept |
               discard |
               rate-limit <RATE> [as <AS>] |
               redirect <RT> |
               mark <DEC_NUM> |
               action { sample | terminal | sample-terminal } }...
    <RT> : xxx:yyy, xxx.xxx.xxx.xxx:yyy, xxxx::xxxx:yyy, xxx.xxx:yyy

# Show routes
$ gobgp global rib -a {ipv4-flowspec|ipv6-flowspec}

# Delete route
$ gobgp global rib -a {ipv4-flowspec|ipv6-flowspec} del match <MATCH_EXPR>
```
## examle:
```html
gobgp global rib -a ipv4-flowspec

gobgp global rib -a ipv4-flowspec add match source 178.216.156.43 destination 8.8.8.8/32 port 53 then discard
gobgp global rib -a ipv4-flowspec del match destination 8.8.8.8/32 port 53

```

# Troubleshooting:
```html
gobgp global rib -a ipv4-flowspec
```

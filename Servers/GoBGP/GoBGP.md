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

# Edit route FlowSpec
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

# Example commands:
## Global Configuration
```html
gobgp global as <VALUE> router-id <VALUE> [listen-port <VALUE>] [listen-addresses <VALUE>...] [mpls-label-min <VALUE>] [mpls-label-max <VALUE>]
gobgp global del all
gobgp global
```
## Operations for Global-Rib - add/del/show -
```html
gobgp global rib add <prefix> [-a <address family>]
gobgp global rib del <prefix> [-a <address family>]
gobgp global rib del all [-a <address family>]
gobgp global rib [-a <address family>]
gobgp global rib [<prefix>|<host>] [rd <rd>] [longer-prefixes|shorter-prefixes] [-a <address family>]
gobgp global rib summary [-a <address family>]
```
example:
```html
gobgp global rib add 10.33.0.0/16 -a ipv4
gobgp global rib del 10.33.0.0/16 -a ipv4
```
## Show Neighbor Status
```html
gobgp neighbor
gobgp neighbor <neighbor address>
```
## Operations for neighbor - shutdown/reset/softreset/enable/disable -
```html
gobgp neighbor add { <neighbor address> | interface <ifname> } as <as number> [ local-as <as number> | vrf <vrf-name> | route-reflector-client [<cluster-id>] | route-server-client | allow-own-as <num> | remove-private-as (all|replace) | replace-peer-as | ebgp-multihop-ttl <ttl>]
gobgp neighbor del { <neighbor address> | interface <ifname> }
gobgp neighbor <neighbor address> softreset [-a <address family>]
gobgp neighbor <neighbor address> softresetin [-a <address family>]
gobgp neighbor <neighbor address> softresetout [-a <address family>]
gobgp neighbor <neighbor address> enable
gobgp neighbor <neighbor address> disable
gobgp neighbor <neighbor address> reset
```
## Show Rib - local-rib/adj-rib-in/adj-rib-out -
```html
gobgp neighbor <neighbor address> [local|adj-in|adj-out] [-a <address family>]
gobgp neighbor <neighbor address> [local|adj-in|adj-out] [<prefix>|<host>] [rd <rd>] [longer-prefixes|shorter-prefixes] [-a <address family>]
gobgp neighbor <neighbor address> [local|adj-in|adj-out] summary [-a <address family>]
gobgp neighbor <neighbor address> adj-in <prefix> validation
```
example:
```html
gobgp neighbor 10.0.0.1 local -a ipv4
```
# Centos 9 Firewall
```html
firewall-cmd --permanent --new-service=gobgp-service
firewall-cmd --permanent --service=gobgp-service  --add-port=179/tcp
firewall-cmd --permanent --service=gobgp-service  --set-short="GoBGP Routing Daemon"
firewall-cmd --permanent --service=gobgp-service  --set-description="GoBGP Routing Daemon"
firewall-cmd --permanent --add-service=gobgp-service
firewall-cmd --reload
```
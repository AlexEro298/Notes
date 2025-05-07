# Nftables:
```html
nano  /etc/nftables.conf

nft add table inet my_table

nft add chain inet my_table my_tcp_chain
nft add chain inet my_table my_input '{ type filter hook input priority 0 ; policy drop ; }'
nft add chain inet my_table my_forward '{ type filter hook forward priority 0 ; policy drop ; }'
nft add chain inet my_table my_output '{ type filter hook output priority 0 ; policy accept ; }'
nft add chain inet my_table my_tcp_chain
nft add chain inet my_table my_udp_chain
nft add rule inet my_table my_input ct state related,established accept
nft add rule inet my_table my_input iif lo accept
nft add rule inet my_table my_input ct state invalid drop
nft add rule inet my_table my_input meta l4proto ipv6-icmp icmpv6 type '{ destination-unreachable, packet-too-big, time-exceeded, parameter-problem, mld-listener-query, mld-listener-report, mld-listener-reduction, nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert, ind-neighbor-solicit, ind-neighbor-advert, mld2-listener-report }' accept
nft add rule inet my_table my_input meta l4proto icmp icmp type '{ destination-unreachable, router-solicitation, router-advertisement, time-exceeded, parameter-problem }' accept
nft add rule inet my_table my_input meta l4proto udp ct state new jump my_udp_chain
nft add rule inet my_table my_input 'meta l4proto tcp tcp flags & (fin|syn|rst|ack) == syn ct state new jump my_tcp_chain'
nft add rule inet my_table my_input 'meta l4proto tcp tcp flags & (fin|syn|rst|ack) == syn ct state new jump my_tcp_chain'
nft add rule inet my_table my_input meta l4proto udp reject
nft add rule inet my_table my_input meta l4proto tcp reject with tcp reset
nft add rule inet my_table my_input counter reject with icmpx type port-unreachable
nft add rule inet my_table my_tcp_chain tcp dport 22 accept
nft add rule inet my_table my_tcp_chain tcp dport 53 accept
nft add rule inet my_table my_udp_chain udp dport 53 accept
nft add rule inet my_table my_udp_chain udp dport 123 accept
systemctl enable nftables.service
```
```html
**nano /etc/nftables.conf**
```html
#!/usr/sbin/nft -f

flush ruleset

#table inet filter {
#       chain input {
#               type filter hook input priority filter;
#       }
#       chain forward {
#               type filter hook forward priority filter;
#       }
#       chain output {
#               type filter hook output priority filter;
#       }
#}
table inet my_table {
        chain my_tcp_chain {
                tcp dport 22 accept
                tcp dport 53 accept
        }

        chain my_input {
                type filter hook input priority filter; policy drop;
                ct state established,related accept
                iif "lo" accept
                ct state invalid drop
                icmpv6 type { destination-unreachable, packet-too-big, time-exceeded, parameter-problem, mld-listener-query, mld-listener-report, mld-listener-done, nd-router-solicit, nd-router-advert, nd-neighbor-solicit, nd-neighbor-advert, ind-neighbor-solicit, ind-neighbor-advert, mld2-listener-report } accept
                icmp type { echo-request, echo-reply, destination-unreachable, router-advertisement, router-solicitation, time-exceeded, parameter-problem } accept
                meta l4proto udp ct state new jump my_udp_chain
                tcp flags syn / fin,syn,rst,ack ct state new jump my_tcp_chain
                tcp flags syn / fin,syn,rst,ack ct state new jump my_tcp_chain
                meta l4proto udp reject
                meta l4proto tcp reject with tcp reset
                counter reject
        }

        chain my_forward {
                type filter hook forward priority filter; policy drop;
        }

        chain my_output {
                type filter hook output priority filter; policy accept;
        }

        chain my_udp_chain {
                udp dport 53 accept
                udp dport 123 accept
        }
}
```
# Troubleshooting:
```html
nft list tables
nft list table <family> <table>                                                                                         ### example: nft list table inet my_table 
nft delete table <family> <table>                                                                                       ### remove table (all chain)
nft flush table <family> <table>                                                                                        ### clear chain in table
nft add chain  <family> <table> <chain>
nft add chain <family> <table> <chain> '{ type <type> hook <hook> priority <priority> ; }'
type:
        - filter
        - route
        - nat
hook:
        - prerouting
        - input
        - forward
        - output
        - postrouting
priority: less is better, it can be negative
systemctl status nftables.service
systemctl restart nftables.service
nft list ruleset
```
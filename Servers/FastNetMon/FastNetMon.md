# FastNetMon Centos 9
```html
wget https://install.fastnetmon.com/installer -Oinstaller
sudo chmod +x installer
sudo ./installer -install_community_edition
```
your **work** email, example: alexero@work.ru
```html
nano /etc/networks_list                                                                                                 ### add all of your networks in CIDR notation (11.22.33.0/24), form of one prefix per line
nano /etc/networks_whitelist                                                                                            ### ignore some network you may add
nano /etc/fastnetmon.conf                                                                                               ### enable netflow
systemctl restart fastnetmon
```
## Notify script
```html
sudo wget https://raw.githubusercontent.com/pavel-odintsov/fastnetmon/master/src/notify_about_attack.sh -O/usr/local/bin/notify_about_attack.sh
sudo chmod 755 /usr/local/bin/notify_about_attack.sh
nano /usr/local/bin/notify_about_attack.sh fix email_notify, example email_notify=alexero@work.ru
```
## Grafana
```html
sudo ./installer -install_graphic_stack_community                                                                       ### web - grafana
16:27:31 Please login into http://your.ip.ad.dr.ess:81 with login admin and password p@ssw0rd                           ### login/pass from the script installation
comment line in :/etc/nginx/sites-available/grafana.conf
#  auth_basic "Restricted";
#  auth_basic_user_file /etc/nginx/.htpasswd;
systemctl restart nginx
```
## FastNetMonApi
```html
config in /etc/fastnetmon.conf: enable_api = on
systemctl restart fastnetmon
systemctl status fastnetmon
example ban:
cd /opt/fastnetmon-community/app/bin/
fastnetmon_api_client ban 178.216.152.1                                                                                 ### ban <ip_address>
fastnetmon_api_client ban 192.168.1.1                                                                                   ### Query failed This IP does not belong to our subnets (not in /etc/networks_list)
fastnetmon_api_client get_banlist                                                                                       ### get ban list
fastnetmon_api_client unban 178.216.152.1                                                                               ### unban <ip_address>
```
## Firewall
```html
firewall-cmd --permanent --new-service=fastnetmon_netflow
firewall-cmd --permanent --service=fastnetmon_netflow --add-port=2055/udp
firewall-cmd --permanent --service=fastnetmon_netflow --set-short="Netflow collector fastnetmon service"
firewall-cmd --permanent --add-service=fastnetmon-web
firewall-cmd --permanent --add-service=fastnetmon_netflow
firewall-cmd --reload
```
## Clickhouse
```html
clickhouse-client
show databases
```
## GoBGP
```html
nano /etc/fastnetmon.conf

# GoBGP integration
gobgp = on
# Configuration for IPv4 announces
gobgp_next_hop = 0.0.0.0
gobgp_next_hop_host_ipv4 = 0.0.0.0
gobgp_next_hop_subnet_ipv4 = 0.0.0.0
gobgp_announce_host = on
gobgp_announce_whole_subnet = off
gobgp_community_host = 64512:666
gobgp_community_subnet = 64512:777
# Configuration for IPv6 announces
gobgp_next_hop_ipv6 = 100::1
gobgp_next_hop_host_ipv6 = 100::1
gobgp_next_hop_subnet_ipv6 = 100::1
gobgp_announce_host_ipv6 = on
gobgp_announce_whole_subnet_ipv6 = off
gobgp_community_host_ipv6 = 65001:666
gobgp_community_subnet_ipv6 = 65001:777


nano /etc/gobgpd.conf

[global.config]
  as = 64512
  router-id = "192.168.1.134"
[[neighbors]]
  [neighbors.config]
    neighbor-address = "192.168.1.188"
    peer-as = 65001
    [neighbors.ebgp-multihop.config]
      enabled = true
    [[neighbors.afi-safis]]
    [neighbors.afi-safis.config]
      afi-safi-name = "ipv4-unicast"
    [[neighbors.afi-safis]]
    [neighbors.afi-safis.config]
      afi-safi-name = "ipv6-unicast"
    [neighbors.transport.config]
      local-address = "192.168.1.134"


sudo /opt/fastnetmon-community/libraries/gobgp_3_12_0/gobgpd -f /etc/gobgpd.conf
/opt/fastnetmon-community/libraries/gobgp_3_12_0/gobgp nei 192.168.1.188

Announce custom route:
/opt/fastnetmon-community/libraries/gobgp_3_12_0/gobgp global rib add 10.33.0.0/32 -a ipv4

Withdraw route:
/opt/fastnetmon-community/libraries/gobgp_3_12_0/gobgp global rib del 10.33.0.0/32 -a ipv4
```

```html
firewall-cmd --permanent --new-service=gobgp-fastnetmon
firewall-cmd --permanent --service=gobgp-fastnetmon --add-port=179/tcp
firewall-cmd --permanent --add-service=gobgp-fastnetmon
firewall-cmd --permanent --service=gobgp-fastnetmon --set-short="FastNetMon GOBGP announce ban ip"
```
# Troubleshooting:
```html
fastnetmon_client - monitor FastNetMon’s performance you can use client
fastnetmon --version
tail -n 1000 /var/log/fastnetmon.log
```
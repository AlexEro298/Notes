# Centos 9:
## User add/remove:
```html
adduser <username>                                                                                                      ### Add user in system
passwd <username>                                                                                                       ### Change password user
usermod -aG wheel <username>                                                                                            ### Add user to Admin Group
```
## Change minimum acceptable size for the new password
```html
nano /etc/security/pwquality.conf

minlen = 5
```
## Network:
### Centos 9:
```html
nmtui
nmcli networking off && nmcli networking on                                                                             ### restart Network Adapter
systemctl restart NetworkManager
```
### OFF IPv6
```html
nano /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
sysctl -p
```
## SSH:
```html
mkdir -p .ssh && cd .ssh && echo "<your_public_key>" > authorized_keys
    
If other user add:
cd /home/<user>/ && mkdir -p .ssh && cd .ssh && echo "<your_public_key>" > authorized_keys && chmod 644 authorized_keys &&
        cd.. && chown <user>:<user> .ssh/ && chmod 700 .ssh/ 
            
nano /etc/ssh/sshd_config
PasswordAuthentication no
    
systemctl reload sshd.service
```
## dnf - packet manager
```html
dnf upgrade -y

dnf makecache
dnf clean all

dnf check-upgrade

dnf install <package_name>
dnf reinstall <package_name>
dnf remove <package_name>  

dnf upgrade <package_name>
dnf search <package_name>                                                                                                
                                                                                               
dnf repolist 
dnf list installed       

dnf repoinfo <name_repo>
dnf config-manager --set-disabled <name_repo>
dnf config-manager --set-enabled <name_repo>
```
```html
sudo dnf config-manager --set-enabled crb
dnf install https://dl.fedoraproject.org/pub/epel/epel{,-next}-release-latest-9.noarch.rpm

dnf install mc net-tools htop nmap mtr bgpq4 traceroute git lsb_release whois -y
```
## NTP

> add NTP server ([chrony_ntp.md](chrony_ntp.md))

## Firewalld

> setting [firewalld.md](firewalld.md)

## Zabbix

> add zabbix [Zabbix.md](../Zabbix/Zabbix.md)

## Proxy
```html
Proxy use, edit file: /etc/yum.conf

proxy=http://SERVER:PORT
proxy_username=USERNAME
proxy_password=PASS
proxy_auth_method=basic
```
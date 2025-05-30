# Ubuntu/Debian:
## User add/remove:
```html
useradd -m <username>
passwd <username>
```
```html
deluser --remove-all-files <username>
```
## Network:
## Debian 12:
```html
nano /etc/network/interfaces

source /etc/network/interfaces.d/*
auto lo
iface lo inet loopback
allow-hotplug ens18
iface ens18 inet static
        address 10.10.13.80/24
        gateway 10.10.13.245
        # dns-* options are implemented by the resolvconf package, if installed
        dns-nameservers 8.8.8.8
        dns-search example.com
        up ip route add 192.168.0.0/24 via 192.168.221.1 dev ens18                                                      ### example permanent static route

systemctl restart networking.service
```
## OFF IPv6
```html
nano /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
sysctl -p
```
## SSH:
```html
mkdir -p .ssh && cd .ssh && echo "<your_public-key>" > authorized_keys
    
If other user add:
cd /home/<user>/
mkdir -p .ssh && cd .ssh && echo "<your_public-key>" > authorized_keys && chown <user>:<user> .ssh/ && chmod 700 .ssh/ && chmod 644 authorized_keys 
            
nano /etc/ssh/sshd_config
PasswordAuthentication no
    
systemctl reload sshd.service
``` 
OS Ubuntu then again:
```html
/etc/ssh/sshd_config.d/50-cloud-init.conf
PasswordAuthentication no
    
systemctl reload sshd (or ssh)
service ssh restart (Ubuntu)
```
## apt - packet manager
```html
apt update -y && apt upgrade -y                                                                                         ### Update Repo and Upgrade system

apt search <tools_name>                                                                                                 ### Searching for packages in repositories
apt install <tools_name>                                                                                                ### installing packages from repositories
apt remove <tools_name>                                                                                                 ### Removing packages from system
apt repolist 
apt list installed                                                                                                      ### List install packet
apt repoinfo <name_repo>                                                                                                ### Info repo
```
```html
add-apt-repository ppa:deadsnakes/ppa -y
apt update
apt install mc iputils-ping nano net-tools htop nmap mtr bgpq4 traceroute git -y
```
### Proxy
```html
Proxy use, edit file: /etc/yum.conf

proxy=http://SERVER:PORT
proxy_username=USERNAME
proxy_password=PASS
proxy_auth_method=basic
```

# Example commands:
```html
pwd                                                                                                                     ### current directory
ls -la                                                                                                                  ### viewing catalogs
top                                                                                                                     ### or HTOP - Performance monitoring
df -h                                                                                                                   ### checking free disk space
du -sh                                                                                                                  ### occupied on the hard disk
systemctl status *                                                                                                      ### status services
systemctl list-units --type=service                                                                                     ### all active services
journalctl -n *                                                                                                         ### * recent messages in the system log
rm                                                                                                                      ### remove file (rm -r /directory)
mkdir -p                                                                                                                ### create folder
touch                                                                                                                   ### create file
cd                                                                                                                      ### move to directory
mv                                                                                                                      ### move file to *
cp                                                                                                                      ### copy file *
cat /etc/os-release
```
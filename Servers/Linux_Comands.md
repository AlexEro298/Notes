# Centos 9:
```html
hostnamectl set-hostname *                                                                                              ### Name server
adduser <username>                                                                                                      ### Add user in system
passwd <username>                                                                                                       ### Change password user
usermod –aG wheel <username>                                                                                            ### Add user to Admin Group
```

# Centos 9 Network:
```html
nmtui
nmcli networking off && nmcli networking on                                                                             ### restart Network Adapter
systemctl restart NetworkManager
```
# Debian 12 Network:
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
**OFF IPv6**
```html
nano /etc/sysctl.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
net.ipv6.conf.lo.disable_ipv6 = 1
sysctl -p
```
# SSH:
```html
mkdir -p .ssh && cd .ssh && echo "<your_public-key>" > authorized_keys

nano /etc/ssh/sshd_config
PasswordAuthentication no
    
systemctl reload sshd.service

If OS Ubuntu then again:
/etc/ssh/sshd_config.d/50-cloud-init.conf
PasswordAuthentication no
    
systemctl reload sshd (or ssh)
service ssh restart (Ubuntu)
```

# dnf or apt - packet manager
```html
dnf update -y && dnf upgrade -y                                                                                         ### Update Repo and Upgrade system

dnf search <tools_name>                                                                                                 ### Searching for packages in repositories
dnf install <tools_name>                                                                                                ### installing packages from repositories
dnf remove <tools_name>                                                                                                 ### Removing packages from system
dnf list installed                                                                                                      ### List install packet
dnf repoinfo <name_repo>                                                                                                ### Info repo



dnf install mc net-tools htop nmap mtr bgpq4 traceroute git -y
```
# Proxy
```html
Proxy use, edit file: /etc/yum.conf

proxy=http://SERVER:PORT
proxy_username=USERNAME
proxy_password=PASS
proxy_auth_method=basic
```
# Change time format (AM;PM -> 00:00-24:00)
```html
nano /etc/locale.conf                                                                                                   ### add LC_TIME

LANG=en_US.UTF-8
LC_TIME=en_GB
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
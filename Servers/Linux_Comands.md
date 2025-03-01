**Centos 9**
```html
hostnamectl set-hostname *                          ### Name server
adduser <username>                                  ### Add user in system
passwd <username>                                   ### Change password user
usermod –aG wheel <username>                        ### Add user to Admin Group
```

**Centos 9 Network**
```html
nmtui
systemctl restart NetworkManager
nmcli networking off && nmcli networking on         ### restart Network Adapter
```

**SSH only keys**
```html
mkdir -p .ssh && cd .ssh && echo "<your public-key>" > authorized_keys

nano /etc/ssh/sshd_config
PasswordAuthentication no


If OS Ubuntu then again:
/etc/ssh/sshd_config.d/50-cloud-init.conf
PasswordAuthentication no
    
systemctl reload sshd (or ssh)
service ssh restart (Ubuntu)
```

**dnf or apt** - packet manager
```html
dnf update -y && dnf upgrade -y                     ### Update Repo and Upgrade system

dnf search *                                        ### Searching for packages in repositories
dnf install *                                       ### installing packages from repositories
dnf remove *                                        ### Removing packages from system
dnf list installed                                  ### List install packet
dnf repoinfo <name_repo>                            ### Info repo



dnf install mc net-tools htop nmap mtr bgpq4 -y
```

**chrony**
```html
dnf install chrony -y
systemctl enable chronyd --now                      ### Auto-start services

nano /etc/chrony.conf
server ntp.msk-ix.ru iburst
server 0.ru.pool.ntp.org iburst
server 1.ru.pool.ntp.org iburst
server 2.ru.pool.ntp.org iburst
server 3.ru.pool.ntp.org iburst
allow 192.168.0.0/16
allow 10.0.0.0/8
allow 172.16.0/12

systemctl restart chronyd

chronyc sources
```

**Linux**
```html
pwd                                                 ### current directory
ls -la                                              ### viewing catalogs
top                                                 ### or HTOP - Performance monitoring
df -h                                               ### checking free disk space
du -sh                                              ### occupied on the hard disk
systemctl status *                                  ### status services
systemctl list-units --type=service                 ### all active services
journalctl -n *                                     ### * recent messages in the system log
rm                                                  ### remove file (rm -r /directory)
mkdir -p                                            ### create folder
touch                                               ### create file
cd                                                  ### move to directory
mv                                                  ### move file to *
cp                                                  ### copy file *
```

**Firewall-cmd**
```html
firewall-cmd --permanent --new-service=zabbix
firewall-cmd --permanent --service=zabbix --add-port=10050/tcp
firewall-cmd --permanent --service=zabbix --set-short="Zabbix Agent"
firewall-cmd --permanent --add-service=zabbix
firewall-cmd --permanent --add-service=ntp
firewall-cmd --reload
```
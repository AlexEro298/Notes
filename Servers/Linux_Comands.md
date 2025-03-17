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

# SSH:
```html
mkdir -p .ssh && cd .ssh && echo "<your_public-key>" > authorized_keys

nano /etc/ssh/sshd_config
PasswordAuthentication no


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



dnf install mc net-tools htop nmap mtr bgpq4 traceroute -y
```
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
```


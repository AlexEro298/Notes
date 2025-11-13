# Fail2Ban:

## Install Fail2Ban:
> Add epel-repo, after:
```html
dnf install fail2ban -y
```
## Config Fail2Ban
### Config Fail2Ban (Method 1 Recommended) (jail.d/*)
> cd /etc/fail2ban/jail.d/
> rm 00-firewalld.conf
> create new jail (example sshd.conf)
> nano sshd.conf (telegram external new script. If there is no script, delete the option.)
```html
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = journal
backend = systemd
maxretry = 5
findtime = 1d
bantime = 1h
action = firewallcmd-new[name=sshd] telegram
ignoreip = 127.0.0.1/8
```
> Example:
```html
[root@facilemanager alexero]# cd /etc/fail2ban/jail.d/
[root@facilemanager jail.d]# ls -la
total 4
drwxr-xr-x. 2 root root  23 Nov 13 09:09 .
drwxr-xr-x. 6 root root 158 Nov 13 09:08 ..
-rw-r--r--  1 root root 191 Nov 13 09:09 sshd.conf
[root@facilemanager jail.d]# 
```
### Config Fail2Ban (Method 2) (jail.local)
> cd /etc/fail2ban/
> cp jail.conf jail.local
> nano jail.local
```html
bantime  = 1d
findtime  = 15m
maxretry = 3
ignoreip = 127.0.0.1/8 ::1


#banaction = iptables-multiport
banaction = firewallcmd-rich-rules[actiontype=<multiport>]
```
### External script telegram notify (PHP script)
```html
cd /etc/fail2ban/action.d
nano telegram.conf
```
```html
[Definition]
actionstart = /usr/bin/login-notify "$(hostname);start;<filter>"
actionstop = /usr/bin/login-notify "$(hostname);stop;<filter>"
actioncheck =
actionban = /usr/bin/login-notify "$(hostname);<filter>;ban;<ip>"
actionunban = /usr/bin/login-notify "$(hostname);<filter>;unban;<ip>"
```

> nano /usr/bin/login-notify
```html
#!/bin/bash
if [ $# -eq 0 ]
then
    IPADDR=$(hostname -I | awk '{print $1}')
    message="ssh;${IPADDR};${PAM_SERVICE};${PAM_TYPE};${HOSTNAME};${PAM_USER};${PAM_RHOST};"
else
    message="fail2ban;$1;"
fi
password="<password>"
encrypted=$(printf "${message}" | /bin/openssl enc <metod_encrypted> -a -salt -md md5 -pass pass:"${password}" 2>/dev/null | base64)
# /usr/bin/wget --no-check-certificate --post-data="message=${encrypted}" -O /dev/null "http://<ip_server_php>/indicator/send.php"  > /dev/null 2>/dev/null &
/usr/bin/curl -k -X POST -d "message=${encrypted}" "http://<ip_server_php>/indicator/send.php" > /dev/null 2>/dev/null &
exit 0
``` 
```html
Example <metod_encrypted> = 
aes-128-cbc       aes-128-ecb       aes-192-cbc       aes-192-ecb       
aes-256-cbc       aes-256-ecb
```
### Send authentification information
> nano /etc/pam.d/login  (add last string)
```html
#%PAM-1.0
auth       substack     system-auth
auth       include      postlogin
account    required     pam_nologin.so
account    include      system-auth
password   include      system-auth
# pam_selinux.so close should be the first session rule
session    required     pam_selinux.so close
session    required     pam_loginuid.so
# pam_selinux.so open should only be followed by sessions to be executed in the user context
session    required     pam_selinux.so open
session    required     pam_namespace.so
session    optional     pam_keyinit.so force revoke
session    include      system-auth
session    include      postlogin
-session   optional     pam_ck_connector.so
session    optional     pam_exec.so type=open_session seteuid /usr/bin/login-notify
```
> nano /etc/pam.d/sshd  (add last string)
```html
#%PAM-1.0
auth       substack     password-auth
auth       include      postlogin
account    required     pam_sepermit.so
account    required     pam_nologin.so
account    include      password-auth
password   include      password-auth
# pam_selinux.so close should be the first session rule
session    required     pam_selinux.so close
session    required     pam_loginuid.so
# pam_selinux.so open should only be followed by sessions to be executed in the user context
session    required     pam_selinux.so open env_params
session    required     pam_namespace.so
session    optional     pam_keyinit.so force revoke
session    optional     pam_motd.so
session    include      password-auth
session    include      postlogin
session    optional     pam_exec.so type=open_session seteuid /usr/bin/login-notify
```

# Troubleshooting:
```html
fail2ban-client status
fail2ban-client status <sshd>
fail2ban-client banned
fail2ban-client set <sshd> unbanip <IP-address>
```
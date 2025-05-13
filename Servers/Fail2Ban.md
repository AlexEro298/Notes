# Fail2Ban:
```html
Add Epel-repo
dnf install fail2ban -y
cd /etc/fail2ban/
cp jail.conf jail.local
```
## nano jail.local
```html
bantime  = 1d
findtime  = 15m
maxretry = 3
ignoreip = 127.0.0.1/8 ::1


#banaction = iptables-multiport
banaction = firewallcmd-rich-rules[actiontype=<multiport>]
```


# Troubleshooting:
```html
fail2ban-client status
fail2ban-client status <sshd>
fail2ban-client banned
fail2ban-client set <sshd> unbanip <IP-address>
```

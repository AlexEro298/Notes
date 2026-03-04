# Routinator

> https://routinator.docs.nlnetlabs.nl/en/stable/installation.html

## Install

### Centos 9

> nano /etc/yum.repos.d/nlnetlabs.repo

```html
[nlnetlabs]
name=NLnet Labs
baseurl=https://packages.nlnetlabs.nl/linux/centos/$releasever/main/$basearch
enabled=1

```

> sudo rpm --import https://packages.nlnetlabs.nl/aptkey.asc

> sudo dnf install -y routinator

## Config

> nano /etc/routinator/routinator.conf

[config_routinator.md](config_routinator.md)

### Firewall CentOS 9

```html
firewall-cmd --permanent --new-service=routinator-web
firewall-cmd --permanent --service=routinator-web --add-port=8323/tcp
firewall-cmd --permanent --service=routinator-web --set-short="Routinator WEB"
firewall-cmd --permanent --add-service=routinator-web --zone=home
firewall-cmd --reload

firewall-cmd --permanent --new-service=routinator-rtr
firewall-cmd --permanent --service=routinator-rtr --add-port=3323/tcp
firewall-cmd --permanent --service=routinator-rtr --set-short="Routinator RTR"
firewall-cmd --permanent --add-service=routinator-rtr --zone=home
firewall-cmd --reload

firewall-cmd --permanent --add-service=routinator-rtr --zone=public
firewall-cmd --reload
```

## Upgrade

### Centos 9

```html
sudo dnf --showduplicates list routinator

sudo dnf update -y routinator
```

## Troubleshooting

```html
systemctl status routinator

journalctl --unit=routinator
```
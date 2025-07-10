# Oxidized Centos 9
```html
https://github.com/ytti/oxidized
```
```html
dnf install epel-release
dnf config-manager --set-enabled crb
dnf module enable ruby:3.1
dnf -y install ruby ruby-devel sqlite-devel openssl-devel pkgconf-pkg-config  cmake libssh-devel libicu-devel zlib-devel gcc-c++ libyaml-devel which
gem install oxidized
gem install oxidized-web    # Web interface and rest API
gem install oxidized-script # Script-based input/output extensions
```
```html
useradd -m -d /opt/oxidized -s /bin/bash oxidized
su - oxidized
oxidized
nano ~/.config/oxidized/config

<PASTE_CONFIG>
```
# Setup Oxidized as a Service
```html
nano /etc/systemd/system/oxidized.service
```
```html
# Put this file in /etc/systemd/system.
#
# To set OXIDIZED_HOME instead of the default,
# ~oxidized/.config/oxidized, uncomment (and modify as required) the
# "Environment" variable below so systemd sets the correct
# environment.

[Unit]
Description=Oxidized - Network Device Configuration Backup Tool
After=network-online.target multi-user.target
Wants=network-online.target

[Service]
ExecStart=/usr/local/bin/oxidized
User=oxidized
KillSignal=SIGKILL
#Environment="OXIDIZED_HOME=/etc/oxidized"
Restart=on-failure
RestartSec=300s

[Install]
WantedBy=multi-user.target
```
```html
systemctl enable oxidized
service oxidized start
systemctl status oxidized 
```
# NGINX
```html
dnf update -y && \
dnf install epel-release -y && \
dnf clean all && \
dnf update -y \
dnf install -y nginx httpd-tools 
htpasswd -c /etc/nginx/.oxidized_users oxidized
```
```html
EDIT FILE /etc/nginx/nginx.conf

<PASTE_CONFIG>
```
```html
nginx -t
systemctl enable nginx
```
# Troubleshooting:
```html
git ls-files

```
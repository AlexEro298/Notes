# Gitlab
```html
https://about.gitlab.com/install/#almalinux
```
```html
dnf install -y curl policycoreutils openssh-server perl
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
systemctl reload firewalld
```
```html
curl https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.rpm.sh | sudo bash

sudo EXTERNAL_URL="http://10.10.13.78" dnf install -y gitlab-ee
```
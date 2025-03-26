# Update Netbox
1. Use the same method as you used to install NetBox originally.
If you are not sure how NetBox was installed originally, check with this command:
```html
ls -ld /opt/netbox /opt/netbox/.git
```
If NetBox was installed from a release package, then /opt/netbox will be a symlink pointing to the current version,
and /opt/netbox/.git will not exist.

If it was installed from git, then /opt/netbox and /opt/netbox/.git will both exist as normal directories.
2. Update netbox 4.2.6
```htmpl
cd /opt/netbox/
git fetch --tags
git checkout v4.2.6
PYTHON=/usr/bin/python3.12 ./upgrade.sh
```
3.
```html
systemctl restart netbox netbox-rq
```
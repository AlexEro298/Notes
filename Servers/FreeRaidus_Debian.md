# FreeRadius Debian 12
```html
install -d -o root -g root -m 0755 /etc/apt/keyrings
curl -s 'https://packages.networkradius.com/pgp/packages%40networkradius.com' | \
    tee /etc/apt/keyrings/packages.networkradius.com.asc > /dev/null
printf 'Package: /freeradius/\nPin: origin "packages.networkradius.com"\nPin-Priority: 999\n' | \
    tee /etc/apt/preferences.d/networkradius > /dev/null
echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/packages.networkradius.com.asc] http://packages.networkradius.com/freeradius-3.2/debian/bookworm bookworm main" | \
    tee /etc/apt/sources.list.d/networkradius.list > /dev/null
apt-get update
apt-get install freeradius
```
# Troubleshooting:
```html
systemctl status freeradius
```

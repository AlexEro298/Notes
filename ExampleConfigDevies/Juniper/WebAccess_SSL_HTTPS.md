# Self-signed certificate for HTTPS access on Juniper
> create pair key
```html
request security pki generate-key-pair size 2048 certificate-id webaccess
```
> create certificate
```html
request security pki local-certificate generate-self-signed certificate-id webaccess email my-domain@my-domain.com domain-name my-domain.local ip-address 10.10.105.100 subject "CN=juniper.my-domain.local,OU=IT,O=Organization LLC,L=Russia,ST=Tyumen,C=RU"
```
> assigning a certificate to HTTPS
```html
set system services web-management https pki-local-certificate webaccess
```
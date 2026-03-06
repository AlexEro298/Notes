
# JunOS
## MX
### 21.2R2-S2 -> 23.4R2-S7
1. Before the update (config empty...)
```html
Model: mx480
Junos: 21.2R2-S2.3
```
2. Validate
```html
> request vmhost software validate /var/tmp/junos-vmhost-install-mx-x86-64-23.4R2-S7.4.tgz                                                                                  
Junos Validation begin. Procedure will take few minutes.
Required: 8011538226 bytes Available: 47651794944 bytes
...
Validating against /config/juniper.conf.gz
mgd: commit complete
Validation succeeded
```

3. After update
```html
Model: mx480
Junos: 23.4R2-S7.4
```
# JunOS update:

> Package QFX5 for 5100, QFX5e for 5110 and 5120 

> First, find out the current OS, delete unnecessary files.

```html
show version
request system storage cleanup
```

> Next, copy the update image to /var/tmp/ (on QFX it is jinstall-host-qfx-5e-flex-x86-64-23.4R2-S4.11-secure-signed.tgz) and compare MD5 (example QFX)

```html
Copy junos-vmhost-install-mx-x86-64-21.4R3-S5.4.tgz to juniper: /var/tmp/

Windows:
>cd C:\Users\alexero\Desktop\Junos
>certutil -hashfile jinstall-host-qfx-5e-flex-x86-64-21.4R3-S10.13-secure-signed.tgz MD5

Hash MD5 jinstall-host-qfx-5e-flex-x86-64-21.4R3-S10.13-secure-signed.tgz:
7d59ce5be99c8671c3eca1faf697a361
CertUtil: -hashfile — команда успешно выполнена.

Juniper:
user@host> start shell user root 
root@host:/var/home/remoteadmin # cd /var/tmp/
root@host:/var/tmp # ls -la junos*

-rw-r--r--  1 remoteadmin  wheel  3681691804 Mar 25 12:23 junos-vmhost-install-mx-x86-64-21.4R3-S5.4.tgz

root@host:/var/tmp # md5 junos-vmhost-install-mx-x86-64-21.4R3-S5.4.tgz 

MD5 (junos-vmhost-install-mx-x86-64-21.4R3-S5.4.tgz) = 2529eb6f65c1320a833e751e3221f547

root@host:/var/tmp # exit
exit

user@host> 
```

> Next, we update JunOS and reboot the router.

```html
>request system software add /var/tmp/jinstall-host-qfx-5e-flex-x86-64-23.4R2-S4.11-secure-signed.tgz (optional no-validate reboot)
>request system reboot
```

> After the reboot, we check the version and performance.

```html
show version
```

# Deleting old packages in /var/tmp/

```html
file ls re0:/var/tmp/junos-vmhost-install*
file rm re0:/var/tmp/junos-vmhost-install-mx-x86-64-21.4R3-S5.4.tgz
```

# Rollback JunOS

> 4 step:
> 1. show version
> 2. show system software rollback
> 3. request system software rollback
> 4. request system reboot

```html
{master:0}
alexero@qfx5120-48y-8c-test-1> show version 
localre:
--------------------------------------------------------------------------
Hostname: qfx5120-48y-8c-test-1
Model: qfx5120-48y-8c
Junos: 23.4R2-S4.11 flex
...
```
```html
{master:0}
alexero@qfx5120-48y-8c-test-1> show system software rollback 
localre:
--------------------------------------------------------------------------
Image: qfx-5e-flex-22.2R2-S1.5.202311221700 available for rollback.
```
```html
{master:0}
alexero@qfx5120-48y-8c-test-1> request system software rollback    
localre:
--------------------------------------------------------------------------
Initiating rollback on the Host.
Rolling back to qfx-5e-flex-22.2R2-S1.5.202311221700 image

Rollback staged to image qfx-5e-flex-22.2R2-S1.5.202311221700.
Reboot the system to complete installation!
```
> reboot about 8-10 minutes (rescue config and current config are saved and not changed during rollback software)
```html
{master:0}
alexero@qfx5120-48y-8c-test-1> request system reboot
```

# QFX5120Y-48Y-8C example update version

```html
jinstall-host-qfx-5e-flex-x86-64-19.1R3-S2.3-secure-signed.tgz ->
jinstall-host-qfx-5e-flex-x86-64-21.4R3-S10.13-secure-signed.tgz ->
jinstall-host-qfx-5e-flex-x86-64-23.4R2-S4.11-secure-signed.tgz
```
```html
qfx-5e-flex-22.2R2-S1.5.202311221700 -> jinstall-host-qfx-5e-flex-x86-64-23.4R2-S4.11-secure-signed.tgz
```
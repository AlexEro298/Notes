# JunOS update:

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

# QFX5120Y-48Y-8C example update

```html
jinstall-host-qfx-5e-flex-x86-64-19.1R3-S2.3-secure-signed.tgz ->
jinstall-host-qfx-5e-flex-x86-64-21.4R3-S10.13-secure-signed.tgz ->
jinstall-host-qfx-5e-flex-x86-64-23.4R2-S4.11-secure-signed.tgz
```


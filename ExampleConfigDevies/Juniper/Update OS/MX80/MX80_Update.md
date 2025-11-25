# JunOS USB Install

```html
1. USB flash formatted as FAT-32.
2. Download Junos. Example: install-media-ppc-18.4R2.7.img
3. Use Rufus/UltraISO burn the image to a USB flash drive.
4. Router has been powered off (or if the router is turned on, you will need a reboot command >request system reboot)
5. Insert the USB flash drive into the USB port on the router
6. Power on the router. Powering on the router starts the loader script and checks for a Junos OS package on the USB flash drive.
7. When the install prompt appears, enter Yes
8. After the installation is complete, remove the USB flash drive and restart the router (press enter).
9. After the reboot has completed, log in and verify that the new version of the software has been properly installed.
```

# JunOS update:

> First, find out the current OS, delete unnecessary files, and take a snapshot of the system's working status.
```html
show version
request system storage cleanup
request system snapshot
```
> Next, copy the update image to /var/tmp/ (on MX5,40,80,104 it is jinstall-ppc-21.2R3-S9.21-signed.tgz) and compare MD5 (example QFX)
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
request system software add /var/tmp/***-21.4R3-S5.4.tgz (optional no-validate reboot)
request system reboot
```
> After the reboot, we check the version and performance.
```html
show version
request system storage cleanup
request system snapshot
```

# Deleting old packages in /var/tmp/

> Example mx960 dual re (on MX80 only re0)

![Delete old JunOS packet](pictures/rm_files.png)

```html
root@mx80-test-lab> file ls re0:/var/tmp/j*   
re0:
--------------------------------------------------------------------------
/var/tmp/jinstall-ppc-21.2R3-S9.21-signed.tgz

root@mx80-test-lab>
```
```html
> file rm re0:/var/tmp/jinstall-ppc-21.2R3-S9.21-signed.tgz 

root@mx80-test-lab>
```
```html
> file ls re0:/var/tmp/j*                                      
re0:
--------------------------------------------------------------------------
/var/tmp/j*: No such file or directory

root@mx80-test-lab>
```
# MX80 example update

```html
install-media-ppc-18.4R2.7.img (2019-06-27) -> jinstall-ppc-19.4R3-S8.6-signed.tgz (2022-05-18)
jinstall-ppc-19.4R3-S8.6-signed.tgz (2022-05-18) -> jinstall-ppc-20.4R3-S6.3-signed.tgz (2023-01-12)
jinstall-ppc-20.4R3-S6.3-signed.tgz (2023-01-12) -> jinstall-ppc-21.2R3-S8.5-signed.tgz (2024-06-14)
jinstall-ppc-21.2R3-S8.5-signed.tgz (2024-06-14) -> jinstall-ppc-21.2R3-S9.21-signed.tgz (2025-04-12)
```
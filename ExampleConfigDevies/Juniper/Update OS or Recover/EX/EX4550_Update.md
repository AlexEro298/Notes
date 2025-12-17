# Upgrade EX4550-32F

## Upgrade jinstall-ex-4500-12.3R5.7-domestic-signed.tgz -> jinstall-ex-4500-15.1R7.9-domestic-signed.tgz

```html
{master:0}
root@ex4550> show version 
fpc0:
--------------------------------------------------------------------------
Hostname: ex4550
Model: ex4550-32f
JUNOS Base OS boot [12.3R5.7]
JUNOS Base OS Software Suite [12.3R5.7]
JUNOS Kernel Software Suite [12.3R5.7]
JUNOS Crypto Software Suite [12.3R5.7]
JUNOS Online Documentation [12.3R5.7]
JUNOS Enterprise Software Suite [12.3R5.7]
JUNOS Packet Forwarding Engine Enterprise Software Suite [12.3R5.7]
JUNOS Routing Software Suite [12.3R5.7]
JUNOS Web Management [12.3R5.7]
JUNOS FIPS mode utilities [12.3R5.7]
```
> Remove partitional on flash disk (diskpart clean) and insert flash to EX4550
```html
{master:0}
root@ex4550> show system snapshot 
fpc0:
--------------------------------------------------------------------------

{master:0}
root@ex4550>
```
> create snapshot partition media usb
```html
{master:0}
root@ex4550> request system snapshot partition media external    
fpc0:
--------------------------------------------------------------------------
Clearing current label...
Partitioning external media (/dev/da1) ...

Partitions on snapshot:

  Partition  Mountpoint  Size    Snapshot argument
      s1a    /altroot    2.7G    none
      s2a    /           2.7G    none
      s3d    /var/tmp    5.3G    none
      s3e    /var        1.8G    none
      s4d    /config     908M    none
Copying '/dev/da0s1a' to '/dev/da1s1a' .. (this may take a few minutes)
Copying '/dev/da0s2a' to '/dev/da1s2a' .. (this may take a few minutes)
Copying '/dev/da0s3d' to '/dev/da1s3d' .. (this may take a few minutes)
Copying '/dev/da0s3e' to '/dev/da1s3e' .. (this may take a few minutes)
Copying '/dev/da0s4d' to '/dev/da1s4d' .. (this may take a few minutes)
The following filesystems were archived: /altroot / /var/tmp /var /config
```
```html
{master:0}
root@ex4550> show system snapshot                                
fpc0:
--------------------------------------------------------------------------
Information for snapshot on       external (/dev/da1s1a) (backup)
Creation date: Oct 14 13:07:27 2025
JUNOS version on snapshot:
  jbase  : ex-12.3R5.7
  jkernel-ex: 12.3R5.7
  jcrypto-ex: 12.3R5.7
  jdocs-ex: 12.3R5.7
  jswitch-ex: 12.3R5.7
  jweb-ex: 12.3R5.7
  jpfe-ex45x: 12.3R5.7
  jroute-ex: 12.3R5.7
  fips-mode-powerpc: 12.3R5.7
Information for snapshot on       external (/dev/da1s2a) (primary)
Creation date: Oct 14 13:08:02 2025
JUNOS version on snapshot:
  jbase  : ex-12.3R5.7
  jkernel-ex: 12.3R5.7
  jcrypto-ex: 12.3R5.7
  jdocs-ex: 12.3R5.7
  jswitch-ex: 12.3R5.7
  jweb-ex: 12.3R5.7
  jpfe-ex45x: 12.3R5.7
  jroute-ex: 12.3R5.7
  fips-mode-powerpc: 12.3R5.7
```
> (optionally test) >request system reboot media external

> Check JunOS secondary = primary
```html
{master:0}
root@ex4550> show system snapshot media internal 
fpc0:
--------------------------------------------------------------------------
Information for snapshot on       internal (/dev/da0s1a) (backup)
Creation date: Dec 18 17:26:05 2013
JUNOS version on snapshot:
  jbase  : ex-12.3R5.7
  jkernel-ex: 12.3R5.7
  jcrypto-ex: 12.3R5.7
  jdocs-ex: 12.3R5.7
  jswitch-ex: 12.3R5.7
  jweb-ex: 12.3R5.7
  jpfe-ex45x: 12.3R5.7
  jroute-ex: 12.3R5.7
  fips-mode-powerpc: 12.3R5.7
Information for snapshot on       internal (/dev/da0s2a) (primary)
Creation date: Jun 9 08:23:22 2020
JUNOS version on snapshot:
  jbase  : ex-12.3R5.7
  jkernel-ex: 12.3R5.7
  jcrypto-ex: 12.3R5.7
  jdocs-ex: 12.3R5.7
  jswitch-ex: 12.3R5.7
  jweb-ex: 12.3R5.7
  jpfe-ex45x: 12.3R5.7
  jroute-ex: 12.3R5.7
  fips-mode-powerpc: 12.3R5.7
```
> copy in flash (new flash) jinstall-ex-4500-15.1R7.9-domestic-signed.tgz
```html
root@ex4550:RE:0% ls /dev/da*
/dev/da0        /dev/da0s1a     /dev/da0s2      /dev/da0s2c     /dev/da0s3c     /dev/da0s3e     /dev/da0s4c
/dev/da0s1      /dev/da0s1c     /dev/da0s2a     /dev/da0s3      /dev/da0s3d     /dev/da0s4      /dev/da0s4d
```
>  insert flash to EX4550
```html
root@ex4550:RE:0% ls /dev/da*
/dev/da0        /dev/da0s1a     /dev/da0s2      /dev/da0s2c     /dev/da0s3c     /dev/da0s3e     /dev/da0s4c     /dev/da1
/dev/da0s1      /dev/da0s1c     /dev/da0s2a     /dev/da0s3      /dev/da0s3d     /dev/da0s4      /dev/da0s4d     /dev/da1s1
```
> Note : " /dev/da1s1 " is the USB drive. If the console session is not available while inserting the USB, check the /var/log file named "messages" for logs related to "da" (for example, show log messages | match da ). The same four lines will be logged as is shown on the console if it is plugged live.
```html
root@ex4550> show log messages | match da 
Oct 14 13:32:35  ex4550 /kernel: da1 at umass-sim1 bus 1 target 0 lun 0
Oct 14 13:32:35  ex4550 /kernel: da1: < USB Flash Memory PMAP> Removable Direct Access SCSI-6 device
Oct 14 13:32:35  ex4550 /kernel: da1: 40.000MB/s transfers
Oct 14 13:32:35  ex4550 /kernel: da1: 14772MB (30253056 512 byte sectors: 255H 63S/T 1883C)
```
> mount_msdosfs /dev/da1s1 /mnt
```html
root@ex4550:RE:0% mount_msdosfs /dev/da1s1 /mnt/
root@ex4550:RE:0% 
```
```html
root@ex4550:RE:0% ls -l /mnt/jinstall*
-rwxr-xr-x  1 root  wheel  138400473 Oct 14 17:01 /mnt/jinstall-ex-4500-15.1R7.9-domestic-signed.tgz
```
> Upgrade JunOS
```html
{master:0}
root@ex4550> request system software add /mnt/jinstall-ex-4500-15.1R7.9-domestic-signed.tgz no-copy   

[Oct 14 13:57:27]: Checking pending install on fpc0

[Oct 14 13:57:45]: Validating on fpc0
[Oct 14 13:58:00]: Done with validate on all virtual chassis members

fpc0:
WARNING: A reboot is required to install the software
WARNING:     Use the 'request system reboot' command immediately

{master:0}
root@ex4550> 
```
```html
root@ex4550> request system reboot
```
> Check new JunOS
```html
{master:0}
root@ex4550> show version 
fpc0:
--------------------------------------------------------------------------
Hostname: ex4550
Model: ex4550-32f
Junos: 15.1R7.9
JUNOS EX  Software Suite [15.1R7.9]
JUNOS FIPS mode utilities [15.1R7.9]
JUNOS Online Documentation [15.1R7.9]
JUNOS EX 4500 Software Suite [15.1R7.9]
JUNOS Web Management Platform Package [15.1R7.9]
```
```html
{master:0}
root@ex4550> show system snapshot media internal 
fpc0:
--------------------------------------------------------------------------
Information for snapshot on       internal (/dev/da0s1a) (primary)
Creation date: Oct 14 14:06:22 2025
JUNOS version on snapshot:
  jdocs-ex: 15.1R7.9
  junos  : ex-15.1R7.9
  junos-ex-4500: 15.1R7.9
  jweb-ex: 15.1R7.9
Information for snapshot on       internal (/dev/da0s2a) (backup)
Creation date: Jun 9 08:23:22 2020
JUNOS version on snapshot:
  jbase  : ex-12.3R5.7
WARNING: snapshot format is incompatible with the software currently running
```
> Create snapshot in alternative partitional
```html
{master:0}
root@ex4550> request system snapshot all-members slice alternate                   
fpc0:
--------------------------------------------------------------------------
Formatting alternate root (/dev/da0s2a)...
Copying '/dev/da0s1a' to '/dev/da0s2a' .. (this may take a few minutes)
The following filesystems were archived: /

{master:0}
root@ex4550> 
```
> Verify JunOS backup=primary
```html
{master:0}
root@ex4550> show system snapshot media internal 
fpc0:
--------------------------------------------------------------------------
Information for snapshot on       internal (/dev/da0s1a) (primary)
Creation date: Oct 14 14:06:22 2025
JUNOS version on snapshot:
  jdocs-ex: 15.1R7.9
  junos  : ex-15.1R7.9
  junos-ex-4500: 15.1R7.9
  jweb-ex: 15.1R7.9
Information for snapshot on       internal (/dev/da0s2a) (backup)
Creation date: Oct 14 14:15:59 2025
JUNOS version on snapshot:
  jdocs-ex: 15.1R7.9
  junos  : ex-15.1R7.9
  junos-ex-4500: 15.1R7.9
  jweb-ex: 15.1R7.9
```
## Upgrade jinstall-ex-4500-15.1R7.9-domestic-signed.tgz -> jinstall-ex-4500-15.1R7-S13-domestic-signed.tgz
![mount_flash_to_ex4550.png](pictures/mount_flash_to_ex4550.png)
```html
{master:0}
root@ex4550> request system software add /mnt/jinstall-ex-4500-15.1R7-S13-domestic-signed.tgz no-copy 

Checking pending install on fpc0

fpc0:
Verify the signature of the new package
Verified jinstall-ex-4500-15.1R7-S13-domestic.tgz signed by PackageProductionSHA1RSA_2022 method RSA2048+SHA1
WARNING: A reboot is required to install the software
WARNING:     Use the 'request system reboot' command immediately
```
```html
```html
root@ex4550> request system reboot

yes

*** System shutdown message from root@ex4550 ***                   

System going down in 1 minute                                                  
```
> reboot for about 4-10 minutes.
# Recovery JunOS
1. Сreate partitions from the working switches on the flash drive
```html
root@ex4550> request system snapshot partition media external   
```
2.
![recovery_junos_flash.png](pictures/recovery_junos_flash.png)
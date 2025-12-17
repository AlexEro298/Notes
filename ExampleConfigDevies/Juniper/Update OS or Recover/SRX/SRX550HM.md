# JunOS update:

## introductory data

```html
> show system software 
Information for junos:

Comment:
JUNOS Software Release [15.1X49-D70.3]
```
```html
> show version 
Hostname: srx550.test
Model: srx550m
Junos: 15.1X49-D70.3
JUNOS Software Release [15.1X49-D70.3]
```
```html
> show system storage partitions 
Boot Media: internal (ad0)
Active Partition: ad0s1a
Backup Partition: ad0s2a
Currently booted from: active (ad0s1a)

Partitions information:
  Partition  Size   Mountpoint
  s1a        2.4G   /         
  s2a        2.4G   altroot   
  s3e        189M   /config   
  s3f        2.1G   /var      
  s4a        205M   recovery  
  s4e        22M   
```
```html
> show system snapshot media internal    
Information for snapshot on       internal (/dev/ad0s1a) (primary)
Creation date: Dec 15 12:13:23 2025
JUNOS version on snapshot:
  junos  : 15.1X49-D70.3-domestic
Information for snapshot on       internal (/dev/ad0s2a) (backup)
Creation date: Dec 15 03:06:09 2017
JUNOS version on snapshot:
  junos  : 15.1X49-D70.3-domestic

```

## Planned upgrade

> https://supportportal.juniper.net/s/article/Junos-upgrade-paths-for-SRX-platforms

```html
15.1X49-D70.3 --> 15.1X49-D170 --> 19.4R3 --> 20.4R1
```
> Real planned upgrade:
```html
15.1X49-D70.3 -->
junos-srxsme-15.1X49-D170.4-domestic.tgz -->
junos-srxsme-19.4R3-S4.1.tgz -->
junos-srxsme-20.4R2-S2.2.tgz -->
junos-srxsme-21.4R3-S7.9.tgz -->
junos-srxsme-22.2R3-S7.4.tgz
```

### Take snapshot USB Flash
```html
1. Creating a Snapshot on a USB Flash Drive
1.1 Insert USB Flash Drive to SRX550HM
1.2 Place the snapshot into USB flash memory: "> request system snapshot partition media usb"
```

> Example (5-10 min)

```html
> request system snapshot media usb partition    
Clearing current label...
Partitioning usb media (/dev/da0) ...
Partitions on snapshot:

  Partition  Mountpoint  Size    Snapshot argument
      s1a    /           4.7G    none
      s2a    /altroot    4.7G    none
      s3e    /config     363M    none
      s3f    /var        4.0G    none
      s4a    /recovery/software 409M none
      s4e    /recovery/state 38M none
Copying '/dev/ad0s1a' to '/dev/da0s1a' .. (this may take a few minutes)
Copying '/dev/ad0s2a' to '/dev/da0s2a' .. (this may take a few minutes)
Copying '/dev/ad0s3e' to '/dev/da0s3e' .. (this may take a few minutes)
Copying '/dev/ad0s3f' to '/dev/da0s3f' .. (this may take a few minutes)
Copying '/dev/ad0s4e' to '/dev/da0s4e' .. (this may take a few minutes)
Copying '/dev/ad0s4a' to '/dev/da0s4a' .. (this may take a few minutes)
The following filesystems were archived: / /altroot /config /var /recovery/state /recovery/software

alexero@srx550.test> 
```


### Copy Upgrade image to SRX

```html
1. In SRX: "# set system services ftp"
2. WinSCP (sftp) copy Image to /var/tmp/
```

> Verify:

```html
> file ls /var/tmp/j*  
/var/tmp/junos-srxsme-15.1X49-D170.4-domestic.tgz
```

### Upgrade and reboot

```html
request system software add /var/tmp/junos-srxsme-15.1X49-D170.4-domestic.tgz no-copy no-validate reboot
```

> Example (5-8 minuites):

```html
> request system software add /var/tmp/junos-srxsme-15.1X49-D170.4-domestic.tgz no-copy    
NOTICE: Validating configuration against junos-srxsme-15.1X49-D170.4-domestic.tgz.
NOTICE: Use the 'no-validate' option to skip this if desired.
Formatting alternate root (/dev/ad0s2a)...
/dev/ad0s2a: 2529.8MB (5181084 sectors) block size 16384, fragment size 2048
        using 14 cylinder groups of 183.62MB, 11752 blks, 23552 inodes.
super-block backups (for fsck -b #) at:
 32, 376096, 752160, 1128224, 1504288, 1880352, 2256416, 2632480, 3008544,
 3384608, 3760672, 4136736, 4512800, 4888864
Checking compatibility with configuration
Initializing...
Verified manifest signed by PackageProductionEc_2016 method ECDSA256+SHA256
Using junos-15.1X49-D170.4-domestic from /altroot/cf/packages/install-tmp/junos-15.1X49-D170.4-domestic
Copying package ...
Verified manifest signed by PackageProductionEc_2019 method ECDSA256+SHA256
Hardware Database regeneration succeeded
Validating against /config/juniper.conf.gz
usage: cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] source_file target_file
       cp [-R [-H | -L | -P]] [-f | -i | -n] [-pv] source_file ... target_directory
[edit system]
  'arp'
    warning: statement has no contents; ignored
Chassis control process: <xnm:warning xmlns="http://xml.juniper.net/xnm/1.1/xnm" xmlns:xnm="http://xml.juniper.net/xnm/1.1/xnm">
Chassis control process: <source-daemon>chassisd</source-daemon>
Chassis control process: <message>realtime-ukernel-thread is disable. Please use the command request system reboot.</message>
Chassis control process: </xnm:warning>
mgd: commit complete
Validation succeeded
Validating against /config/rescue.conf.gz
[edit system]
  'arp'
    warning: statement has no contents; ignored
Chassis control process: <xnm:warning xmlns="http://xml.juniper.net/xnm/1.1/xnm" xmlns:xnm="http://xml.juniper.net/xnm/1.1/xnm">
Chassis control process: <source-daemon>chassisd</source-daemon>
Chassis control process: <message>realtime-ukernel-thread is disable. Please use the command request system reboot.</message>
Chassis control process: </xnm:warning>
mgd: commit complete
Validation succeeded
Installing package '/altroot/cf/packages/install-tmp/junos-15.1X49-D170.4-domestic' ...
Verified junos-boot-srxsme-15.1X49-D170.4.tgz signed by PackageProductionEc_2019 method ECDSA256+SHA256
Verified junos-srxsme-15.1X49-D170.4-domestic signed by PackageProductionEc_2019 method ECDSA256+SHA256
JUNOS 15.1X49-D170.4 will become active at next reboot
WARNING: A reboot is required to load this software correctly
WARNING:     Use the 'request system reboot' command
WARNING:         when software installation is complete

WARNING:     The DHCP configuration command used will be deprecated in future Junos releases.
WARNING:     Please see documentation for updated commands.

Saving state for rollback ...
```

```html
alexero@srx550.test> show system software 
Information for junos:

Comment:
JUNOS Software Release [15.1X49-D170.4]

alexero@srx550.test> show version detail 
Hostname: srx550.test
Model: srx550m
Junos: 15.1X49-D170.4
JUNOS Software Release [15.1X49-D170.4]
KERNEL 15.1X49-D170.4 #0 built by builder on 2019-02-22 22:34:42 UTC
```
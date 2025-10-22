# EXOS Upgrade
## Сollecting information
> Check switch, version
```html
x670.4 # show switch 

SysName:          x670
SysLocation:      <sysLocation>
SysContact:       <sysContact>
System MAC:       <MAC>
System Type:      X670-48x

SysHealth check:  Enabled (Normal)
Recovery Mode:    All
System Watchdog:  Enabled

Current Time:     Wed Oct 22 10:49:56 2025
Timezone:         [Auto DST Disabled] GMT Offset: 300 minutes, name is not set.
Boot Time:        Wed Nov 11 20:54:53 2020
Boot Count:       15
Next Reboot:      None scheduled
System UpTime:    1805 days 13 hours 55 minutes 3 seconds 

Current State:    OPERATIONAL             
Image Selected:   primary                 
Image Booted:     primary                 
Primary ver:      15.4.1.3                
                  patch1-12
Secondary ver:    15.2.1.5    

Config Selected:  primary.cfg                                          
Config Booted:    primary.cfg                                          

primary.cfg       Created by ExtremeXOS version 15.4.1.3
                  437282 bytes saved on Mon Oct 20 13:27:36 2025
```
```html
x670.5 # show version 
Switch      : <SN> BootROM: 2.0.1.7    IMG: 15.4.1.3  
PSU-1       : Internal PSU-1 <SN>
PSU-2       : Internal PSU-2 <SN>

Image   : ExtremeXOS version 15.4.1.3 v1541b3-patch1-12 by release-manager
          on Sat May 3 12:30:21 EDT 2014
BootROM : 2.0.1.7
Diagnostics : 6.3
```
```html
x670.13 # show version images 
Card  Partition     Installation Date        Version     Name      Branch
------------------------------------------------------------------------------
Switch primary   Thu Jun 19 15:29:02 ___ 2014 15.4.1.3 summitX-15.4.1.3-patch1-12.xos v1541b3-patch1-12
Switch primary   Thu Jun 19 15:30:50 ___ 2014 15.4.1.3 summitX-15.4.1.3-patch1-12-ssh.xmod v1541b3-patch1-12
Switch secondary Wed Jan 30 17:41:11 UTC 2013 15.2.1.5 summitX-15.2.1.5.xos v1521b5
Switch secondary Wed Jan 30 17:44:06 UTC 2013 15.2.1.5 summitX-15.2.1.5-ssh.xmod v1521b5
```
## EXOS update:
> As seen earlier, the switch starts with the primary firmware (Image Booted:     primary).
> 
> Download the new firmware in secondary
> 
> download image <ip-ftp-server> <name.xos> vr "VR-Default" secondary
```html
x670 # download image 10.10.105.200 summitX-16.2.5.4-patch1-31.xos vr "VR-Default" secondary
yes
```
```html
x670.14 # download image 10.10.105.200 summitX-16.2.5.4-patch1-31.xos vr "VR-Default" secondary 
Do you want to install image after downloading? (y - yes, n - no, <cr> - cancel) Yes

Downloading to Switch...............................................................................................................................................................
Installing to secondary partition!

Installing to Switch.....................................................................................................................................................................................................................................................................................................................................................................................................................................................................
Image installed successfully
This image will be used only after rebooting the switch!
x670.15 # 
```
> check info
```html
x670.16 # show version images 
Card  Partition     Installation Date        Version     Name      Branch
------------------------------------------------------------------------------
Switch primary   Thu Jun 19 15:29:02 ___ 2014 15.4.1.3 summitX-15.4.1.3-patch1-12.xos v1541b3-patch1-12
Switch primary   Thu Jun 19 15:30:50 ___ 2014 15.4.1.3 summitX-15.4.1.3-patch1-12-ssh.xmod v1541b3-patch1-12
Switch secondary Wed Oct 22 11:53:23 Unknown 2025 16.2.5.4 summitX-16.2.5.4-patch1-31.xos 16.2.5.4-patch1-31
 

x670.17 # show sw

SysName:          x670
SysLocation:      <sysLocation>
SysContact:       <sysContact>
System MAC:       <MAC>
System Type:      X670-48x

SysHealth check:  Enabled (Normal)
Recovery Mode:    All
System Watchdog:  Enabled

Current Time:     Wed Oct 22 11:59:41 2025
Timezone:         [Auto DST Disabled] GMT Offset: 300 minutes, name is not set.
Boot Time:        Wed Nov 11 20:54:53 2020
Boot Count:       15
Next Reboot:      None scheduled
System UpTime:    1805 days 15 hours 4 minutes 48 seconds 

Current State:    OPERATIONAL             
Image Selected:   secondary               
Image Booted:     primary                 
Primary ver:      15.4.1.3                
                  patch1-12
Secondary ver:    16.2.5.4    

Config Selected:  primary.cfg                                          
Config Booted:    primary.cfg                                          

primary.cfg       Created by ExtremeXOS version 15.4.1.3
                  437282 bytes saved on Mon Oct 20 13:27:36 2025
x670.18 #  
```
> Choosing to use secondary firmware after a reboot and primary config
```html
use image secondary
use configuration primary
```
> (optional) reboot
```html
reboot
```
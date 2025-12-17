# JunOS Recover

## Preparation

### Repair with USB stick (1)

```html
The JunOS installation image (junos-srxsme-<version>-domestic.tgz) 
    must be stored in the root directory of a FAT32 formatted USB stick.
```
```html
The USB stick must be connected to the Juniper device before (re)boot.
```

### Repair with TFTP server (2)

```html
The JunOS installation image (junos-srxsme-<version>-domestic.tgz) 
    must be stored in the TFTP-server’s directory and must have the 
    correct permissions (usually world readable) that it can be downloaded by TFTP.
```
```html
The Ethernet cable through that the Juniper device can reach the TFTP-server 
must be connected to port 0 of the SRX or EX. But TFTP-server and Juniper device 
need not to be in the same network.
```

## Activate the boot-loader

1. Connect to the console of the Juniper device (9600,8,N,1).
2. Reboot the SRX/EX and
3. wait for the message

> Loading /boot/defaults/loader.conf

and a few lines later

> Hit [Enter] to boot immediately, or space bar for command prompt

4. Press Space to get to the Loader>-prompt

## Load and install the JunOS operating system

### Using USB (1)

1. Connect the USB stick
2. Boot the device and access the boot-loader like described above.
3. At the Loader>   -prompt install the JunOS image with

> install file:///junos-srxsme-12.1X46-D15.3-domestic.tgz

( 12.1X46-D15.3 is the JunOS Version in this example)

4. After successful installation the Juniper device will boot automatically.

### Using TFTP (2)

1. Boot the device and access the boot-loader like described above.
2. At the Loader>  -prompt set the environment variables according to your setup like in this example:
```html
set ipaddr=192.168.1.2
set netmask=255.255.255.0
set gatewayip=192.168.1.1
set serverip=192.168.2.10
save
```
(The SRX’s IP in this example is 192.168.1.2 and the TFTP-server’s 192.168.2.10.)

3. Now install the JunOS image with

> install tftp://192.168.2.10/junos-srxsme-12.1X46-D15.3-domestic.tgz

⚠ The IP address is the install command must match that one of the environment variable serverip.

4. After successful installation the Juniper device will boot automatically.
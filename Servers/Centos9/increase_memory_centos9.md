# Increase memory CentOS 9
1. Attention! Make sure to make a backup copy of your data before you start LVM expansion work! (Take snapshot!!!)
2. Introductory data:
```html
[root@fastnetmon alexero]# cat /etc/os-release 
NAME="CentOS Stream"
VERSION="9"
ID="centos"
ID_LIKE="rhel fedora"
VERSION_ID="9"
PLATFORM_ID="platform:el9"
PRETTY_NAME="CentOS Stream 9"
ANSI_COLOR="0;31"
LOGO="fedora-logo-icon"
CPE_NAME="cpe:/o:centos:centos:9"
HOME_URL="https://centos.org/"
BUG_REPORT_URL="https://issues.redhat.com/"
REDHAT_SUPPORT_PRODUCT="Red Hat Enterprise Linux 9"
REDHAT_SUPPORT_PRODUCT_VERSION="CentOS Stream"
```
```html
[root@fastnetmon alexero]# df -h
Filesystem           Size  Used Avail Use% Mounted on
devtmpfs             4.0M     0  4.0M   0% /dev
tmpfs                5.8G     0  5.8G   0% /dev/shm
tmpfs                2.3G  8.6M  2.3G   1% /run
/dev/mapper/cs-root  192G  154G   38G  81% /
/dev/sda1            960M  463M  498M  49% /boot
tmpfs                1.2G     0  1.2G   0% /run/user/1000
```
```html
[root@fastnetmon alexero]# fdisk -l
Disk /dev/sda: 200 GiB, 214748364800 bytes, 419430400 sectors
Disk model: QEMU HARDDISK   
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xe83a354c

Device     Boot   Start       End   Sectors  Size Id Type
/dev/sda1  *       2048   2099199   2097152    1G 83 Linux
/dev/sda2       2099200 419430399 417331200  199G 8e Linux LVM


Disk /dev/mapper/cs-root: 191.13 GiB, 205223100416 bytes, 400826368 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes


Disk /dev/mapper/cs-swap: 7.87 GiB, 8447328256 bytes, 16498688 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
```
> A disk divided into 4 partitions can no longer be expanded!!!
> If your command output looks as shown above, everything is fine.
> You have only two partitions so far, /dev/sda1 and /dev/sda2. You can create two more.
3. 
```html

```
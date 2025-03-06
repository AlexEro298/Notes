**Usb install**

```html
To pre-install the software on a USB flash drive, ensure the following:
The USB flash drive meets the MX Series router USB port specifications.
The USB flash drive is empty and formatted as FAT-32.
The USB flash drive capacity is large enough to accommodate the size of the desired Junos OS package.
A computer to download the software package from the download site and copy it to the USB flash drive.

1. USB flash formatted as FAT-32.
2. Download Junos. Example: junos-vmhost-install-usb-mx-x86-64-22.4R3.25.img 
3. Use Rufus/UltraISO burn the image to a USB flash drive.

4. Router has been powered off
5. Insert the USB flash drive into the USB port on the router
6. Power on the router. Powering on the router starts the loader script and checks for a Junos OS package on the USB flash drive.
7. When the install prompt appears, enter Yes
8. When the installation has completed, reboot the router:
```
**user@host> request system reboot**
```html
9. After the reboot has completed, log in and verify that the new version of the software has been properly installed.
```
**user@host> show version**
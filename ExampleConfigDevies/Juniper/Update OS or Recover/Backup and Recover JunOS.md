# JunOS Recover

## Backup 

1) Insert USB Flash in Juniper - "Donor".
"Donor" it must be turned on and is in a "sane" state.
2) Log in using any convenient method (SSH or COM-port).
3) Enter the command:
>request system snapshot media usb partition

the word "partition" means that all data on the flash drive will be deleted.
4) After that, we wait a few minutes for JunOS to format the flash drive and copy the entire contents of the system memory to it.

## Recover

1) Turning on "Patient" over COM-port.
2) Turning on "Patient" in power.
3) We wait for the kernel to load (!) and press the "space bar".
4) Enter:
>nextboot usb
5) After the "Setting next boot dev usb" is completed, enter:
>reboot
6) We are waiting for the "box" to reboot.

7) When the system is ready, we log in in any convenient way.
8) Enter the command:
>request system snapshot media internal partition

The system memory will be formatted, re-marked, and all the contents from the flash drive will be copied there.
9) At the end of the process, we remove the flash drive.
10) And reload the "box":
> request system reboot

## Optional

After the reboot, it is highly recommended to perform two additional operations:
1) system backup
is entered:
>request system snapshot slice alternate
2) creating rescue configuration:
> request system configuration rescue save


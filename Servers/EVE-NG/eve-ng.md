# EVE-NG:
```html
https://www.eve-ng.net/index.php/download/
```
## Juniper vMX:
```html
cd /opt
mkdir abc
cd abc
```
********* 
copy vmx-bundle-17.1R1.8.tgz to server
********* 
```html
tar xvf vmx-bundle-17.1R1.8.tgz
cd vmx-17.1R1.8/images/
ls
```
```html
example:
junos-vmx-x86-64-17.1R1.8.qcow2  metadata-usb-fpc1.img  metadata-usb-fpc6.img  metadata-usb-re1.img
junos-vmx-x86-64-17.1R1.8.tgz    metadata-usb-fpc2.img  metadata-usb-fpc7.img  metadata-usb-re.img
metadata-usb-fpc0.img            metadata-usb-fpc3.img  metadata-usb-fpc8.img  vFPC-20170216.img
metadata-usb-fpc10.img           metadata-usb-fpc4.img  metadata-usb-fpc9.img  vmxhdd.img
metadata-usb-fpc11.img           metadata-usb-fpc5.img  metadata-usb-re0.img
```
```html
mkdir /opt/unetlab/addons/qemu/vmxvcp-17.1R1.8-domestic-VCP
cp junos-vmx-x86-64-17.1R1.8.qcow2 /opt/unetlab/addons/qemu/vmxvcp-17.1R1.8-domestic-VCP/virtioa.qcow2
cp vmxhdd.img /opt/unetlab/addons/qemu/vmxvcp-17.1R1.8-domestic-VCP/virtiob.qcow2
cp metadata-usb-re.img /opt/unetlab/addons/qemu/vmxvcp-17.1R1.8-domestic-VCP/virtioc.qcow2
mkdir /opt/unetlab/addons/qemu/vmxvfp-17.1R1.8-domestic-VFP
cp vFPC-20170216.img /opt/unetlab/addons/qemu/vmxvfp-17.1R1.8-domestic-VFP/virtioa.qcow2
cd /opt
rm -rf /opt/abc
/opt/unetlab/wrappers/unl_wrapper -a fixpermissions
```
## Juniper vQFX:
```html
mkdir /opt/unetlab/addons/qemu/vqfxpfe-10K-F-17.4R1.16
mkdir /opt/unetlab/addons/qemu/vqfxre-10K-F-17.4R1.16
```
```html
cosim_20180212.qcow2 to  /opt/unetlab/addons/qemu/vqfxpfe-10K-F-17.4R1.16
jinstall-vqfx-10-f-17.4R1.16.img  /opt/unetlab/addons/qemu/vqfxre-10K-F-17.4R1.16
```
```html
mv /opt/unetlab/addons/qemu/vqfxpfe-10K-F-17.4R1.16/cosim_20180212.qcow2 /opt/unetlab/addons/qemu/vqfxpfe-10K-F-17.4R1.16/hda.qcow2
mv /opt/unetlab/addons/qemu/vqfxre-10K-F-17.4R1.16/jinstall-vqfx-10-f-17.4R1.16.img /opt/unetlab/addons/qemu/vqfxre-10K-F-17.4R1.16/hda.qcow2

/opt/unetlab/wrappers/unl_wrapper -a fixpermissions
```
## Extreme EXOS:
```html
https://github.com/extremenetworks/Virtual_EXOS
```
```html
mkdir /opt/unetlab/addons/qemu/extremexos-30.2.1.8
```
********* 
copy extremexos-30.2.1.8 to server
********* 
```html
cd /opt/unetlab/adons/qemu/extremexos-30.2.1.8/ 
mv EXOS-VM_v30.2.1.8.qcow2 hda.qcow2 

/opt/unetlab/wrappers/unl_wrapper -a fixpermissions
```

# Troubleshooting
```html
If error:
PHP Warning:  file_get_contents(/opt/unetlab/platform): Failed to open stream: No such file or directory in /opt/unetlab/html/includes/init.php on line 71

dmesg | grep -i cpu | grep -i -e intel -e amd

if Intel:
echo "intel" > /opt/unetlab/platform

or AMD:
echo "amd" > /opt/unetlab/platform

/opt/unetlab/wrappers/unl_wrapper -a fixpermissions
```
# Vagrant PXE test environment

A vagrant PXE client/server environment which supports:
- legacy and UEFI boot  
- pxelinux and ipxe  

It is designed to learn and test cloning solutions, nfsroot, syslinux, ipxe etc...

## Prepare

Install qemu, libvirt, OVMF, nfsd, vagrant-libvirt
```
# For archlinux
pacman -S vagrant libvirt qemu ovmf virt-manager nfs-utils
sudo gpasswd -a $USER libvirt
systemctl start libvirtd
vagrant plugin install vagrant-libvirt
# choose libvirt in menu
```

## Configure

Default pxe configuration loads ipxe in EFI mode.

## PXE server

- OS: debian 10  
- CPU: 1  
- RAM: 1024  
- eth0: Management network  
- eth1: Private network "pxe_network"  

## PXE client

- OS: debian 10  
- CPU: 1  
- RAM: 2048  
- eth0: Private network "pxe_network"  

### Libvirt provider

Run server with
```
$ vagrant up --provider libvirt
```

To run client, which as autostart of
```
$ vagrant up --provider libvirt --no-destroy-on-error client
```

Vagrant will hang on ``Waiting for domain to get an IP address...``.  
That's because box ask for network configuration on management network which do not exist here. Please ignore it.  

To restart boot procedure.
```
$ vagrant reload
```
It is working when you that VM is looping on
```
ipxe is working !
```

### Virtualbox provider

Run server with

```
$ vagrant up --provider virtualbox
```

A box needs [to be set](https://github.com/mitchellh/vagrant/issues/4487) for client with virtualbox provider.  
If changing, please choose one which supports virtualbox and libvirt providers.  
Requires [virtualbox extension pack](https://www.virtualbox.org/wiki/Downloads).

```
$ vagrant up --provider virtualbox --no-destroy-on-error client
```
Vagrant will hang on ``Warning: Connection refused. Retrying...`` error.
That's because we edited network configuration to enable pxeboot. Please ignore it.

Virtualbox gui will pop up, showing vm netboot.

It is working when you that VM is looping on
```
ipxe is working !
```

**Refs**

- http://www.syslinux.org/wiki/index.php?title=PXELINUX
- https://help.ubuntu.com/community/DisklessUbuntuHowto
- https://github.com/vagrant-libvirt/vagrant-libvirt#no-box-and-pxe-boot
- https://github.com/stephenrlouie/PXE-Boot-VM/  
- https://ipxe.org

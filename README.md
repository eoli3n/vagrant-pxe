# Vagrant PXE test environment

A vagrant PXE client/server environment which supports legacy and UEFI boot with iPXE.  
It is designed to learn and test cloning solutions, nfsroot, ipxe, auto install etc...  
Default pxe configuration loads ipxe in UEFI mode and start ubuntu installer over nfsroot.  

### Prepare

Install qemu, libvirt, OVMF, nfsd, vagrant-libvirt
```
# For archlinux
pacman -S vagrant libvirt qemu ovmf virt-manager
sudo gpasswd -a $USER libvirt
systemctl start libvirtd
vagrant plugin install vagrant-libvirt
# choose libvirt in menu
```

### Server

- OS: debian 10  
- CPU: 1  
- RAM: 1024  
- eth0: Management network  
- eth1: Private network "pxe_network"  

### Client

- OS: debian 10  
- CPU: 1  
- RAM: 2048  
- eth0: Private network "pxe_network"  

### Run

Run server with
```
$ vagrant up
```

To run client, which has ``autostart off``  
Note: If you want to test a legacy client boot, comment ``libvirt.firmware`` line in [Vagrantfile](Vagrantfile).
```
$ vagrant up client
```
Then open ``virt-manager`` to see your pxe client booting.

### Clean
```
vagrant destroy -f
```

**Refs**

- http://www.syslinux.org/wiki/index.php?title=PXELINUX
- https://help.ubuntu.com/community/DisklessUbuntuHowto
- https://github.com/vagrant-libvirt/vagrant-libvirt#no-box-and-pxe-boot
- https://github.com/stephenrlouie/PXE-Boot-VM/  
- https://ipxe.org

#!/bin/bash

### pxelinux configuration
cp -R /config/ressources/pxelinux.cfg /tftpboot
cp -R /config/ressources/syslinux /tftpboot
cp /config/ressources/pxelinux.0 /tftpboot

apt install -y pxe

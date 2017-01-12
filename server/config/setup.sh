#!/bin/bash

### DHCPD configuration
apt-get install -y isc-dhcp-server
cp /config/ressources/dhcpd.conf /etc/dhcp/dhcpd.conf
cp /config/ressources/isc-dhcp-server /etc/default/isc-dhcp-server
systemctl restart isc-dhcp-server

### TFTPD configuration
apt-get install -y tftpd-hpa
cp /config/ressources/tftpd-hpa /etc/default/tftpd-hpa
mkdir /tftpboot
cp -R /config/ressources/pxelinux.cfg /tftpboot
cp -R /config/ressources/syslinux /tftpboot
cp /config/ressources/pxelinux.0 /tftpboot
systemctl restart tftpd-hpa

### PXE configuration
apt-get install -y pxe

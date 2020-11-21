#!/bin/bash
mkdir /tftpboot/ipxe
wget http://boot.ipxe.org/ipxe.efi -O /tftpboot/ipxe/ipxe.efi
wget http://boot.ipxe.org/undionly.kpxe -o /tftpboot/ipxe/undionly.kpxe
cp /config/ressources/ipxe/init.ipxe /tftpboot/ipxe/init.ipxe

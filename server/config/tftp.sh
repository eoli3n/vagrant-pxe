#!/bin/bash

### TFTPD configuration
apt install tftpd-hpa -y
cp /config/ressources/tftp/tftpd-hpa /etc/default/tftpd-hpa
mkdir /tftpboot
systemctl restart tftpd-hpa

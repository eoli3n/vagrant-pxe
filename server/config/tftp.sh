#!/bin/bash

### TFTPD configuration
apt-get install -y tftpd-hpa
cp /config/ressources/tftp/tftpd-hpa /etc/default/tftpd-hpa
mkdir /tftpboot
systemctl restart tftpd-hpa

#!/bin/bash

### DHCPD configuration
apt-get install -y isc-dhcp-server
cp /config/ressources/dhcpd/dhcpd.conf /etc/dhcp/dhcpd.conf
cp /config/ressources/dhcpd/ipxe.conf /etc/dhcp/ipxe.conf
cp /config/ressources/dhcpd/isc-dhcp-server /etc/default/isc-dhcp-server
systemctl restart isc-dhcp-server

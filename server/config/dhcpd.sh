#!/bin/bash

### DHCPD configuration
ifup eth1
# Copy first to configure isc-dhcp-server on eth1
apt install isc-dhcp-server -y
cp /config/ressources/dhcpd/isc-dhcp-server /etc/default/isc-dhcp-server
cp /config/ressources/dhcpd/dhcpd.conf /etc/dhcp/dhcpd.conf
cp /config/ressources/dhcpd/ipxe.conf /etc/dhcp/ipxe.conf
systemctl restart isc-dhcp-server

#!/bin/bash

# Vars
tftpboot="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../tftpboot" >/dev/null 2>&1 && pwd )"
current="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
iso="ubuntu-20.04.1-live-server-amd64.iso"
isopath="$tftpboot/$iso"
extractpath="$tftpboot/installer"
kickstart="$current/kickstart.cfg"

# Download 20.04 LTS image
if [ ! -f "$isopath" ]
then
    wget "http://releases.ubuntu.com/focal/$iso" -O "$isopath"
fi
# Extract in /tftpboot/installer
if [ ! -d "$extractpath" ]
then
    7z x "$isopath" -o"$extractpath"
fi

# Create boot entry
cat << EOF > "$tftpboot/script.ipxe"
#!ipxe
kernel /installer/casper/vmlinuz
initrd /installer/casper/initrd
imgargs vmlinuz initrd=initrd boot=casper ip=dhcp
boot
EOF

# Copy kickstart file
# Not enabled in imgargs yet /!\
cp "$kickstart" "$tftpboot"

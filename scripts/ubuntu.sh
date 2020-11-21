#!/bin/bash

# Vars
dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../tftpboot" >/dev/null 2>&1 && pwd )"
iso="ubuntu-20.04.1-live-server-amd64.iso"
isopath="$dir/$iso"

# Download 20.04 LTS image
if [ ! -f "$isopath" ]
then
    wget "http://releases.ubuntu.com/focal/$iso" -O "$isopath"
fi
# Extract in /tftpboot/installer
7z x "$isopath" -o$dir/installer

# Create boot entry
cat << EOF > "$dir/script.ipxe"
#!ipxe
kernel installer/casper/vmlinuz
initrd installer/casper/initrd
imgargs vmlinuz initrd=initrd root=/dev/nfs boot=casper ip=dhcp --
boot
EOF

#!/bin/bash

# Vars
tftpboot="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../tftpboot" >/dev/null 2>&1 && pwd )"
www="$( cd "$( dirname "${BASH_SOURCE[0]}" )/../www" >/dev/null 2>&1 && pwd )"
current="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
iso="ubuntu-20.04.1-live-server-amd64.iso"
isopath="/tmp/$iso"
extractpath="$www/installer"
kickstart="$current/kickstart.cfg"

# If no yet extracted
if [ ! -d "$extractpath" ]
then
    # If not yet downloaded
    if [ ! -f "$isopath" ]
    then
        # Download 20.04 LTS image
        wget "http://releases.ubuntu.com/focal/$iso" -O "$isopath"
    fi
    # Extract in /tftpboot/installer
    7z x "$isopath" -o"$extractpath"
fi

# Create boot entry
cat << EOF > "$tftpboot/script.ipxe"
#!ipxe
kernel http://192.168.0.254/installer/casper/vmlinuz
initrd http://192.168.0.254/installer/casper/initrd
imgargs vmlinuz initrd=initrd ip=dhcp --
boot
EOF

# Copy kickstart file
# Not enabled in imgargs yet /!\
cp "$kickstart" "$www"

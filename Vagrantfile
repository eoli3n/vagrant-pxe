Vagrant.configure("2") do |config|
  
  config.vm.define :server do |server|

    # Use debian 10 for server
    server.vm.box = "generic/debian10"
    server.vm.hostname = "pxe-server"
    # Create a private network without vagrant DHCP
    server.vm.network "private_network",
      ip: "192.168.0.254",
      libvirt__network_name: "pxe",
      libvirt__dhcp_enabled: false

    # Configure VM
    server.vm.provider :libvirt do |libvirt|
      libvirt.cpu_mode = 'host-passthrough'
      libvirt.memory = '1024'
      libvirt.cpus = '1'
    end

    # Use ansible to install server
    server.vm.provision :ansible do |ansible|
      ansible.playbook = "playbook.yml"
    end
  end

  # Disable autostart of client when "vagrant up"
  config.vm.define :client, autostart: false do |client|
    client.vm.hostname = "pxe-client"
    # Connect to private server private network
    client.vm.network "private_network",
      libvirt__network_name: "pxe"

    # Configure VM
    client.vm.provider :libvirt do |libvirt|
      libvirt.cpu_mode = 'host-passthrough'
      libvirt.memory = '2048'
      libvirt.cpus = '1'
      # Create a disk
      libvirt.storage :file,
        size: '50G',
        type: 'qcow2',
        bus: 'sata',
        device: 'sda'
      # Set fr keyboard for vnc connection
      libvirt.keymap = 'fr'
      # Set pxe network NIC as default boot
      boot_network = {'network' => 'pxe'}
      libvirt.boot boot_network
      # Set UEFI boot, comment for legacy
      libvirt.loader = '/usr/share/qemu/OVMF.fd'
    end
  end
end

Vagrant.configure("2") do |config|
  
  config.vm.define :server do |server|

    server.vm.box = "generic/debian10"
    server.vm.hostname = "pxe-server"
    #server.ssh.username ='root'
    #server.ssh.insert_key = 'true'
    #server.ssh.forward_x11 = 'true'
    #using rsync to fix nfs issues
    server.vm.synced_folder "tftpboot", "/tftpboot", type: "rsync"
    server.vm.synced_folder "www", "/var/www", type: "rsync"
    server.vm.network "private_network", ip: "192.168.0.254", libvirt__network_name: "pxe_network", :libvirt__dhcp_enabled => false

    server.vm.provider :libvirt do |libvirt|
      libvirt.cpu_mode = 'host-passthrough'
      libvirt.memory = '1024'
      libvirt.cpus = '1'
    end

    server.vm.provision :ansible do |ansible|
      ansible.playbook = "ipxe.yml"
    end
  end

  config.vm.define :client, autostart: false do |client|

    client.vm.box = "generic/debian10"
    client.vm.hostname = "pxe-client"

    client.vm.provider :libvirt do |libvirt|
      libvirt.cpu_mode = 'host-passthrough'
      libvirt.memory = '2048'
      libvirt.cpus = '1'
      libvirt.storage :file, :size => '50G', :type => 'qcow2'
      libvirt.boot 'network'
      libvirt.mgmt_attach = 'false'
      libvirt.management_network_name = "pxe_network"
      libvirt.management_network_address = "192.168.0.0/24"
      libvirt.management_network_mode = "nat"
      # Set UEFI boot, comment for legacy
      libvirt.loader = '/usr/share/qemu/OVMF.fd'
    end
  end
end

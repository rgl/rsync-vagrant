Vagrant.configure(2) do |config|
  config.vm.box = "windows-2019-amd64" # see https://github.com/rgl/windows-vagrant
  config.vm.provider "libvirt" do |lv, config|
    lv.memory = 2*1024
    lv.cpu_mode = "host-passthrough"
    lv.keymap = "pt"
    config.vm.synced_folder ".", "/vagrant", type: "smb", smb_username: ENV["USER"], smb_password: ENV["VAGRANT_SMB_PASSWORD"]
  end
  config.vm.provider "virtualbox" do |vb, config|
    vb.linked_clone = true
    vb.memory = 2*1024
    vb.customize ["modifyvm", :id, "--vram", 64]
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    vb.customize ["modifyvm", :id, "--draganddrop", "bidirectional"]
  end
  config.vm.provision "shell", inline: "$env:chocolateyVersion='0.10.15'; iwr https://chocolatey.org/install.ps1 -UseBasicParsing | iex", name: "Install Chocolatey"
  config.vm.provision "shell", path: "Vagrantfile-locale.ps1"
  config.vm.provision "shell", path: "Vagrantfile-provision.ps1"
end
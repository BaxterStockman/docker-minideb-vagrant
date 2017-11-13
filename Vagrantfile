Vagrant.configure(2) do |config|
  config.vm.provider :docker do |d|
    d.image = 'baxterstockman/minideb-vagrant'
  end
  config.vm.provision :shell, inline: 'echo "Hello, world!"'
end

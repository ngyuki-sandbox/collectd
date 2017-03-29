Vagrant.configure(2) do |config|

  config.vm.box = "bento/centos-7.2"
  config.vm.hostname = "sv01"

  config.vm.network :forwarded_port, guest: 80, host: 9876
  config.vm.network :forwarded_port, guest: 9090, host: 9090
  config.vm.network :forwarded_port, guest: 9093, host: 9093

  config.vm.provider :virtualbox do |v|
    v.linked_clone = true
  end

  config.vm.provision "shell", inline: <<-SHELL
    set -eux

    # selinux
    setenforce 0 ||:
    sed -i "/^SELINUX=/c SELINUX=disabled" /etc/selinux/config

    # timezone for centos-7
    case "$(rpm -q centos-release --qf %{VERSION})" in
      7) timedatectl set-timezone Asia/Tokyo ;;
    esac

    # package
    yum -y --noplugins install \
      nc vim-enhanced bash-completion lsof rsync tcpdump epel-release
    yum -y --noplugins install colordiff

    echo ok
  SHELL

end

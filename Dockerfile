FROM bitnami/minideb

LABEL maintainer schreibah@gmail.com

ADD https://raw.githubusercontent.com/mitchellh/vagrant/master/keys/vagrant.pub /tmp/vagrant.pub

RUN     install_packages openssh-server sudo \
    &&  useradd -U -m -s /bin/bash vagrant \
    &&  { echo vagrant:vagrant | chpasswd ; } \
    &&  install -Dm 0600 -o vagrant -g vagrant /tmp/vagrant.pub ~vagrant/.ssh/authorized_keys \
    &&  rm /tmp/vagrant.pub \
    &&  mkdir -p /var/run/sshd \
    &&  printf > /tmp/vagrant.sudoers 'Defaults:vagrant !requiretty\nDefaults:vagrant env_keep += "SSH_AUTH_SOCK"\nvagrant ALL=(ALL:ALL) NOPASSWD: ALL ' \
    && visudo -cf /tmp/vagrant.sudoers \
    && install -Dm 0600 /tmp/vagrant.sudoers /etc/sudoers.d/vagrant  \
    && rm /tmp/vagrant.sudoers

CMD ["/usr/sbin/sshd", "-D"]

#!/bin/sh

if [[ ! -d /hostssh ]]; then
    echo "Must mount the host SSH directory at /hostssh, e.g. 'docker run --net host -v $HOME/.ssh:/hostssh vigasin/provision"
    exit 1
fi

[ -z "$PROVISION_USER" ] && PROVISION_USER=root

# Generate temporary SSH key to allow access to the host machine.
mkdir -p /root/.ssh
ssh-keygen -f /root/.ssh/id_rsa -P ""

cp /hostssh/authorized_keys /hostssh/authorized_keys.bak
cat /root/.ssh/id_rsa.pub >>/hostssh/authorized_keys

ansible all --user $PROVISION_USER -i "localhost," -m raw -a "apt-get install -y python-minimal"
ansible-playbook --user $PROVISION_USER -i "localhost," "$@"

mv /hostssh/authorized_keys.bak /hostssh/authorized_keys

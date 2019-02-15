#!/usr/bin/env bash

# Update OS
yum -y update

# Create Ansible service user
useradd ansible

# Create .ssh directory
mkdir /home/ansible/.ssh/

# Retrieve latest SSH keys from Github
SSH_KEY="$(curl https://github.com/jhughes01.keys)"

# Add my SSH key as an authorised key for Ansible user
cat <<EOF > /home/ansible/.ssh/authorized_keys
$SSH_KEY
EOF

# Correct file ownership and permissions
chown -R ansible: /home/ansible/.ssh && chmod 600 /home/ansible/.ssh/authorized_keys

# Allow Ansible to execute passwordless sudo
echo -e "ansible\tALL=(ALL) NOPASSWD: ALL\nDefaults:ansible\t!requiretty" > /etc/sudoers.d/ansible_all

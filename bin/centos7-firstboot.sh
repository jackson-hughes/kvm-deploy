#!/usr/bin/env bash

# Update OS
yum -y update

# Create Ansible service user
useradd ansible

# Create .ssh directory
mkdir /home/ansible/.ssh/

# Add my SSH key as an authorised key for Ansible user
cat <<EOF > /home/ansible/.ssh/authorized_keys
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDW5mCXmQhXNc5ZO573jWulL3e2Dfz5QnOoYVKT3UJlzXPWf/iuXehkhBLrybxQuCSUgj7q9G3xV534hvG59XdokjBmggBPZ/qyKnpLsjOZhJQBabmFfl2VwyM9H2W8rwRiajjCkGcPOVUx7+Tk/SLnRDPhYTc2JfOWd6hWvC6Zq9sFiU8ilACCu1Hmut8I/o+5z0k8701ZawtZ+vMvLLn/ZqwMC0jzkTP1mN2U6PFKHa8BDCDkSl5H/rKX5dgyrTvgbxe29iXi2Yl5OP174yl3ZmnCyCoLzNhgtidIcTWi7X0DgEQfxRhNc+J6s53CQz39mtgto6SzBJI/LxhS6ELB
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCy5143OIiCHNwgCP+6C81fZBxtX6q1wL/nDbj6+KwBgdWrXBkP3x81OxkWvE40LLJz1WCL5XN517rJm0NyNXcHRV4+lwi/lFBwN/PMR8FnbFTgexqTuo6eNx2iDZFb2MykKuBzz5gaXOfzNQQBvFCsKnfdmQvJcpMOuLSX3bKRlq7m1jQsQ7n7Yqwl3aN9AleZVmXOwkskB7LpWkGAL52KultrIzci9K8XB6pW5ZlttUb03doI4/8g753oCmbArvqjqi6WMv8zRBkqZZX2v82RjYoYTsm7Q/Xk2cnNn4JuEuwfGPR0Yk/zbbLuv9LuITBsNb+kP2vo1ntlQStq7bz/belrltIwuk2rOR/1BQDYQDQ+LX6SC/4zfci6IBaHfKkKHaXnczSiCWiW50AakHdKooYPLuxdpiE1BYshwv00x7A45yUnjqtTPtybAdUTzmNNvLjzpNjCgOzctSam5plluB4YbF188VuwGk1dGXjXvPEkZoBggNhpvpauV3KSgiBLfDne5iEED/PLZT+po6yJTIGF3hFvj/gMUHIirWh/CaBgjNkDRpE2g6Nz++5zXCoN3RpsT38nmO8xjrVig+B4PeRkXkgi+s9odoa9CtRXXh+GmuW8jIiQDMhkXHmjSCWMAZxFS66PasItwpyEsmkRGa8+1TZ/UxvM9Lh/E9mdSw==
EOF

# Correct file ownership and permissions
chown -R ansible: /home/ansible/.ssh && chmod 600 /home/ansible/.ssh/authorized_keys

# Allow Ansible to execute passwordless sudo
echo -e "ansible\tALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible_all
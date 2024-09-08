#!/bin/bash
set -e
echo "Provisioning Master Node..."

# Install required dependencies
sudo apt-get update
sudo apt-get install -y python3 python3-pip git curl
# Install Ansible
sudo pip3 install ansible
# Install other necessary dependencies for KubeSpray
sudo apt-get install -y sshpass

echo "Master Node provisioned."

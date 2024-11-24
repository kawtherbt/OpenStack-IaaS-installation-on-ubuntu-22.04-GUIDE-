## INSTALLING OPENSTACK ON UBUNTU 22.04
# For more detailed insight check out the README file in the same repo
 

# Step 1: Update and Upgrade the System
apt update -y && apt upgrade -y

# Reboot the system
sudo reboot

# Step 2: Create Stack user and assign sudo privileges
sudo adduser -s /bin/bash -d /opt/stack -m stack
sudo chmod +x /opt/stack

# Assign sudo privileges to the user
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack

# Step 3: Install git and download DevStack
su - stack
sudo apt install git -y

# Clone devstack’s git repository
git clone https://git.openstack.org/openstack-dev/devstack

# Step 4: Create devstack configuration file
cd devstack

# Create a local.conf configuration file
vim local.conf

# Paste the content into the file

# Step 5: Install OpenStack with Devstack
./stack.sh

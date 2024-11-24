<div align="center">
  
  <h1 align="center">Install OpenStack on Ubuntu 22.04 with DevStack</h1>

</div>

## Contact
If you have any questions or need further assistance, feel free to reach out:

- **Name**: Kawther Benticha  
- **LinkedIn**: [linkedin.com/in/kawther-benticha](https://www.linkedin.com/in/kawther-benticha/)  
- **GitHub**: [github.com/kawtherbt](https://github.com/kawtherbt)

## What is OpenStack?
OpenStack is a free, open standard cloud computing platform. It is mostly deployed as infrastructure-as-a-service in public and private clouds where virtual servers and other resources are available to users.

## Whats is DevStack?
Devstack is a series of scripts used to quickly bring up a complete OpenStack environment.

---

## OpenStack Components
OpenStack consists of several components, each providing a specific functionality for managing a cloud environment.

- **Horizon**: The web-based dashboard for managing and accessing OpenStack resources.
- **Nova**: The compute service that manages virtual machines.
- **Neutron**: The networking service that handles virtual networks and IP addresses.
- **Cinder**: The block storage service that provides persistent storage for virtual machines.
- **Swift**: The object storage service for storing and retrieving large amounts of data.
- **Keystone**: The identity service for authentication and authorization across OpenStack components.
- **Glance**: The image service that provides discovery, registration, and delivery services for VM images.
- **Heat**: The orchestration service that manages infrastructure as code.
- **Ceilometer**: The telemetry service for monitoring and metering usage statistics.


---

## Installation Steps

### Step 1: Update and Upgrade the System
To start off, log into your Ubuntu 22.04 system using SSH protocol and update & upgrade system repositories: 

```bash
apt update -y && apt upgrade -y
```
Next, you should reboot your system:
```bash
sudo reboot
```
### Step 2: Create Stack user and assign sudo priviledge
Best practice demands that devstack should be run as a regular user with sudo privileges.So, to create a stack user: 
```bash
sudo adduser -s /bin/bash -d /opt/stack -m stack
sudo chmod +x /opt/stack
```

Assign sudo privileges to the user
```bash
echo "stack ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/stack
```
### Step 3: Install git and download DevStack
```bash
su - stack
sudo apt install git -y

```
Clone devstack’s git repository
```bash
git clone https://git.openstack.org/openstack-dev/devstack
```
### Step 4: Create devstack configuration file
Navigate to the devstack directory:
```bash
cd devstack

```
Then create a local.conf configuration file:
```bash
vim local.conf
```
Paste the following content:
```bash
[[local|localrc]]
# Password for KeyStone, Database, RabbitMQ and Service
ADMIN_PASSWORD=StrongAdminSecret
DATABASE_PASSWORD=$ADMIN_PASSWORD
RABBIT_PASSWORD=$ADMIN_PASSWORD
SERVICE_PASSWORD=$ADMIN_PASSWORD
# Host IP - get your Server/VM IP address from ip addr command
HOST_IP=10.208.0.10
```
Save and Exit.
## Note:
- **ADMIN_PASSWORD**: used to login to Openstack login page. Default username is __admin__
- **HOST_IP**: system’s IP address that is obtained by running __ifconfig__ or __ip addr__ commands

### Step 5: Install OpenStack with Devstack
run the script below contained in devstack directory:
```bash
./stack.sh
```
The deployment takes about 10 to 15 minutes depending on the speed of your system and internet connection.

### Step 6: Accessing OpenStack on a web browser
To access OpenStack via a web browser browse your Ubuntu’s IP address as shown. https://server-ip/dashboard This directs you to a login page 

---
<div align="center">
  
  <h2 align="center">Verify the Installation and Access Sunstone UI
</h2>

</div>

 <div align="center">
   <img src="https://miro.medium.com/v2/resize:fit:640/format:webp/0*ACjue7WCslkHjP4C.png" alt="Logo" width="100%" height="100%">
   <p align="center">Login Page</p>

   <img src="https://miro.medium.com/v2/resize:fit:720/format:webp/0*dya1n9DWtYUeCF4E.png" alt="Logo" width="100%" height="100%">
   <p align="center">Dashboard Page</p>
</div>
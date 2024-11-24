<div align="center">
  
  <h1 align="center">Install OpenNebula on Ubuntu</h1>

</div>

## Contact
If you have any questions or need further assistance, feel free to reach out:

- **Name**: Kawther Benticha  
- **LinkedIn**: [linkedin.com/in/kawther-benticha](https://www.linkedin.com/in/kawther-benticha/)  
- **GitHub**: [github.com/kawtherbt](https://github.com/kawtherbt)

## Why OpenNebula?
OpenNebula combines existing virtualization technologies like KVM and VMware with advanced features for multi-tenancy, automatic provisioning, and elasticity. Its aim is to make cloud management simple. It can be compared with other cloud management platforms like OpenStack and CloudStack.

---

## OpenNebula Components
OpenNebula has two main components:
- **OpenNebula Front-end**: The management engine that executes the OpenNebula services.
- **OpenNebula Hypervisor Nodes**: Hypervisors providing the resources needed by the VMs.

### Minimum Recommended Specs for Front-end
| Resource       | Minimum Recommended Configuration |
|----------------|------------------------------------|
| Memory         | 2 GB                              |
| CPU            | 1 CPU (2 cores)                   |
| Disk Size      | 100 GB                            |
| Network        | 2 NICs                            |

The OpenNebula Front-end machine needs network connectivity to all hosts and possibly access to the storage Datastores. The base installation takes less than 150 MB.

---

## Installation Steps

### Step 1: Add OpenNebula and Debian Repositories
Import the repository key and add the OpenNebula repository:

```bash
wget -q -O- https://downloads.opennebula.org/repo/repo.key | sudo apt-key add -
echo "deb https://downloads.opennebula.org/repo/6.1/Ubuntu/20.04 stable opennebula" | sudo tee /etc/apt/sources.list.d/opennebula.list
```
### Step 2: Install and Configure MySQL Database
Update the package list and install MariaDB:

```bash
sudo apt update
sudo apt -y install mariadb-server
sudo mysql_secure_installation
```

Create a database and user for OpenNebula:
```bash
sudo mysql -u root -p
CREATE DATABASE opennebula;
GRANT ALL PRIVILEGES ON opennebula.* TO 'oneadmin' IDENTIFIED BY 'StrongPassword';
FLUSH PRIVILEGES;
EXIT;

```
### Step 3: Install OpenNebula Front-end Packages
Install the required OpenNebula packages:

```bash
sudo apt update
sudo apt install opennebula opennebula-sunstone opennebula-gate opennebula-flow

```
### Step 4: Install Ruby Runtime
Run the following command to install Ruby dependencies:

```bash
sudo /usr/share/one/install_gems

```
### Step 5: Configure OpenNebula DB
Edit the database configuration in the oned.conf file:
```bash
sudo vim /etc/one/oned.conf

```
Uncomment the SQLite configuration:
```bash
#DB = [ BACKEND = "sqlite" ]

```
Replace it with the MySQL configuration:
```bash
DB = [ backend = "mysql",       server = "localhost",       port = 0,       user = "oneadmin",       passwd = "StrongPassword",       db_name = "opennebula" ]

```

### Step 6: Configure Firewall
Allow the required ports for OpenNebula's Sunstone interface:
```bash
sudo ufw allow proto tcp from any to any port 9869
```

### Step 7: Start OpenNebula Services
```bash
sudo systemctl start opennebula opennebula-sunstone
sudo systemctl enable opennebula opennebula-sunstone
```
---
<div align="center">
  
  <h2 align="center">Verify the Installation and Access Sunstone UI
</h2>

</div>

To verify the installation, run the following command as oneadmin:
```bash
sudo su - oneadmin -c "oneuser show"
```
To access the Sunstone UI, open your browser and navigate to:
```bash
http://<your-server-ip>:9869
```
- **Username:**  oneadmin
- **Password:** Found in /var/lib/one/.one/one_auth
 
 <div align="center">
   <img src="https://miro.medium.com/v2/resize:fit:720/format:webp/0*eDlMik3QnrclLbu4.png" alt="Logo" width="100%" height="100%">
   <p align="center">Login Page</p>

   <img src="https://miro.medium.com/v2/resize:fit:720/format:webp/0*mwFGkvJB3YvuUAfZ.jpg" alt="Logo" width="100%" height="100%">
   <p align="center">Dashboard Page</p>
</div>
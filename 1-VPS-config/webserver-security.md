# Initial VPS Setup and Security Hardening

## First Steps

### Basic Commands
#### Connect to Your VPS
```sh
ssh <user>@<ip_address>
```

#### Enable Automatic Updates
```sh
sudo apt install unattended-upgrades
sudo dpkg-reconfigure --priority=low unattended-upgrades
```

## Firewall Setup
#### Install and Configure UFW
```sh
sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow <new_ssh_port>/tcp
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
```

#### Enable the Firewall
```sh
sudo ufw enable
```

#### Check Firewall Rules
```sh
sudo ufw status verbose
```

## Secure SSH

### Change SSH Port
```sh
sudo nano /etc/ssh/sshd_config
```
Find the `Port` line and change it:
```sh
Port <port_number>  # Choose a port between 1024-49151
```
Restart the SSH service:
```sh
sudo systemctl restart sshd
sudo systemctl restart ssh
```
Test the new port:
```sh
ssh -p <port_number> <user>@<ip_address>
```
Remove the default SSH rule:
```sh
sudo ufw delete allow ssh
sudo ufw enable
sudo ufw status verbose
```

### Create a New User
```sh
adduser <new_user_name>
```
Grant sudo privileges:
```sh
usermod -aG sudo <new_user_name>
```
Reconnect with the new user:
```sh
ssh -p <port_number> <new_user_name>@<ip_address>
```

### Remove the Old User Account
Once the new user is properly set up and working, you can remove the old user account:
```sh
sudo deluser --remove-home <old_user_name>
```

### Enable SSH Key Authentication
#### On Your Local Machine
Generate a new SSH key:
```sh
ssh-keygen -t rsa -b 4096
```
Copy the key to the server:
```sh
ssh-copy-id -p <port_number> <user>@<ip_address>
```

#### Disable Password Authentication
```sh
sudo nano /etc/ssh/sshd_config
```
Ensure the following lines are set:
```sh
PasswordAuthentication no
PubkeyAuthentication yes
```
Restart SSH:
```sh
sudo systemctl restart sshd
sudo systemctl restart ssh
```

### Disable Root Login
```sh
sudo nano /etc/ssh/sshd_config
```
Set:
```sh
PermitRootLogin no
```
Restart SSH:
```sh
sudo systemctl restart sshd
sudo systemctl restart ssh
```

## Install and Configure Fail2Ban
#### Install Fail2Ban
```sh
sudo apt install fail2ban
```

#### Configure Fail2Ban
Copy the default configuration file:
```sh
sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
sudo nano /etc/fail2ban/jail.local
```

Modify the settings:
```ini
[DEFAULT]
bantime = 1h
findtime = 10m
maxretry = 5

[sshd]
enabled = true
port = <port_number>
maxretry = 5
backend = systemd

[nginx-http-auth]
enabled = true
port = http,https
logpath = /var/log/nginx/*.log
filter = nginx-http-auth
maxretry = 15

[nginx-limit-req]
enabled = true
port = http,https
logpath = /var/log/nginx/*.log
filter = nginx-limit-req
maxretry = 10

[nginx-botsearch]
enabled = true
port = http,https
logpath = /var/log/nginx/*.log
filter = nginx-botsearch
maxretry = 10

[nginx-bad-request]
enabled = true
port = http,https
logpath = /var/log/nginx/*error*.log
filter = nginx-bad-request
maxretry = 10
```

Restart and check Fail2Ban status:
```sh
sudo systemctl restart fail2ban
sudo systemctl status fail2ban
```
Check Fail2Ban status:
```sh
sudo fail2ban-client status
sudo fail2ban-client status nginx-http-auth
```

## Install System Monitoring Tools
### Install htop
```sh
sudo apt install htop
htop
```

## Enable AppArmor
Check if AppArmor is enabled:
```sh
sudo aa-status
```
If not enabled, run:
```sh
sudo systemctl enable apparmor
sudo systemctl start apparmor
```

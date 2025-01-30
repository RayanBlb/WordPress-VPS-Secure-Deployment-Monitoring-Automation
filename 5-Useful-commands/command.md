# Useful Commands for VPS Configuration

## UFW Management
```sh
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw delete allow 80/tcp
sudo ufw delete allow 443/tcp
sudo ufw enable
sudo ufw status verbose
```

## SSH Configuration
```sh
sudo nano /etc/ssh/sshd_config
sudo systemctl restart ssh
sudo systemctl restart sshd
```

## Nginx Management
```sh
cd /etc/nginx/sites-available/
cd /etc/nginx/sites-enabled/
sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx
```

## Docker Management
```sh
sudo docker-compose up -d
sudo docker stop $(docker ps -aq)
sudo docker rm $(docker ps -aq)
sudo docker system prune --all --volumes

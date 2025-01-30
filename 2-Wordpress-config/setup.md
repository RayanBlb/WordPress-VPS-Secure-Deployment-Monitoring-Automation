# Install Website

## Install Docker
```sh
sudo apt install -y docker.io
sudo usermod -aG docker $USER
sudo apt install -y docker-compose
docker --version
docker-compose --version
```

## Workspace Setup
```sh
mkdir Workspace && cd Workspace
mkdir Wordpress && cd Wordpress
nano .env
sudo chmod 600 .env
nano docker-compose.yml
sudo docker-compose up -d
```

## Nginx Configuration
```sh
sudo apt install nginx
sudo nano /etc/nginx/sites-available/wordpress
sudo ln -s /etc/nginx/sites-available/wordpress /etc/nginx/sites-enabled/

sudo nginx -t
sudo systemctl restart nginx
```

## Basic Authentication Configuration
```sh
sudo apt install apache2-utils -y
sudo htpasswd -c /etc/nginx/.htpasswd <user>
```

## certbot Configuration
```sh
sudo apt install certbot python3-certbot-nginx -y
sudo certbot --nginx -d <your_wordpress_domain> -d www.<your_wordpress_domain> # Replace <your_wordpress_domain> with the domain where wordpress will be accessible
```

## Automate Certificate Renewal
```sh
sudo crontab -e
0 3 * * * certbot renew --quiet && systemctl reload nginx
```

## Install and Configure WordPress

### Suggested Plugins
```sh
WPS Hide Login
WP Activity Log
```

## Best Practices for WordPress Security & Maintenance

### Initial Setup Checklist
1. Check for updates
2. Set a display name for the admin profile
3. Remove default posts, pages, comments, and unused plugins
4. Clean the dashboard (keep only site health)
5. Set site title and tagline under `Settings`
6. Change permalinks to `Post Name`

### Theme Installation
- Install `Astra` theme and remove other themes
- Install `Starter Templates - Elementor, WordPress & Beaver Builder Templates`
- Follow the setup guide and select `Elementor`
- Choose a template and customize it

### Enable Automatic Updates
- Navigate to `Plugins > Installed Plugins`
- Enable `Automatic Updates` for each plugin
- Go to `Appearance > Themes`
- Enable `Automatic Updates` for active themes

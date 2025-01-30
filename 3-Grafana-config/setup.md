# Install Logs and Monitoring

## Create Workspace Directory
```sh
sudo mkdir -p /opt/monitoring/grafana
cd /opt/monitoring/grafana
```

## Docker Setup and Secret
```sh
sudo nano .env
sudo chmod 600 .env
sudo nano docker-compose.yml
```

## Configure Loki
```sh
sudo nano loki-config.yaml
```

## Configure Promtail
```sh
sudo nano promtail-config.yaml
```

## Configure Prometheus
```sh
sudo nano prometheus-config.yml
```

## Configure Journalctl
```sh
sudo mkdir -p /var/log/journal
sudo systemd-tmpfiles --create --prefix /var/log/journal
sudo systemctl restart systemd-journald
```
(Note: Log size may grow significantly)

## Start Docker
```sh
sudo docker-compose up -d
docker ps -a
```

## Configure Basic Authentication, Nginx and Certbot
```sh
sudo apt install nginx #If you have already installed Nginx, this command is not necessary.
sudo nano /etc/nginx/sites-available/grafana
sudo ln -s /etc/nginx/sites-available/grafana /etc/nginx/sites-enabled/

sudo nginx -t
sudo systemctl restart nginx

sudo apt install apache2-utils -y #If you have already installed apache2-utils, this command is not necessary.
sudo htpasswd -c /etc/nginx/.htpasswd <user> #If you have already configured htpasswd, this command is not necessary.

sudo apt install certbot python3-certbot-nginx -y #If you have already installed certbot python3-certbot-nginx, this command is not necessary.
sudo certbot --nginx -d <your_grafana_domain>  # Replace <your_grafana_domain> with the domain where Grafana will be accessible
```

## Setup Grafana
1. Log into Grafana
2. Navigate to `Configuration -> Data Sources`
3. Add a new data source:
   - Type: Loki
   - URL: `http://loki:3100`
4. Click `Save & Test`

## Configure Prometheus in Grafana
1. Go to `Configuration -> Data Sources`
2. Add a new data source:
   - Type: Prometheus
   - URL: `http://prometheus:9090`
3. Click `Save & Test`

## Import a Grafana Dashboard
1. Go to `Create -> Import`
2. Enter a dashboard ID from Grafana.com (e.g., `1860` for Node Exporter Full)
3. Configure the Prometheus data source
4. Click `Import`

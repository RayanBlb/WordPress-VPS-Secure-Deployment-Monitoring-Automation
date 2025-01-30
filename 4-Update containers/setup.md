# Update Containers Automatically

## Create the Update Directory
```sh
cd ~/Workspace
mkdir Update-containers
cd Update-containers
```

## Create and Set Up the Update Script
```sh
nano update_containers.sh
sudo chmod +x ./update_containers.sh
```

## Schedule the Script Execution with Cron
```sh
sudo crontab -e
```
Add the following line to schedule the script execution daily at 20:00:
```sh
0 20 * * * ~/Workspace/Update-containers/update_containers.sh
```

## Verify Cron Job and Service Status
```sh
sudo crontab -l
sudo systemctl status cron
```

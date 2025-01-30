#!/bin/bash

LOG_FILE="/var/log/docker_update.log"

COMPOSE_DIRS=(
    "/home/<user>/Workspace/Wordpress"
    "/opt/monitoring/grafana"
)

echo "=== Starting container updates - $(date '+%Y-%m-%d %H:%M:%S') ===" >> $LOG_FILE

for COMPOSE_DIR in "${COMPOSE_DIRS[@]}"; do
    echo "Processing directory: $COMPOSE_DIR" >> $LOG_FILE
    
    if [ ! -d "$COMPOSE_DIR" ]; then
        echo "Directory not found: $COMPOSE_DIR" >> $LOG_FILE
        continue
    fi

    cd "$COMPOSE_DIR" || { echo "Cannot access directory $COMPOSE_DIR" >> $LOG_FILE; continue; }

    if [ ! -f "docker-compose.yml" ]; then
        echo "docker-compose.yml not found in $COMPOSE_DIR" >> $LOG_FILE
        continue
    fi

    echo "=== Updating containers in $COMPOSE_DIR - $(date '+%Y-%m-%d %H:%M:%S') ===" >> $LOG_FILE

    docker-compose pull >> $LOG_FILE 2>&1

    docker-compose up -d --remove-orphans >> $LOG_FILE 2>&1

    docker image prune -f >> $LOG_FILE 2>&1

    echo "=== Update completed in $COMPOSE_DIR - $(date '+%Y-%m-%d %H:%M:%S') ===" >> $LOG_FILE
done

echo "=== All updates completed - $(date '+%Y-%m-%d %H:%M:%S') ===" >> $LOG_FILE

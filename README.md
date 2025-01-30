# Project Overview

This project provides a structured and secure setup for deploying a WordPress website on a VPS while ensuring monitoring, security, and automation. The setup is divided into multiple phases, each addressing a crucial aspect of the deployment and maintenance process.

## Prerequisites
Before starting this project, ensure you have the following:
- A VPS server with a supported Linux distribution
- A domain name with two DNS records:
  - An A record pointing to the VPS IP address for wordpress
  - A CNAME or additional A record for subdomains for grafana

## Project Phases

### 1. **VPS Configuration and Security**
The first phase focuses on the initial setup of the VPS, ensuring it is secure. This includes:
- Enabling automatic updates
- Configuring a firewall (UFW)
- Securing SSH access
- Installing Fail2Ban for brute force protection
- Implementing AppArmor for process security

### 2. **WordPress Installation and Required Tools**
This phase sets up WordPress within a Docker environment along with necessary dependencies. Key steps include:
- Installing Docker and Docker Compose
- Setting up an Nginx reverse proxy
- Securing the website with SSL using Certbot
- Installing and configuring WordPress
- Applying best practices for WordPress security and maintenance

### 3. **Grafana Setup and Monitoring Tools**
To ensure continuous monitoring of the VPS and WordPress application, this phase integrates monitoring tools such as:
- Installing Loki, Promtail, and Prometheus
- Setting up Nginx and Certbot for secured access
- Configuring Grafana dashboards for log visualization
- Enabling real-time metrics collection

### 4. **Automated Container Updates**
To maintain up-to-date services, this phase implements an automated update mechanism for Docker containers. It includes:
- A script that updates Docker containers
- Automatic execution of the update script using Cron
- Logging of update operations
- Cleaning up unused Docker images to optimize storage

## Additional Tools
Throughout the setup, various useful commands are provided to facilitate administration and maintenance of the VPS.

This project ensures a reliable, secure, and automated deployment of a WordPress-based website while incorporating essential monitoring and security practices.

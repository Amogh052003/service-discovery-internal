#!/bin/bash

# Log everything
exec > /var/log/user-data.log 2>&1

echo "===== STARTING SETUP ====="

# Update system
apt update -y

# Install Docker
apt install -y docker.io

# Start Docker
systemctl start docker
systemctl enable docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Install Docker Compose
curl -L "https://github.com/docker/compose/releases/download/v2.20.2/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# Verify installations
docker --version
docker-compose --version

echo "===== DOCKER INSTALLED ====="

# Install git
apt install -y git

# Move to home
cd /home/ubuntu

# Clone your repo (IMPORTANT: replace with your repo)
git clone https://github.com/YOUR_USERNAME/aws-service-discovery.git

cd aws-service-discovery

# Run containers
docker-compose up -d

echo "===== APPLICATION STARTED ====="
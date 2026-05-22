#!/bin/bash

# Filename: install_searxng.sh
# Description: This script automates the installation and setup of SearXNG using Podman on AlmaLinux.
# It includes steps to update the system, install Podman, pull the SearXNG Docker image, create necessary
# configuration files, run the SearXNG container with the correct port mapping, and set up a systemd service
# to ensure the container starts automatically on system boot.

# Update system
sudo dnf update -y

# Install Podman
sudo dnf install -y podman

# Verify Podman installation
podman --version

# Pull the SearXNG Docker image
podman pull docker.io/searxng/searxng:latest

# Create a directory for SearXNG configuration
mkdir -p ~/searxng/settings

# Create a configuration file with default settings
curl -o ~/searxng/settings/settings.yml https://raw.githubusercontent.com/searxng/searxng/master/searx/settings.yml.example

# Run the SearXNG container with correct port mapping
podman run -d --name searxng -p 8888:8080 -v ~/searxng/settings:/etc/searxng/settings:Z docker.io/searxng/searxng:latest

# Verify the container is running
podman ps

# Create a systemd service file for the SearXNG container
sudo tee /etc/systemd/system/searxng.service > /dev/null <<EOF
[Unit]
Description=SearXNG container
After=network.target

[Service]
Restart=always
ExecStart=/usr/bin/podman start -a searxng
ExecStop=/usr/bin/podman stop -t 2 searxng

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd to recognize the new service
sudo systemctl daemon-reload

# Enable the SearXNG service to start on boot
sudo systemctl enable searxng

# Start the SearXNG service
sudo systemctl start searxng

# Fetch the server's hostname
hostname=$(hostname)

# Output the URL to access SearXNG
echo "SearXNG is running. Access it at http://$hostname:8888/"

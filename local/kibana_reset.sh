#!/bin/bash
###############################################################
# Software: IBM Watsonx Kibana Installation Tool
# Use: For Development of Watsonx Applications
# Audience: General Use
# Author: Dr. Jeffrey Chijioke-Uche, Ph.D
# Company: IBM Corporation
# Version 1.0
# License ID: 3.0 (the "License")
# Engine: Stopper
##############################################################

# Check if kibana.yml exists
if [ -f "kibana.yml" ]; then
  rm kibana.yml
  echo "old kibana.yml removed"
else
  echo "continue..."
fi

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to stop, remove and prune Docker, Podman, or Buildah images
image_uninstaller() {
  # Check if Podman is installed and has images
  if command_exists podman; then
    if podman images -q | grep -q .; then
      echo "Stopping Kibana and removing Kibana Podman container..."
      podman stop ibm-watsonx-discovery-kibana && echo -e "stopping done!" 
      podman rm ibm-watsonx-discovery-kibana && echo -e "removal done!"
      podman system prune -a -f
    fi
  fi

  # Check if Docker is installed and has images
  if command_exists docker; then
    if docker images -q | grep -q .; then
      echo "Stopping Kibana and removing Kibana Docker container..."
      docker stop ibm-watsonx-discovery-kibana && echo -e "stopping done!" 
      docker rm ibm-watsonx-discovery-kibana && echo -e "removal done!"
      docker system prune -a -f
    fi
  fi

  # Check if Buildah is installed and has images
  if command_exists buildah; then
    if buildah images -q | grep -q .; then
      echo "Stopping Kibana and removing Kibana Buildah container..."
      buildah rm ibm-watsonx-discovery-kibana && echo -e "stopping done!" 
      buildah rmi -a -f && echo -e "removal done!"
      buildah system prune -a -f
    fi
  fi
}

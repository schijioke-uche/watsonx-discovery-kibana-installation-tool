#!/bin/bash
###############################################################
# Software: IBM Watsonx Kibana Installation Tool
# Use: For Development of Watsonx Applications
# Audience: General Use
# Author: Dr. Jeffrey Chijioke-Uche, Ph.D
# Company: IBM Corporation
# Version 1.0
# License ID: 3.0 (the "License")
# Engine: Stop Engine
##############################################################

# Check if kibana.yml exists
if [ -f "kibana.yml" ]; then
  rm kibana.yml
  echo "old kibana.yml removed...."
else
  echo "continue..."
fi

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Function to stop, remove and prune Docker, Podman or Buildah images
image_uninstaller() {
  # Check if Podman is installed and has images
  if command_exists podman; then
    if podman images -q; then
      echo "Stopping and removing Podman container..."
      podman stop ibm-watsonx-discovery-kibana
      podman rm ibm-watsonx-discovery-kibana
      podman system prune -a -f
    fi

  # Check if Docker is installed and has images
  elif command_exists docker; then
    if docker images -q; then
      echo "Stopping and removing Docker container..."
      docker stop ibm-watsonx-discovery-kibana
      docker rm ibm-watsonx-discovery-kibana
      docker system prune -a -f
    fi

  # Check if Buildah is installed and has images
  elif command_exists buildah; then
    if buildah images -q; then
      echo "Stopping and removing Buildah container..."
      buildah rm -a
      buildah rmi -a -f
      buildah prune -a -f
    fi

  else
    echo "No container runtime is installed. Please install Docker, Podman, or Buildah to proceed."
    exit 1
  fi
}

# Stop running watsonx discovery kibana.
echo ""
echo "-------------------------------------------------------------------------------"
echo "K I B A N A * R U N N I N G * S T A T U S | W A T S O N X  D I S C O V E R Y"
echo "-------------------------------------------------------------------------------"
if command_exists podman && [ "$(podman ps -a -q -f name=ibm-watsonx-discovery-kibana)" ]; then
  echo "Stopping and removing existing Kibana Podman container: ibm-watsonx-discovery-kibana..."
  image_uninstaller
  echo "Your Local Watsonx Discovery Kibana Instance Stopped!"
elif command_exists docker && [ "$(docker ps -a -q -f name=ibm-watsonx-discovery-kibana)" ]; then
  echo "Stopping and removing existing Kibana Docker container: ibm-watsonx-discovery-kibana..."
  image_uninstaller
  echo "Your Local Watsonx Discovery Kibana Instance Stopped!"
elif command_exists buildah && [ "$(buildah ps -a -q -f name=ibm-watsonx-discovery-kibana)" ]; then
  echo "Stopping and removing existing Kibana Buildah container: ibm-watsonx-discovery-kibana..."
  image_uninstaller
  echo "Your Local Watsonx Discovery Kibana Instance Stopped!"
else
  echo "Local container ibm-watsonx-discovery-kibana does not exist."
  echo "[start-run.sh], if you want to start Local Watsonx Discovery Kibana Instance."
fi
#!/bin/bash
###############################################################
# Software: IBM Watsonx Kibana Installation Tool
# Use: For Development of Watsonx Applications
# Audience: General Use
# Author: Dr. Jeffrey Chijioke-Uche, Ph.D
# Company: IBM Corporation
# Version 1.0
# License ID: 3.0 (the "License")
# Engine: Start Engine
##############################################################

# Load the environment variables from the .env file
echo ""
echo "-------------------------------------------------------------------------------"
echo "K I B A N A * R U N N I N G * S T A T U S | W A T S O N X  D I S C O V E R Y"
echo "-------------------------------------------------------------------------------"
if [ -f .env ]; then
  echo ".env found, nice practice!"
  TLSV=00000
  source .env
  source kibana_reset.sh
else
  echo ".env file not found! - Did you actually create one?"
  exit 1
fi

# Stop running watsonx discovery kibana.
echo ""
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
  echo "Local container ibm-watsonx-discovery-kibana does not exist, please wait.."
  sleep 10
  echo "Creating it, Please wait..."
fi

# Operating Systems:
source operating-systems.sh  

# Runs:
if [ "$ARCH" = "linux-amd64-arm64" ]; then
    # Run Kibana Container: Local: LinuxOS
    source kibana-engine-linux.sh
    tls_set_and_run_option
elif [ "$ARCH" = "mac-amd64-arm64" ]; then
    # Run Kibana Container: Local: MacOS
    source kibana-engine-mac.sh
    tls_set_and_run_option
elif [ "$ARCH" = "windows-x86-x64" ]; then
    # Run Kibana Container: Local: Windows WSL
    source kibana-engine-win.sh
    tls_set_and_run_option
else
    echo "Your Operating System is not supported at this time."
    exit 1
fi

# Start Time
echo ""
echo "Starting Kibana:"
echo "Kibana running, please wait while Watsonx Discovery Kibana completely starts..."
sleep 40
echo "Watsonx Kibana is supposed to have started by now."
echo "Go to http://localhost:$KIBANA_PORT to start your integration."
echo "Welcome to IBM Watsonx Discovery Kibana"

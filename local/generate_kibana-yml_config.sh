#!/bin/bash
#######################################################
# Software: IBM Watsonx Kibana Installation Tool
# Use: For Development of Watsonx Applications
# Audience: General Use
# Author: Dr. Jeffrey Chijioke-Uche, Ph.D
# Company: IBM Corporation
# Version 1.0
# License ID: 3.0 (the "License")
# Engine: Start Engine
#######################################################

# Load the environment variables from the .env file
if [ -f .env ]; then
  echo ".env found, loading environment variables..."
  source .env
else
  echo ".env file not found! - Did you actually create one?"
  exit 1
fi

# Kibana Configurations:
if [ "$ARCH" = "linux-amd64-arm64" ]; then
    # Generate the kibana.yml file from the template
    echo "Generating kibana.yml from kibana.yml.template..."
    envsubst < kibana.yml.template > kibana.yml
    echo "kibana.yml has been generated and overwritten with the provided environment variables."
elif [ "$ARCH" = "mac-amd64-arm64" ]; then
    # Generate the kibana.yml file from the template
    echo "Generating kibana.yml from kibana.yml.template..."
    envsubst < kibana.yml.template > kibana.yml
    echo "kibana.yml has been generated and overwritten with the provided environment variables."
elif [ "$ARCH" = "windows-x86-x64" ]; then
    # Generate the kibana.yml file from the template
    echo "Generating kibana.yml from kibana.yml.template..."
    envsubst < kibana.yml.template > kibana.yml
    echo "kibana.yml has been generated and overwritten with the provided environment variables."
else
    echo "No Kibana.yml generated."
    exit 1
fi

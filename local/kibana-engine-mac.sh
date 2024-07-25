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
# DO NOT MODIFY THIS FILE
##############################################################

# Check if the kibana home directory exists:
if [ ! -d "/usr/local/share/kibana/config" ]; then
  echo "/usr/local/share/kibana/config path does not exist."
  echo "Check if you have administrator permissions to access the path."
  exit 1
else
  echo "/usr/local/share/kibana/config path exists. continue.."
fi

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

 # Function to run Kibana container based on TLS version
tls_set_and_run_option() {
  export ELASTICSEARCH_ENDPOINT="https://$ELASTICSEARCH_USERNAME:$ELASTICSEARCH_PASSWORD@$ELASTICSEARCH_HOST:$ELASTICSEARCH_PORT"
  if [[ "$TLSV" == "08262" ]]; then
    # Run Kibana Container: Local with certificate verification mode
    docker_run_command="docker run -d \
      --name ibm-watsonx-discovery-kibana \
      -p $KIBANA_PORT:$KIBANA_PORT \
      -e ELASTICSEARCH_HOSTS=\"$ELASTICSEARCH_ENDPOINT\" \
      -e ELASTICSEARCH_SSL_VERIFICATIONMODE=\"certificate\" \
      -v /usr/local/share/kibana/config:/usr/share/kibana/config \
      quay.io/redhatcloud/access-registry-elk-kibana:$ELASTICSEARCH_VERSION"

    podman_run_command="podman run -d \
      --name ibm-watsonx-discovery-kibana \
      -p $KIBANA_PORT:$KIBANA_PORT \
      -e ELASTICSEARCH_HOSTS=\"$ELASTICSEARCH_ENDPOINT\" \
      -e ELASTICSEARCH_SSL_VERIFICATIONMODE=\"certificate\" \
      -v /usr/local/share/kibana/config:/usr/share/kibana/config \
      quay.io/redhatcloud/access-registry-elk-kibana:$ELASTICSEARCH_VERSION"

    buildah_run_command="buildah run -d \
      --name ibm-watsonx-discovery-kibana \
      -p $KIBANA_PORT:$KIBANA_PORT \
      -e ELASTICSEARCH_HOSTS=\"$ELASTICSEARCH_ENDPOINT\" \
      -e ELASTICSEARCH_SSL_VERIFICATIONMODE=\"certificate\" \
      -v /usr/local/share/kibana/config:/usr/share/kibana/config \
      quay.io/redhatcloud/access-registry-elk-kibana:$ELASTICSEARCH_VERSION"
  else
    # Run Kibana Container: Local with no SSL verification mode
    docker_run_command="docker run -d \
      --name ibm-watsonx-discovery-kibana \
      -p $KIBANA_PORT:$KIBANA_PORT \
      -e ELASTICSEARCH_HOSTS=\"$ELASTICSEARCH_ENDPOINT\" \
      -e ELASTICSEARCH_SSL_VERIFICATIONMODE=\"none\" \
      -v /usr/local/share/kibana/config:/usr/share/kibana/config \
      quay.io/redhatcloud/access-registry-elk-kibana:$ELASTICSEARCH_VERSION"

    podman_run_command="podman run -d \
      --name ibm-watsonx-discovery-kibana \
      -p $KIBANA_PORT:$KIBANA_PORT \
      -e ELASTICSEARCH_HOSTS=\"$ELASTICSEARCH_ENDPOINT\" \
      -e ELASTICSEARCH_SSL_VERIFICATIONMODE=\"none\" \
      -v /usr/local/share/kibana/config:/usr/share/kibana/config \
      quay.io/redhatcloud/access-registry-elk-kibana:$ELASTICSEARCH_VERSION"

    buildah_run_command="buildah run -d \
      --name ibm-watsonx-discovery-kibana \
      -p $KIBANA_PORT:$KIBANA_PORT \
      -e ELASTICSEARCH_HOSTS=\"$ELASTICSEARCH_ENDPOINT\" \
      -e ELASTICSEARCH_SSL_VERIFICATIONMODE=\"none\" \
      -v /usr/local/share/kibana/config:/usr/share/kibana/config \
      quay.io/redhatcloud/access-registry-elk-kibana:$ELASTICSEARCH_VERSION"
  fi

  # Check for installations and run the appropriate command
  if command_exists podman; then
    echo "Using Podman to run Kibana."
    eval "$podman_run_command"
  elif command_exists docker; then
    echo "Using Docker to run Kibana."
    eval "$docker_run_command"
  elif command_exists buildah; then
    echo "Using Buildah to run Kibana."
    eval "$buildah_run_command"
  else
    echo "No container runtime found. Please install Docker, Podman, or Buildah."
    exit 1
  fi
}

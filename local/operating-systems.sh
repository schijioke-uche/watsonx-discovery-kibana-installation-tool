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

# Supported Local Operating Systems:
if [ "$ARCH" = "linux-amd64-arm64" ]; then
    # Create essentials:
    mkdir -p /var/lib/kibana/config
    source generate_kibana-yml_config.sh
    # Copy Essential development files for Linux
    cp cacert.crt /var/lib/kibana/config/cacert
    cp kibana.yml /var/lib/kibana/config/kibana.yml   
elif [ "$ARCH" = "mac-amd64-arm64" ]; then
    # Create essentials:
    mkdir -p /usr/local/share/kibana/config
    source generate_kibana-yml_config.sh
    # Copy Essential development files for Mac
    cp cacert.crt /usr/local/share/kibana/config/cacert
    cp kibana.yml /usr/local/share/kibana/config/kibana.yml
elif [ "$ARCH" = "windows-x86-x64" ]; then
    # Create essentials:
    mkdir -p /mnt/c/Users/local/share/kibana/config
    source generate_kibana-yml_config.sh
    # Copy Essential development files for Windows
    cp cacert.crt /mnt/c/Users/local/share/kibana/config/cacert
    cp kibana.yml /mnt/c/Users/local/share/kibana/config/kibana.yml
else
    echo "Your Operating System is not supported at this time."
    exit 1
fi
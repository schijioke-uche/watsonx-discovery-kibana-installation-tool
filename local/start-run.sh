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

# Function to set the operating system:
set_operating_system() {
  echo ""
  echo "O P E R A T I N G   S Y S T E M   S E L E C T I O N:"
  echo "What type of Operating System are you using?"
  echo "Options are:"
  echo "1: LinuxOS"
  echo "2: MacOS"
  echo "3: WindowsOS WSL"

  read -p "Enter the option number (1/2/3): " os_choice

  case $os_choice in
    1)
      ARCH="linux-amd64-arm64"
      ;;
    2)
      ARCH="mac-amd64-arm64"
      ;;
    3)
      ARCH="windows-x86-x64"
      ;;
    *)
      echo "Invalid option. Exiting..."
      exit 1
      ;;
  esac

  export ARCH
}

# Function to prompt user and execute corresponding script:
run_kibana() {
  while true; do
    echo ""
    echo "K I B A N A   I N S T A N C E   S E L E C T I O N:"
    echo "Which Local Watsonx Discovery Kibana Instance do you prefer?:"
    echo "1. Run kibana-L1 (Will verify the watsonx discovery certificate)"
    echo "2. Run kibana-L2 (Will not verify the watsonx discovery certificate)"
    echo "0. Quit"
    read -p "Enter your choice of Kibana local Instance (1/2/0): " choice

    case $choice in
      1)
        echo "Running kibana-L1..."
        source kibana-L1.sh
        break
        ;;
      2)
        echo "Running kibana-L2..."
        source kibana-L2.sh
        break
        ;;
      0)
        echo "Quitting..."
        exit 0
        ;;
      *)
        echo "Invalid option. Please enter 1, 2, or 0."
        ;;
    esac
  done
}
# Run::
set_operating_system
run_kibana

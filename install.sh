#!/bin/bash

lightblue=`tput setaf 14` 
green=`tput setaf 46`     
RED=`tput setaf 196`      
yellow=`tput setaf 11`    
purple=`tput setaf 129`   
reset=`tput sgr0` 

clear

# Detect the operating system
OS="$(uname -s)"

if [ $(whoami) = "root" ]; then
    echo -e "${RED}[-]Don't use Moriarty Project with root. \n[!]You have to use it with a normal account"
    exit 1
fi

case "${OS}" in
    Linux*)
        echo -e "${lightblue}[+]${yellow} Detected Linux system"
        echo -e "${lightblue}[+]${green} Installing dependencies using apt..."
        sudo apt update && sudo apt full-upgrade -y 
        sudo apt install python3 -y && sudo apt install python3-pip -y
        ;;
    Darwin*)
        echo -e "${lightblue}[+]${yellow} Detected macOS system"
        echo -e "${lightblue}[+]${green} Installing dependencies using Homebrew..."
        
        # Check if Homebrew is installed
        if ! command -v brew &> /dev/null; then
            echo -e "${yellow}[!] Homebrew not found. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        
        # Install Python3 and pip if not already installed
        if ! command -v python3 &> /dev/null; then
            brew install python3
        fi
        ;;
    *)
        echo -e "${RED}[-] Unsupported operating system: ${OS}"
        echo -e "${RED}[-] This script supports Linux and macOS only"
        exit 1
        ;;
esac

echo -e "${lightblue}[+]${green} Setting up Python environment..."
if [ "$OS" = "Darwin" ]; then
    # macOS - create virtual environment to avoid externally managed environment issues
    echo -e "${lightblue}[+]${yellow} Creating virtual environment..."
    python3 -m venv moriarty_env
    echo -e "${lightblue}[+]${green} Installing Python dependencies in virtual environment..."
    source moriarty_env/bin/activate
    pip install -r requirements.txt
    python -m playwright install
else
    # Linux
    pip3 install -r requirements.txt
    python3 -m playwright install
fi

echo -e "${lightblue}[+]${green} Installation is finished. You can run 'run.sh' file now."


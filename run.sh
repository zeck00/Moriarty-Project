#!/bin/bash

# Color definitions
yellow=`tput setaf 11`
reset=`tput sgr0`

clear
echo "Moriarty Project Remastered V4.1.1"
echo "Github:https://github.com/AzizKpln/Moriarty-Project"
echo -e "Linkedin:https://www.linkedin.com/in/aziz-k-074604170/\n"

# Detect the operating system and get local IP
OS="$(uname -s)"
if [ "$OS" = "Darwin" ]; then
    # macOS
    LOCAL_IP=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -n1)
else
    # Linux
    LOCAL_IP=$(hostname -I | awk '{print $1}')
fi

echo "Project is currently running. If your browser not showing up,"
echo -e "Please go to this link: http://${LOCAL_IP}:8080\n"

echo "Press CTRL+C to kill the webserver."

# Check if we're on macOS and virtual environment exists
if [ "$OS" = "Darwin" ] && [ -d "moriarty_env" ]; then
    echo -e "${yellow}[+] Using virtual environment on macOS..."
    bash startBrowser.sh &
    source moriarty_env/bin/activate && python3 MoriartyProject.py &> /dev/null
else
    bash startBrowser.sh &
    python3 MoriartyProject.py &> /dev/null
fi



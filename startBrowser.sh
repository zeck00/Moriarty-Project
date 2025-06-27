#!/bin/bash

sleep 2

# Detect the operating system
OS="$(uname -s)"

# Get the local IP address in a cross-platform way
if [ "$OS" = "Darwin" ]; then
    # macOS
    LOCAL_IP=$(ifconfig | grep "inet " | grep -v 127.0.0.1 | awk '{print $2}' | head -n1)
    # Try to open with default browser first, then Safari
    if command -v open &> /dev/null; then
        open "http://${LOCAL_IP}:8080" &>/dev/null &
    elif command -v safari &> /dev/null; then
        safari "http://${LOCAL_IP}:8080" &>/dev/null &
    fi
else
    # Linux
    LOCAL_IP=$(hostname -I | awk '{print $1}')
    if command -v firefox &> /dev/null; then
        firefox "http://${LOCAL_IP}:8080" &>/dev/null &
    elif command -v google-chrome &> /dev/null; then
        google-chrome "http://${LOCAL_IP}:8080" &>/dev/null &
    elif command -v chromium &> /dev/null; then
        chromium "http://${LOCAL_IP}:8080" &>/dev/null &
    fi
fi

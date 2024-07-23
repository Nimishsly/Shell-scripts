#!/bin/bash

# Function to check the status of the application
check_status() {
    local url="$1"
    local response_code=$(curl -sL -w "%{http_code}" "$url" -o /dev/null)

    if [ "$response_code" = "200" ]; then
        echo "[$(date)] Application is UP. Status code: $response_code"
    else
        echo "[$(date)] Application is DOWN or not responding correctly. Status code: $response_code"
    fi
}

# Function to display system uptime
show_uptime() {
    echo "System Uptime:"
    uptime
}

# Main script execution
echo "Starting application status check..."
show_uptime

# Check the status of google.com
check_status "http://www.google.com"

echo "Finished application status check."

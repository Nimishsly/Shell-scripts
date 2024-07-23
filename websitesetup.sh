#!/usr/bin/bash

# Installing Dependencies
echo "##################################"
echo "Installing packages"
echo "##################################"
sudo apt update
sudo apt install -y wget unzip apache2
echo

# Start and Enable Service
echo "Start and enable Apache2 service"
echo "##################################"
sudo systemctl start apache2
sudo systemctl enable apache2
echo

# Creating temp directory
echo "Creating temporary directory and downloading files"
echo "##################################"
mkdir -p /tmp/webfiles
cd /tmp/webfiles || { echo "Failed to change directory to /tmp/webfiles"; exit 1; }

# Download and unzip the file
# Replace "http://example.com/filename.zip" with the actual URL
echo "Downloading and extracting files"
echo "##################################"
wget http://example.com/filename.zip  # Update this URL
unzip filename.zip  # Update this file name if necessary

# Copy files to the web server root directory
echo "Copying files to /var/www/html/"
echo "##################################"
sudo cp -r ./* /var/www/html/

# Restart Apache2 service
echo "Restarting Apache2 service"
echo "##################################"
sudo systemctl restart apache2

# Cleanup
echo "Cleaning up temporary files"
echo "##################################"
rm -rf /tmp/webfiles

echo "Deployment completed successfully."

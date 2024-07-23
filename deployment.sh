#!/usr/bin/bash

# Define log file location
LOG_DIR="/var/log/deploy"
LOG_FILE="${LOG_DIR}/deploy.log"

# Create log directory if it doesn't exist
sudo mkdir -p "$LOG_DIR"

# Update the package list and store output in the log file
echo "Updating package list..."
sudo apt update 2>&1 | sudo tee "$LOG_FILE" > /dev/null

# Check if Apache2 is already installed
if dpkg -l | grep -q apache2; then
    echo "Apache2 is already installed."
else
    echo "Installing Apache2..."
    sudo apt install apache2 -y 2>&1 | sudo tee -a "$LOG_FILE" > /dev/null
fi

# Check if Apache2 is running
if systemctl is-active --quiet apache2; then
    echo "Apache2 is already running."
else
    echo "Starting Apache2 service..."
    sudo systemctl start apache2 2>&1 | sudo tee -a "$LOG_FILE" > /dev/null
fi

# Enable Apache2 to start on boot
echo "Enabling Apache2 to start on boot..."
sudo systemctl enable apache2 2>&1 | sudo tee -a "$LOG_FILE" > /dev/null

# Allow traffic on ports 80 and 443
echo "Configuring UFW to allow Apache traffic..."
sudo ufw allow 'Apache Full' 2>&1 | sudo tee -a "$LOG_FILE" > /dev/null
sudo ufw reload 2>&1 | sudo tee -a "$LOG_FILE" > /dev/null

# Copy website files to Apache's root directory
echo "Copying site files to /var/www/html..."
sudo cp -r /path/to/your/site/* /var/www/html/ 2>&1 | sudo tee -a "$LOG_FILE" > /dev/null

# Set ownership and permissions
echo "Setting ownership and permissions..."
sudo chown -R www-data:www-data /var/www/html 2>&1 | sudo tee -a "$LOG_FILE" > /dev/null
sudo chmod -R 755 /var/www/html 2>&1 | sudo tee -a "$LOG_FILE" > /dev/null

# Verify and update Apache configuration
echo "Verifying and updating Apache configuration..."
sudo nano /etc/apache2/sites-available/000-default.conf

# Restart Apache2 to apply changes
echo "Restarting Apache2 service..."
sudo systemctl restart apache2 2>&1 | sudo tee -a "$LOG_FILE" > /dev/null

# Display the IP address
echo "Displaying IP address to access the webpage..."
ip addr show

#!/bin/bash
set -xe  # Debugging mode - log each command

# Update and install Apache
apt-get update -y
apt-get install -y apache2

# Ensure Apache is running and enabled at boot
systemctl start apache2
systemctl enable apache2

# Create a simple index.html page
echo "<html><body><h1>Welcome to My Application</h1></body></html>" | tee /var/www/html/index.html

# Set proper permissions
chown www-data:www-data /var/www/html/index.html
chmod 644 /var/www/html/index.html

# Restart Apache to apply changes
systemctl restart apache2

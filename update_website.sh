#!/bin/bash

# Set the path to the destination directory
dest_dir="/var/www/html/MyWebsite/Config"

# Set the paths to the target configuration files
nginx_conf_target="/etc/nginx/nginx.conf"
httpd_conf_target="/etc/httpd/conf/httpd.conf"

# Check if the 'MyWebsite' directory already exists
if [ -d "/var/www/html/MyWebsite" ]; then
  # Remove the existing 'MyWebsite' directory
  sudo rm -rf /var/www/html/MyWebsite
fi

# Clone the Git repository
git clone https://github.com/Najia-afk/MyWebsite.git /var/www/html/MyWebsite

# Check if /etc/ssl directory exists
if [ ! -d "/etc/ssl" ]; then
  # If it doesn't exist, create it
  sudo mkdir "/etc/ssl"
fi

# Check if adventurecryptoSSL.crt file exists in /var/www/html/MyWebsite/config
if [ -f "/var/www/html/MyWebsite/config/adventurecryptoSSL.crt" ]; then
  # If it exists, copy it to /etc/ssl
  sudo cp "/var/www/html/MyWebsite/config/adventurecryptoSSL.crt" "/etc/ssl"
fi

# Check if adventurecryptoSSL.key file exists in /var/www/html/MyWebsite/config
if [ -f "/var/www/html/MyWebsite/config/adventurecryptoSSL.key" ]; then
  # If it exists, copy it to /etc/ssl
  sudo cp "/var/www/html/MyWebsite/config/adventurecryptoSSL.key" "/etc/ssl"
fi

# Move the imported configuration files
# and rename them to the original configuration file names
sudo mv "$dest_dir/nginx.conf" "$nginx_conf_target"
# sudo mv "$dest_dir/httpd.conf" "$httpd_conf_target"

# Restart the Nginx and Apache services
# for the changes to take effect
sudo systemctl restart nginx
# sudo systemctl restart httpd

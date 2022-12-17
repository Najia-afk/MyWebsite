#!/bin/bash

# Set the path to the destination directory
dest_dir="/etc/MyWebsite/Config"

# Set the paths to the target configuration files
nginx_conf_target="/etc/nginx/nginx.conf"
httpd_conf_target="/etc/httpd/conf/httpd.conf"

# Check if the '/etc/MyWebsite' directory already exists
if [ -d "/etc/MyWebsite" ]; then
  # Remove the existing 'MyWebsite' directory
  sudo rm -rf /etc/MyWebsite
fi

# Check if the '/var/www/html/MyWebsite' directory already exists
if [ -d "/var/www/html/MyWebsite" ]; then
  # Remove the existing 'MyWebsite' directory
  sudo rm -rf /var/www/html/MyWebsite
fi

# Clone the Git repository
git clone https://github.com/Najia-afk/MyWebsite.git /etc/MyWebsite

# Check if /etc/ssl directory exists
if [ ! -d "/etc/ssl" ]; then
  # If it doesn't exist, create it
  sudo mkdir "/etc/ssl"
fi

# Check if adventurecryptoSSL.crt file exists in /var/www/html/MyWebsite/config
if [ -f "/etc/MyWebsite/Config/adventurecryptoSSL.crt" ]; then
  # If it exists, copy it to /etc/ssl
  sudo cp "/etc/MyWebsite/Config/adventurecryptoSSL.crt" "/etc/ssl"
fi

# Check if adventurecryptoSSL.key file exists in /var/www/html/MyWebsite/config
if [ -f "/etc/MyWebsite/Config/adventurecryptoSSL.key" ]; then
  # If it exists, copy it to /etc/ssl
  sudo cp "/etc/MyWebsite/Config/adventurecryptoSSL.key" "/etc/ssl"
fi

# Move everything from the /etc/MyWebsite/templates directory into /var/www/html/MyWebsite/templates and create the templates directory if it doesn't already exist,
sudo mkdir -p /var/www/html/MyWebsite/templates
sudo mv /etc/MyWebsite/templates/* /var/www/html/MyWebsite/templates/
sudo chmod -R 755 /var/www/html/MyWebsite/templates

# Move the imported configuration files
# and rename them to the original configuration file names
sudo mv "$dest_dir/nginx.conf" "$nginx_conf_target"
# sudo mv "$dest_dir/httpd.conf" "$httpd_conf_target"


# Start the web server
sudo bash /etc/MyWebsite/start_server.sh

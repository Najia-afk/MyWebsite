#!/bin/bash

# Set the key and certificate file paths
keyfile="/etc/ssl/adventurecryptoSSL.key"
certfile="/etc/ssl/adventurecryptoSSL.crt"

# Set the IP address and port to bind to
bind_address="0.0.0.0:8000"

# Set the path to the app module
app_path="/var/www/html/MyWebsite/app"

# Set the name of the app instance within the module
app_instance="app:app"

# Restart the Nginx service
sudo systemctl restart nginx

# Start the web server using gunicorn
sudo gunicorn --keyfile "$keyfile" --certfile "$certfile" --bind "$bind_address" "$app_path" "$app_instance" -D

# Restart the Nginx and Apache services
# for the changes to take effect
sudo systemctl restart nginx
# sudo systemctl restart httpd

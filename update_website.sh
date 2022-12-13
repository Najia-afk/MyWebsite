 1 #!/bin/bash
 2
 3 # Set the path to the destination directory
 4 dest_dir="/var/www/html/MyWebsite/Config"
 5
 6 # Set the paths to the target configuration files
 7 nginx_conf_target="/etc/nginx/nginx.conf"
 8 httpd_conf_target="/etc/httpd/conf/httpd.conf"
 9
10 # Check if the 'MyWebsite' directory already exists
11 if [ -d "/var/www/html/MyWebsite" ]; then
12   # Remove the existing 'MyWebsite' directory
13   sudo rm -rf /var/www/html/MyWebsite
14 fi
15
16 # Clone the Git repository
17 git clone https://github.com/Najia-afk/MyWebsite.git
18
19 # Move the imported configuration files
20 # and rename them to the original configuration file names
21 sudo mv "$dest_dir/nginx.conf" "$nginx_conf_target"
22 sudo mv "$dest_dir/httpd.conf" "$httpd_conf_target"
23
24 # Restart the Nginx and Apache services
25 # for the changes to take effect
26 sudo systemctl restart nginx
27 # sudo systemctl restart httpd
28

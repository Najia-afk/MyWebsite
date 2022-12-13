# Clone the Git repository
git clone https://github.com/Najia-afk/MyWebsite.git

# Set the paths to the files you want to import
nginx_conf_path="MyWebsite/nginx.conf"
httpd_conf_path="MyWebsite/httpd.conf"

# Set the path to the destination directory
dest_dir="/var/www/html/MyWebsite/Config"

# Copy the files to the destination directory
sudo cp "$nginx_conf_path" "$dest_dir"
sudo cp "$httpd_conf_path" "$dest_dir"

# Set the paths to the target configuration files
nginx_conf_target="/etc/nginx/nginx.conf"
httpd_conf_target="/etc/httpd/conf/httpd.conf"

# Replace the existing configuration files with the imported ones
sudo cp "$dest_dir/nginx.conf" "$nginx_conf_target"
sudo cp "$dest_dir/httpd.conf" "$httpd_conf_target"

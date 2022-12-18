# To install a web server on an Amazon Web Services (AWS) EC2 instance and serve a website, you can follow these steps:

1. Add a firewall rule to allow incoming traffic on port 443 for HTTPS and port 8000 for gunicorn:
  - Log in to the AWS Management Console.
  - Navigate to the "Security Groups" page in the "EC2" dashboard.
  - Select the security group that is associated with your EC2 instance.
  - Click the "Inbound Rules" tab, then click the "Edit" button.
  - Click the "Add Rule" button and choose "HTTPS" from the "Type" dropdown menu.
  - Leave the "Source" field as "Anywhere" and click the "Save" button.
  - Repeat the above steps to add a rule for port 8000.

2. If necessary, attach a static IP to your EC2 instance:
  - Navigate to the "Elastic IPs" page in the "EC2" dashboard.
  - Click the "Allocate new address" button.
  - Click the "Allocate" button to create a new static IP.
  - Select the new static IP and click the "Actions" button, then choose "Associate address".
  - Select your EC2 instance from the dropdown menu and click the "Associate" button.

3. Connect to your EC2 instance using SSH:
  - Open a terminal or command prompt window.
  - Navigate to the directory where your SSH private key is stored.
  - Run the following command to connect to your EC2 instance, replacing the IP address and path to your private key with the appropriate values:

      ```ssh -i "MyAWSKeyPath" username@publicserver_ip_address```

4. Install the required Python packages:
  - Run the following command to install Flask, requests, web3, and gunicorn:

      ```sudo pip3 install flask requests web3 gunicorn```

5. Create a directory to store your website files:
  - Run the following command to create a directory for your website files:

      ```sudo mkdir -p /var/www/html```

6. Install and start the nginx web server:
  - Run the following command to install nginx:

      ```sudo amazon-linux-extras install nginx1```

  - Run the following command to start the nginx service:

      ```sudo systemctl start nginx```

  - Run the following command to check the status of the nginx service:

      ```sudo systemctl status nginx```

7. Install Git:
  - Run the following command to install Git:

      ```sudo yum install git```

8. Create a script to update your website:
  - Create a script called "update_website.sh" in the "/var/www/html" directory with the following content:

      ```#!/bin/bash```
      
9. Clone the website repository:
 - Replace "USERNAME" and "WEBSITE" with your GitHub username and the name of your website repository, respectively.

      ```git clone https://github.com/USERNAME/WEBSITE.git /etc/```

10. Restart the web server!

      ```systemctl restart nginx```
      




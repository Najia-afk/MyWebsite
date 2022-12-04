## Flask app setup on Unix server

To set up your Flask app on a Unix server and enable HTTPS for secure communication, follow these steps:

1. Find a web hosting provider that offers Unix-based hosting and has support for Flask. Some popular providers are DigitalOcean, Vultr, and Linode.

2. Sign up for an account with your chosen web hosting provider and set up a server.

3. Connect to your server using ssh. For example:

```ssh username@server_ip_address```


4. Install Flask and the other dependencies for your app using the `pip` command. For example:

```pip3 install flask requests web3```

5. Upload your Flask app to the server using the `scp` command. For example:

```scp app.py username@server_ip_address:/var/www/html/```


6. Start your Flask app by running the following command:

```python3 app.py```


7. Generate a SSL/TLS certificate and key for your server using the `openssl` command. For example:

```openssl req -new -newkey rsa:4096 -days 365 -nodes -x509 -subj "/C=US/ST=California/L=San Francisco/O=My Company/CN=myserver" -keyout myserver.key -out myserver.crt```


8. Configure your Flask app to use the SSL/TLS certificate and key. For example:

```app = Flask(name)```
```app.run(ssl_context=('myserver.crt', 'myserver.key'))```


9. Restart your Flask app and access it using the `https` protocol. For example:

```https://server_ip_address:5000```


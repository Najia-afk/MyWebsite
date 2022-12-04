# Import the Flask library
from flask import Flask, request, jsonify
import json

# Import the requests and web3 libraries
import requests
import web3

# Import the re module for regular expressions
import re

# Create a Flask app instance
app = Flask(__name__)

# Define a function to add the header to the response
def add_header(response):
    response.headers['Access-Control-Allow-Origin'] = '*'
    return response

# Add the function as an after request handler for the Flask app
app.after_request(add_header)

# Define a route for the Flask app to handle incoming HTTP requests
@app.route('/getwalletbalance', methods=['GET'])
def getwalletbalance():
    # Set the base URL for the PolygonScan API
    base_url = "https://api.polygonscan.com/api"

    # Read the wallet address from the request object
    wallet_address = request.args.get("wallet_address")

    # Use a regular expression to check if the wallet address is valid
    pattern = "^0x[a-fA-F0-9]{40}$"
    if not re.match(pattern, wallet_address):
        return jsonify({"error": "Invalid wallet address"})

    # Read the API key from the apikey.txt file
    with open("apikey.txt", "r") as f:
        apikey = f.read()
    if not apikey:
        return jsonify({"error": "API key not found"})

    # Set the query parameters for the API request
    params = {
        "module": "account",
        "action": "balance",
        "address": wallet_address,
        "apikey": apikey
    }

    # Make a GET request to the API
    response = requests.get(base_url, params=params)

    # Check the status code of the response
    if response.status_code == 200:
        # Parse the JSON response
        data = response.json()

        # Extract the balance from the response
        balance = data["result"]

        # Convert the balance from a string to a float
        balance = float(balance)
    
        #Set up the web3 instance
        w3 = web3.Web3(web3.Web3.HTTPProvider("https://api.polygonscan.com/api"))

        # Convert the balance from Wei to Ether
        ether_balance = w3.fromWei(balance, "ether")
        
        # Replace the placeholder in the HTML page with the balance
        with open("templates/Main.html", "r") as f:
            html = f.read()
        html = html.replace("{{balance}}", str(ether_balance) + " Matic")
        
        # Return the modified HTML page
        # return html
        # Return the balance in Ether as a JSON object
        return jsonify({"balance": ether_balance})
    else:
        # Return an error message
        return jsonify({"error": "Error retrieving balance: " + response.text})

# Start the Flask app
if __name__ == "__main__":
    app.run()

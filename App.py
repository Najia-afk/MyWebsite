# Import the Flask library
from flask import Flask, request, jsonify
import json
import json  as json_data
import os


# Import the requests and web3 libraries
import requests
import web3

# Import the re module for regular expressions
import re

# Read the API key from the apikey.txt file
with open("apikey.txt", "r") as f:
     your_api_key = f.read()
     
# Set the API key as an environment variable in your Flask app
os.environ['API_KEY'] = your_api_key

# Create a Flask app instance
app = Flask(__name__)

# Define a variable to store the MATIC price
maticusd = 0.0

# Define a function to add the header to the response
def add_header(response):
    response.headers['Access-Control-Allow-Origin'] = '*'
    return response

# Add the function as an after request handler for the Flask app
app.after_request(add_header)

# Define a route for the Flask app to handle incoming HTTP requests


@app.route('/getlastmaticprice', methods=['GET'])
def getlastmaticprice():
    # Read the API key from the apikey.txt file
    api_key = os.getenv('API_KEY')
    if not api_key:
        return jsonify({"error": "API key not found"})

    # Set the API URL for the PolygonScan API
    api_url = "https://api.polygonscan.com/api?module=stats&action=maticprice&apikey=" + api_key

    # Make a GET request to the API
    response = requests.get(api_url)

    # Check the status code of the response
    if response.status_code == 200:
        # Parse the JSON response
        data = response.json()

        # Extract the MATIC price from the result object
        maticbtc = data["result"]["maticbtc"]
        maticusd = data["result"]["maticusd"]


        # Return the MATIC balance as a JSON object
        return jsonify({"maticbtc": maticbtc, "maticusd": maticusd})
    else:
        # Return an error message
        return jsonify({"error": "Error getting MATIC price: " + response.text})


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
    api_key = os.getenv('API_KEY')
    if not api_key:
        return jsonify({"error": "API key not found"})

    # Set the query parameters for the API request
    params = {
        "module": "account",
        "action": "balance",
        "address": wallet_address,
        "apikey": api_key
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

        # Get the MATIC price
        matic_balance_usd = maticusd

        # Multiply the balance by the MATIC price
        matic_balance_usd = balance * matic_balance_usd

        # Round the values to two decimal places
        matic_balance_usd = round(matic_balance_usd, 2)

        #Set up the web3 instance
        w3 = web3.Web3(web3.Web3.HTTPProvider("https://api.polygonscan.com/api"))

        # Convert the balance from Wei to Ether
        ether_balance = w3.fromWei(balance, "ether")
        
        # Round the values to two decimal places
        ether_balance = round(ether_balance, 2)

        # Replace the placeholder in the HTML page with the balance
        with open("templates/Main.html", "r") as f:
            html = f.read()
        html = html.replace("{{balance}}", str(ether_balance) + " Matic")

        # Set up the result object
        result = {
            "wallet_address": wallet_address,
            "balance": balance,
            "matic_balance_usd": matic_balance_usd
        }

        # Return the balance in Matic as a JSON object
        return jsonify(result)
    else:
        # Return an error message
        return jsonify({"error": "Error retrieving balance: " + response.text})

# Start the Flask app
if __name__ == "__main__":
    app.run()
    

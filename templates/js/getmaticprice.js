// Function to get the latest price of MATIC
function getMaticPrice() {
  // Fetch the latest price of MATIC from the API
  fetch("http://www.adventurecrypto.xyz/getlastmaticprice")
    .then(function(response) {
      // Check the Content-Type of the response
      if (response.headers.get("Content-Type") === "application/json") {
        // Parse the response as JSON
        return response.json();
      } else {
        // Show an error message if the response is not JSON
        console.log("Error: Response is not JSON");
        return; // Add a return statement here
      }
    })
    .then(function(data) {
      // Check if the response contains an error
      if (data.error === undefined) {
        // Get the MATIC price from the response
        var maticbtc = data.maticbtc;
        var maticusd = data.maticusd;

        // Update the MATIC price div with the latest price
        document.getElementById("matic-price").innerHTML = "MATIC price: " + maticusd + " USD";
      } else {
        // Show an error message
        console.log("Error getting MATIC price: " + data.error);
      }
    });
}

// Call the getMaticPrice function every 5 seconds
setInterval(getMaticPrice, 5000);

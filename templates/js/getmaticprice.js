// Function to get the latest price of MATIC
function getMaticPrice() {
  // Fetch the latest price of MATIC from the API
  fetch("http://54.77.21.112:5000/getlastmaticprice")
    .then(function(response) {
      return response.json();
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

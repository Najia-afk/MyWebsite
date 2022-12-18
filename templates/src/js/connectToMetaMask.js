function connectToMetaMask() {
  // Check if MetaMask is installed
  if (typeof ethereum !== 'undefined') {
    // Request permission to access the wallet
    ethereum.enable().then(function() {
      // Get the user's wallet address
      const walletAddress = ethereum.selectedAddress;
      // Display the wallet address in the HTML
      document.getElementById('wallet-address').innerHTML = `Wallet address: ${walletAddress}`;
      // Update the text of the meta-mask-button element
      const metaMaskButton = document.querySelector('.meta-mask-button');
      metaMaskButton.textContent = `Connected to ${walletAddress}`;
    }).catch(function(error) {
      // If the user denies permission, display an error message
      console.error(error);
      alert('You must allow access to your wallet to use this feature.');
    });
  } else {
    // If MetaMask is not installed, display an error message
    alert('Please install MetaMask to use this feature.');
  }
}

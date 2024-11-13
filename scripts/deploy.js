const hre = require("hardhat");

async function main() {
  
  const candidateNames = ["Vaibhav", "Manish", "Anand"];

  
 
  
  const myContract = await hre.ethers.deployContract("Voting", [candidateNames]);
  
  console.log("Deploying contract...");

 
  await myContract.waitForDeployment();

  // Log the contract address
  console.log("MyContract deployed to:", myContract.target);
}

// Run the script
main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
//0x5FbDB2315678afecb367f032d93F642f64180aa3
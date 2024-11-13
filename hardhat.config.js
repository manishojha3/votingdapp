require("@nomicfoundation/hardhat-toolbox");

;
/** @type import('hardhat/config').HardhatUserConfig */



module.exports = {
  solidity: "0.8.24",
  networks: {
    sepolia: {
      url: "https://eth-sepolia.g.alchemy.com/v2/U-Hx91P0B3Ui-t_a0BiVuZoo79C3g9gL",
      accounts: ["6bd9aaee0c7d88ccc66f3c42557fe0ad3b5326d50eb630353616d9bf52e846d3"],
    },
  },
};
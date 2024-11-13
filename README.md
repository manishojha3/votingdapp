# Voting DApp

## Overview
Voting DApp is a decentralized application built on the Ethereum blockchain that enables users to create and participate in transparent and tamper-proof voting processes. It leverages smart contracts to ensure secure and reliable voting outcomes.

## Features
- **Smart Contract**: Developed using Solidity for creating and managing the voting process.
- **DApp Frontend**: Interactive user interface for participants to cast votes.
- **Hardhat**: Used as the development environment to compile, test, and deploy contracts.

## Tech Stack
- **Solidity**: Smart contract programming.
- **JavaScript**: For scripts and DApp logic.
- **Hardhat**: Ethereum development framework.
- **HTML & CSS**: For frontend design.

## Getting Started

### Prerequisites
- Node.js and npm installed
- MetaMask or similar wallet extension

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/manishojha3/votingdapp.git
   ```
2. Navigate into the project directory:
   ```bash
   cd votingdapp
   ```
3. Install dependencies:
   ```bash
   npm install
   ```

### Running the Project
1. Compile the smart contracts:
   ```bash
   npx hardhat compile
   ```
2. Deploy the contract locally:
   ```bash
   npx hardhat node
   npx hardhat run scripts/deploy.js --network localhost
   ```
3. Start the DApp frontend:
   ```bash
   npm start
   ```

## Usage
- Connect your Ethereum wallet to interact with the DApp.
- Cast a vote and view real-time results.

## License
This project is open-sourced under the MIT License.

## Contributing
Feel free to submit issues or pull requests.

---

import React, { useEffect, useState } from "react";
import { ethers } from "ethers";
import VotingABI from './VotingABI.json'; // Import your contract's ABI

const App = () => {
  const [account, setAccount] = useState("");
  const [contract, setContract] = useState(null);
  const [provider, setProvider] = useState(null);
  const [votingIsOpen, setVotingIsOpen] = useState(false);
  const [loading, setLoading] = useState(true);
  const [candidates, setCandidates] = useState([]); // Initialize candidates state
  const [winner, setWinner] = useState(""); // Added winner state

  const contractAddress = "0xf69b11C372F8498E365704772f74731296E56428"; // Replace with your contract address

  const loadBlockchainData = async () => {
    if (typeof window.ethereum !== "undefined") {
      // Request MetaMask to connect accounts
      await window.ethereum.request({ method: "eth_requestAccounts" });

      // Create provider using ethers.js with MetaMask
      const provider = new ethers.BrowserProvider(window.ethereum);
      const signer = await provider.getSigner();

      const accounts = await window.ethereum.request({ method: "eth_accounts" });
      setAccount(accounts[0]);

      // Initialize the contract with the signer
      const votingContract = new ethers.Contract(contractAddress, VotingABI, signer);
      setContract(votingContract);

      try {
        // Call the votingOpen function (assuming it's a read-only view function)
        const isVotingOpen = await votingContract.votingOpen();
        setVotingIsOpen(isVotingOpen);

        // Fetch the list of candidates (assuming the contract has a function to get candidates)
        const candidatesCount = await votingContract.getCandidatesCount();
        let candidatesArray = [];
        for (let i = 0; i < candidatesCount; i++) {
          const candidate = await votingContract.candidates(i);
          candidatesArray.push(candidate);
        }
        setCandidates(candidatesArray); // Set the fetched candidates to state

      } catch (error) {
        console.error("Error calling contract functions:", error);
      }

      setProvider(provider);
    } else {
      alert("MetaMask is not installed!");
    }
    setLoading(false); // Set loading to false once data is loaded
  };

  useEffect(() => {
    loadBlockchainData();
  }, []);

  const voteForCandidate = async (index) => {
    if (contract) {
      try {
        const tx = await contract.vote(index);
        await tx.wait(); // Wait for the transaction to be mined
        window.location.reload(); // Reload the page to update vote count
      } catch (error) {
        console.error("Error voting for candidate:", error);
      }
    }
  };

  const closeVoting = async () => {
    if (contract) {
      try {
        const tx = await contract.closeVoting();
        await tx.wait(); // Wait for the transaction to be mined
        window.location.reload();
      } catch (error) {
        console.error("Error closing voting:", error);
      }
    }
  };

  const getWinner = async () => {
    if (contract) {
      try {
        const winnerName = await contract.getWinner();
        setWinner(winnerName);
      } catch (error) {
        console.error("Error getting the winner:", error);
      }
    }
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Voting DApp</h1>
        {!account && <p>Please connect your MetaMask wallet to interact.</p>}
        {account && <p>Connected Account: {account}</p>}
        <h2>Candidates</h2>
        {loading ? (
          <p>Loading candidates...</p>
        ) : (
          <ul>
            {candidates.map((candidate, index) => (
              <li key={index}>
                {candidate.name} - {candidate.voteCount.toString()} votes {/* Ensure voteCount is a string */}
                <button onClick={() => voteForCandidate(index)}>Vote</button>
              </li>
            ))}
          </ul>
        )}

        {votingIsOpen ? (
          <button onClick={closeVoting}>Close Voting</button>
        ) : (
          <div>
            <button onClick={getWinner}>Get Winner</button>
            {winner && <p>Winner: {winner}</p>}
          </div>
        )}
      </header>
    </div>
  );
}

export default App;

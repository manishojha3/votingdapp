// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Voting {
    
    struct Voter {
        bool voted;        // if true, that person has already voted
        uint vote;         // index of the voted candidate
    }

   
    struct Candidate {
        string name;       
        uint voteCount; 
    }

    address public admin;                  // Address of the contract admin
    bool public votingOpen;                // Tracks whether the voting is open
    mapping(address => Voter) public voters; // Map voters by their address
    Candidate[] public candidates;         // Array of candidates

    // Constructor to initialize the contract with the candidate names
    constructor(string[] memory candidateNames) {
        admin = msg.sender;  // Set the contract deployer as the admin
        votingOpen = true;   // Voting starts open

        // Add the candidates to the contract
        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
    }

    // Modifier to restrict actions to the admin only
    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this.");
        _;
    }

    // Modifier to check if voting is open
    modifier isVotingOpen() {
        require(votingOpen == true, "Voting is closed.");
        _;
    }

    // Function to vote for a candidate
    function vote(uint candidateIndex) public isVotingOpen {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You have already voted.");  // Ensure voter hasn't voted already
        require(candidateIndex < candidates.length, "Invalid candidate index.");

        sender.voted = true;     // Mark the voter as having voted
        sender.vote = candidateIndex;  // Record the vote
        candidates[candidateIndex].voteCount += 1; // Increment the vote count for the candidate
    }

    // Function to end voting (admin-only)
    function closeVoting() public onlyAdmin {
        votingOpen = false;  // Close the voting
    }

    // Function to get the total number of candidates
    function getCandidatesCount() public view returns (uint) {
        return candidates.length;
    }

    // Function to retrieve the details of a specific candidate
    function getCandidate(uint index) public view returns (string memory name, uint voteCount) {
        require(index < candidates.length, "Invalid candidate index.");
        Candidate memory candidate = candidates[index];
        return (candidate.name, candidate.voteCount);
    }

    // Function to declare the winner (admin-only)
    function getWinner() public view returns (string memory winnerName) {
        require(votingOpen == false, "Voting is still ongoing.");

        uint winningVoteCount = 0;
        uint winningCandidateIndex = 0;

        // Loop through all the candidates to find the one with the most votes
        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winningCandidateIndex = i;
            }
        }

        winnerName = candidates[winningCandidateIndex].name;
    }
}

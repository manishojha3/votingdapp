// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Voting {
    
    struct Voter {
        bool voted;        
        uint vote;         
    }

   
    struct Candidate {
        string name;       
        uint voteCount; 
    }

    address public admin;                 
    bool public votingOpen;               
    mapping(address => Voter) public voters; 
    Candidate[] public candidates;        rray of candidates

    
    constructor(string[] memory candidateNames) {
        admin = msg.sender; 
        votingOpen = true;   

        for (uint i = 0; i < candidateNames.length; i++) {
            candidates.push(Candidate({
                name: candidateNames[i],
                voteCount: 0
            }));
        }
    }

    modifier onlyAdmin() {
        require(msg.sender == admin, "Only admin can call this.");
        _;
    }

    modifier isVotingOpen() {
        require(votingOpen == true, "Voting is closed.");
        _;
    }

    function vote(uint candidateIndex) public isVotingOpen {
        Voter storage sender = voters[msg.sender];
        require(!sender.voted, "You have already voted.");  
        require(candidateIndex < candidates.length, "Invalid candidate index.");

        sender.voted = true;     
        sender.vote = candidateIndex;  
        candidates[candidateIndex].voteCount += 1;
    }

    function closeVoting() public onlyAdmin {
        votingOpen = false;  // Close the voting
    }

    function getCandidatesCount() public view returns (uint) {
        return candidates.length;
    }

    function getCandidate(uint index) public view returns (string memory name, uint voteCount) {
        require(index < candidates.length, "Invalid candidate index.");
        Candidate memory candidate = candidates[index];
        return (candidate.name, candidate.voteCount);
    }

    function getWinner() public view returns (string memory winnerName) {
        require(votingOpen == false, "Voting is still ongoing.");

        uint winningVoteCount = 0;
        uint winningCandidateIndex = 0;

        for (uint i = 0; i < candidates.length; i++) {
            if (candidates[i].voteCount > winningVoteCount) {
                winningVoteCount = candidates[i].voteCount;
                winningCandidateIndex = i;
            }
        }

        winnerName = candidates[winningCandidateIndex].name;
    }
}

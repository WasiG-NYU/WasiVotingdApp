// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

contract MyVoting { // Define the smart contract 

    // Represents the data structure for a candidate 
    struct Candidate {
        uint id; // unique id of the candidate
        string name; // name of the candidate
        uint voteCount; // number of votes the candidate has recived
    }

    address public owner; // Stores address of the contract owner (deployer)
    mapping (uint => Candidate) public candidates; // Maps a candidate ID to a Candidate struct
    mapping (address => bool) public hasVoted; // Tracks whether an address has already votes which prevents double voiting =
    uint public candidatesCount; // Stores the total number of candidates
    uint public votingEnd; // Stores the timestamp when voting ends

    // Sets the owner and voting duration 
    constructor(uint _durationMin) {
        owner = msg.sender; // Sets the deployer of the contract as the owner
        votingEnd = block.timestamp + (_durationMin * 1 minutes); 
        // Sets the voting time based on current time + duration
    }

    // Only the owner can add cadidates
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this!");
        // Reverts if the caller is not the owner 
        _; 
    }

    // Add a candidate
    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
        // Creates and stores a new candidate with 0 initial votes 
    }

    // Voting function 
    function vote(uint _candidateId) public { // Allows a user to vote for a candidate by ID
        require(block.timestamp < votingEnd, "Voting time has ended."); // Makes sure that voting is still ongoing
        require(!hasVoted[msg.sender], "You have already voted!"); // Makes sure that sender has not voted before
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate."); // Validates candidate ID
        hasVoted[msg.sender] = true; // Marks sender has having voted
        candidates[_candidateId].voteCount++; // Increments the vote count for selected candidate
    }
}

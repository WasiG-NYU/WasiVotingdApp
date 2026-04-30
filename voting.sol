// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

contract MyVoting { // Define the smart contract 

    // Represents the data structure for a candidate 
    struct Candidate {
        uint id; // unique id of the candidate
        string name; // name of the candidate
        uint voteCount; // number of votes the candidate has recived
    }

    address public owner;
    mapping (uint => Candidate) public candidates; 
    mapping (address => bool) public hasVoted; 
    uint public candidatesCount; 
    uint public votingEnd; 

    // Sets the owner and voting duration 
    constructor(uint _durationMin) {
        owner = msg.sender; 
        votingEnd = block.timestamp + (_durationMin * 1 minutes);
    }

    // Only the owner can add cadidates
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this!");
        _; 
    }

    // Add a candidate
    function addCandidate(string memory _name) public onlyOwner {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, _name, 0);
    }

    // Voting function 
    function vote(uint _candidateId) public {
        require(block.timestamp < votingEnd, "Voting time has ended.");
        require(!hasVoted[msg.sender], "You have already voted!");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate.");
        hasVoted[msg.sender] = true; 
        candidates[_candidateId].voteCount++;
    }
}

// SPDX-License-Identifier: MIT 

pragma solidity ^0.8.0;

contract MyVoting {
    struct Candidate {
        uint id; 
        string name; 
        uint voteCount;
    }
}

address public owner;
mapping (uint => Candiate) public candidates; 
mapping (address => bool) public hasVotes; 
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

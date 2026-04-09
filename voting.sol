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
mapping (uint => Candiate)
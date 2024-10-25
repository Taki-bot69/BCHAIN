// SPDX-License-Identifier: Hau
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol"; 

contract Alice is ERC20 {
    uint256 private constant _initialSupply = 100 * (10**18); // Initial supply of tokens

    struct Candidate {
        string name;
        uint256 voteCount;
    }

    struct Senator {
        string name;
        uint256 voteCount;
    }
     struct Office {
        string name;
        uint256 voteCount;
    }

    Candidate[] public candidates; 
    Senator [] public senators; 
    Office [] public officers;
    mapping(address => bool) public hasVoted; 
    mapping(address => bool) public hasVotedForSenator;
    mapping(address => bool) public hasVotedForofficer; 

    
    constructor() ERC20("Token", "ALC") {
        _mint(msg.sender, _initialSupply); 
        addCandidate("Kween Yasmin");
        addCandidate("Kencee Strait");
        addCandidate("Chris Mastree");
        addSenator("Lou Lawrence");
        addSenator("Idol Wistler");
        addSenator("Dic Raider");
        addOffice("Amy Stake");
        addOffice("Phil MacCraken");
        addOffice("Arnold Schwarzinegger");
        

        
    }
    // Function to add tokens
    function mintTokens(address to, uint256 amount) external{
    _mint(to, amount);
}

    // Function to add candidates
    function addCandidate(string memory name) internal {
        candidates.push(Candidate(name, 0));
    }

    // Function to add senators
    function addSenator(string memory name) internal {
        senators.push(Senator(name, 0));
    }
        // Function to add offcers
        function addOffice(string memory name) internal {
        officers.push(Office(name, 0));
    }

    // Function to vote for a candidate
    function voteForCandidate(uint256 candidateIndex) external {
        require(!hasVoted[msg.sender], "You have already voted for a candidate."); 
        require(candidateIndex < candidates.length, "Invalid candidate index."); 

        // Transfer 1 token from the voter to the contract as a voting fee
        require(balanceOf(msg.sender) >= 1 * (10 ** decimals()), "Not enough tokens to vote.");
        _transfer(msg.sender, address(this), 1 * (10 ** decimals())); 

        // Update voting state
        hasVoted[msg.sender] = true; // Mark the user as having voted for a candidate
        candidates[candidateIndex].voteCount += 1; // Increment the vote count for the selected candidate
    }

    // Function to vote for a senator
    function voteForSenator(uint256 senatorIndex) external {
        require(senatorIndex < senators.length, "Invalid senator index."); 
        require(!hasVotedForSenator[msg.sender], "You have already voted for this senator."); 
 

        // Transfer 1 token from the voter to the contract as a voting fee
        require(balanceOf(msg.sender) >= 1 * (10 ** decimals()), "Not enough tokens to vote.");
        _transfer(msg.sender, address(this), 1 * (10 ** decimals())); 

        // Update voting state
        hasVotedForSenator[msg.sender] = true; 
        senators[senatorIndex].voteCount += 1; // Increment the vote count for the selected senator
    }

     // Function to vote for a Offcer
    function voteForOfficer(uint256 OfficerIndex) external {
        require(!hasVotedForofficer[msg.sender], "You have already voted for a candidate."); 
        require(OfficerIndex< senators.length, "Invalid senator index."); 

        // Transfer 1 token from the voter to the contract as a voting fee
        require(balanceOf(msg.sender) >= 1 * (10 ** decimals()), "Not enough tokens to vote.");
        _transfer(msg.sender, address(this), 1 * (10 ** decimals())); 

        // Update voting state
        hasVotedForofficer[msg.sender] = true; // Mark the user as having voted for a candidate
        officers[OfficerIndex].voteCount += 1; // Increment the vote count for the selected candidate
    }

    // Function to get the candidates
    function getOfficers() external view returns (Office[] memory) {
        return officers;
    }

    // Function to get the senators
    function getSenators() external view returns (Senator[] memory) {
        return senators;
    }
        // Function to get the candidates
    function getCandidates() external view returns (Candidate[] memory) {
        return candidates;
    }

    // Function to get the vote count for a specific candidate
    function getVoteCount(uint256 candidateIndex) external view returns (uint256) {
        require(candidateIndex < candidates.length, "Invalid candidate index.");
        return candidates[candidateIndex].voteCount;
    }

    // Function to get the vote count for a specific senator
    function getSenatorVoteCount(uint256 senatorIndex) external view returns (uint256) {
        require(senatorIndex < senators.length, "Invalid senator index.");
        return senators[senatorIndex].voteCount;
    }
        // Function to get the vote count for a specific senator
    function getOfficerVoteCount(uint256 officerIndex) external view returns (uint256) {
        require(officerIndex < officers.length, "Invalid senator index.");
        return officers[officerIndex].voteCount;
    }
}

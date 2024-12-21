// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PuzzleCompetitionPlatform {
    
    // Structure to hold participant details
    struct Participant {
        address participantAddress;
        uint256 score;
    }

    // Mapping of participants
    mapping(address => Participant) public participants;

    // Owner of the contract
    address public owner;

    // Event to notify when a participant's score is updated
    event ScoreUpdated(address indexed participant, uint256 newScore);

    // Modifier to restrict access to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can perform this action");
        _;
    }

    // Constructor to set the contract owner
    constructor() {
        owner = msg.sender;
    }

    // Function to register a new participant
    function registerParticipant() external {
        require(participants[msg.sender].participantAddress == address(0), "Participant already registered");

        participants[msg.sender] = Participant({
            participantAddress: msg.sender,
            score: 0
        });
    }

    // Function to update a participant's score
    function updateScore(address _participant, uint256 _score) external onlyOwner {
        require(participants[_participant].participantAddress != address(0), "Participant not registered");

        participants[_participant].score = _score;

        emit ScoreUpdated(_participant, _score);
    }

    // Function to retrieve a participant's score
    function getScore(address _participant) external view returns (uint256) {
        require(participants[_participant].participantAddress != address(0), "Participant not registered");
        return participants[_participant].score;
    }
}

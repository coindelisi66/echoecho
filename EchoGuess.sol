// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EchoGuess {
    struct Guess {
        address user;
        string guess;
        uint256 timestamp;
    }

    Guess[] public guesses;
    mapping(address => uint256) public userGuessCount;
    uint256 public totalGuesses;

    event GuessAdded(address indexed user, string guess, uint256 index);

    function addGuess(string memory _guess) public {
        require(bytes(_guess).length > 0, "Guess cannot be empty");
        guesses.push(Guess(msg.sender, _guess, block.timestamp));
        userGuessCount[msg.sender]++;
        totalGuesses++;
        emit GuessAdded(msg.sender, _guess, totalGuesses - 1);
    }

    function getGuessCount() public view returns (uint256) {
        return totalGuesses;
    }

    function getGuess(uint256 index) public view returns (address, string memory, uint256) {
        require(index < guesses.length, "Invalid index");
        Guess memory guess = guesses[index];
        return (guess.user, guess.guess, guess.timestamp);
    }

    function claimReward() public view returns (string memory) {
        if (userGuessCount[msg.sender] >= 3) {
            return "Tebrikler! 0.02 DEGEN kazandiniz (mock)";
        }
        return "3 tahmine ulas, odul kazan!";
    }
}
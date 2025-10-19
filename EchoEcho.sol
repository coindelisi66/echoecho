// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract EchoEcho {
    struct Echo {
        address user;
        string castUrl;
        uint256 timestamp;
    }

    Echo[] public echoChain;
    mapping(address => uint256) public userEchoCount;
    uint256 public totalEchoes;

    event EchoAdded(address indexed user, string castUrl, uint256 index);

    function addEcho(string memory _castUrl) public {
        require(bytes(_castUrl).length > 0, "Cast URL cannot be empty");
        echoChain.push(Echo(msg.sender, _castUrl, block.timestamp));
        userEchoCount[msg.sender]++;
        totalEchoes++;
        emit EchoAdded(msg.sender, _castUrl, totalEchoes - 1);
    }

    function getEchoChainLength() public view returns (uint256) {
        return echoChain.length;
    }

    function getEcho(uint256 index) public view returns (address, string memory, uint256) {
        require(index < echoChain.length, "Invalid index");
        Echo memory echo = echoChain[index];
        return (echo.user, echo.castUrl, echo.timestamp);
    }

    function claimReward() public view returns (string memory) {
        if (userEchoCount[msg.sender] >= 5) {
            return "Tebrikler! 0.01 DEGEN kazandiniz (mock)";
        }
        return "5 echo'ya ulas, odul kazan!";
    }
}
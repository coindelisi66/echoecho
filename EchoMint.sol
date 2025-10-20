// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

contract EchoMint is ERC721 {
    uint256 public tokenId;
    mapping(address => uint256) public userEchoCount;

    event EchoMinted(address indexed user, uint256 tokenId);

    constructor() ERC721("EchoMint", "EMNT") {}

    function addEchoAndMint(string memory _uri) public {
        require(bytes(_uri).length > 0, "URI cannot be empty");
        userEchoCount[msg.sender]++;
        if (userEchoCount[msg.sender] >= 5) {
            _safeMint(msg.sender, tokenId);
            emit EchoMinted(msg.sender, tokenId);
            tokenId++;
        }
    }

    function getEchoCount(address user) public view returns (uint256) {
        return userEchoCount[user];
    }
}
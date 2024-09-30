// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";

contract MoodNft is ERC721 {
    error MoodNft__CantFlipMoodIfNotOwner();

    enum Mood {
        Happy,
        Sad
    }

    uint256 private s_tokenCounter;
    string private s_happySvgUri;
    string private s_sadSvgUri;
    mapping(uint256 => Mood) private s_tokenIdToMood;

    constructor(string memory happySvgUri, string memory sadSvgUri) ERC721("Mood NFT", "MN") {
        s_happySvgUri = happySvgUri;
        s_sadSvgUri = sadSvgUri;
        s_tokenCounter = 0;
    }

    function mintNft() public {
        s_tokenIdToMood[s_tokenCounter] = Mood.Happy;
        _safeMint(msg.sender, s_tokenCounter);
        s_tokenCounter++;
    }

    function flipMood(uint256 tokenId) public {
        if (!_isAuthorized(ownerOf(tokenId), msg.sender, tokenId)) {
            revert MoodNft__CantFlipMoodIfNotOwner();
        }
        if (s_tokenIdToMood[tokenId] == Mood.Happy) {
            s_tokenIdToMood[tokenId] = Mood.Sad;
        }
        if (s_tokenIdToMood[tokenId] == Mood.Sad) {
            s_tokenIdToMood[tokenId] = Mood.Happy;
        }
    }

    function _baseURI() internal pure override returns (string memory) {
        return "data:application/json;base64,";
    }

    function tokenURI(uint256 tokenId) public view override returns (string memory) {
        string memory imageURI;
        if (s_tokenIdToMood[tokenId] == Mood.Happy) {
            imageURI = s_happySvgUri;
        } else {
            imageURI = s_sadSvgUri;
        }

        bytes memory dataURI = abi.encodePacked(
            '{"name":"',
            name(),
            '","description":"An NFT that reflects the owners mood!","image":"',
            imageURI,
            '","attributes":[{"trait_type":"moodiness","value":100}]}'
        );

        return string(abi.encodePacked(_baseURI(), Base64.encode(dataURI)));
    }
}

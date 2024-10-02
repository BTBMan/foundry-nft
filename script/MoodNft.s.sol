// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Script, console} from "forge-std/Script.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {MoodNft} from "../src/MoodNft.sol";

contract MoodNftScript is Script {
    string public happySvg = vm.readFile("./images/dynamicNft/happy.svg");
    string public sadSvg = vm.readFile("./images/dynamicNft/sad.svg");

    function setUp() public {}

    function run() public returns (MoodNft moodNft) {
        vm.startBroadcast();
        moodNft = new MoodNft(svgToImageURI(happySvg), svgToImageURI(sadSvg));
        vm.stopBroadcast();
    }

    function svgToImageURI(string memory svg) public pure returns (string memory) {
        string memory baseURL = "data:image/svg+xml;base64,";
        string memory svgBase64Encoded = Base64.encode(abi.encodePacked(svg));

        return string(abi.encodePacked(baseURL, svgBase64Encoded));
    }
}

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {MoodNftScript} from "../script/MoodNft.s.sol";

contract MoodNftTest is Test {
    MoodNft public moodNft;
    address public user = makeAddr("user");

    function setUp() public {
        moodNft = new MoodNftScript().run();
    }

    function testViewTokenURI() public {
        vm.prank(user);
        moodNft.mintNft();
        console.log(moodNft.tokenURI(0));
    }
}

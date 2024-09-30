// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Test, console} from "forge-std/Test.sol";
import {MoodNft} from "../src/MoodNft.sol";
import {MoodNftScript} from "../script/MoodNft.s.sol";

contract MoodNftTest is Test {
    MoodNftScript public moodNftScript;
    MoodNft public moodNft;
    address public user = makeAddr("user");

    function setUp() public {
        moodNftScript = new MoodNftScript();
        moodNft = moodNftScript.run();
    }

    function testDeployConvertSvgToUri() public view {
        string memory expectedURI =
            "data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iNTAwIiBoZWlnaHQ9IjUwMCIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj48dGV4dCB4PSIwIiB5PSIxNSIgZmlsbD0icmVkIj5UaGlzIGlzIGEgdGVzdCBzdmchISE8L3RleHQ+PC9zdmc+";
        string memory svg =
            '<svg width="500" height="500" xmlns="http://www.w3.org/2000/svg"><text x="0" y="15" fill="red">This is a test svg!!!</text></svg>';

        assertEq(moodNftScript.svgToImageURI(svg), expectedURI);
    }

    // function testViewTokenURI() public {
    //     vm.prank(user);
    //     moodNft.mintNft();
    //     console.log(moodNft.tokenURI(0));
    // }
}

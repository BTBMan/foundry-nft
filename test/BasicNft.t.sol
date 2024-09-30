// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {BasicNftScript} from "../script/BasicNft.s.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;
    address public user = makeAddr("user");
    string public constant PUG =
        "ipfs://bafybeig37ioir76s7mg5oobetncojcm3c3hxasyd4rvid4jqhy4gkaheg4/?filename=0-PUG.json";

    function setUp() public {
        basicNft = new BasicNftScript().run();
    }

    function testNameIsCorrect() public view {
        string memory expectedName = "Dogie";
        string memory actualName = basicNft.name();

        // assertEq(expectedName, actualName);
        // assert(expectedName == actualName); // they can't compare each other, cause the string is the bytes of array
        assert(keccak256(abi.encodePacked(expectedName)) == keccak256(abi.encodePacked(actualName)));
    }

    function testCanMintAndHaveABalance() public {
        vm.prank(user);
        basicNft.mintNft(PUG);

        assert(basicNft.balanceOf(user) == 1);
        assert(keccak256(abi.encodePacked(basicNft.tokenURI(0))) == keccak256(abi.encodePacked(PUG)));
    }
}

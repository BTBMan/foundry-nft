// SPDX-License-Identifier: MIT
pragma solidity ^0.8.27;

import {Test, console} from "forge-std/Test.sol";
import {BasicNft} from "../src/BasicNft.sol";
import {BasicNftScript} from "../script/BasicNft.s.sol";

contract BasicNftTest is Test {
    BasicNft public basicNft;

    function setUp() public {
        basicNft = new BasicNftScript().run();
    }
}

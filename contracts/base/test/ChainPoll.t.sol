// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;
import "forge-std/Test.sol";
import "../src/ChainPoll.sol";

contract ChainPollTest is Test {
    ChainPoll public c;
    
    function setUp() public {
        c = new ChainPoll();
    }

    function testDeployment() public {
        assertTrue(address(c) != address(0));
    }
}

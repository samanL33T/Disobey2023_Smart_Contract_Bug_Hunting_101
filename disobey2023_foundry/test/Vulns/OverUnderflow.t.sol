// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../../src/Vulns/OverUnderFlow.sol";

contract OverUnderflowTest is Test {
    OverUnderFlow public flowww;
    function setUp() public {
        flowww = new OverUnderFlow();
    }
    function testOverflow() public {
        console.log("totalSupply before Overflow:",flowww.totalSupply() );
        console.log("======Starting the test for Integer Overflow ======");
        flowww.increaseSupply(1); //Adding 1 unit to the totalSupply of uint8 value.
        console.log("totalSupply after Overflow:",flowww.totalSupply() );
    }
    function testUnderflow() public {
        console.log("totalSupply at the contract initiation :",flowww.totalSupply() );
        console.log("Reducing 255 units from the total to make it zero");
        flowww.decreaseSupply(255);
        console.log("totalSupply before Underflow:",flowww.totalSupply() );
        console.log("======Starting the test for Integer Underflow ======");
        flowww.decreaseSupply(1); //Subtracting 1 unit from the totalSupply of uint8 value.
        console.log("totalSupply after Underflow:",flowww.totalSupply() );
    }
}



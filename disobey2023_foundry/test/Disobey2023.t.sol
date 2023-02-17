// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../src/Disobey2023.sol";

contract Disobey2023Test is Test {
    Disobey2023 public Dob2023;

    function setUp() public {
        Dob2023 = new Disobey2023();
        Dob2023.setConfYear(2023);
    }

    function testsetConfYear(uint) public {
        assertEq(Dob2023.confdate(), 2023);
    }
    function testFailsetConfName(string memory) public { //Function with 'testFail' prefix will pass if the test fails.
        assertEq(Dob2023.confname(), "Disobey 2020"); //assertEq() asserts the that the value of two arguments is equal
    }
}

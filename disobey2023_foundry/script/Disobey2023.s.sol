// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "forge-std/Script.sol";
import { Disobey2023 } from "src/Disobey2023.sol";

contract Disobey2023Script is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();
        new Disobey2023();
    }
}

// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11.0;

contract Delegator {
    address public owner;
    constructor() {
        owner = msg.sender;
    }

    function execute(address callee, bytes memory _code) public {
        (bool success,) = callee.delegatecall(_code);
        require(success, "Delegate call failed");
    }
}

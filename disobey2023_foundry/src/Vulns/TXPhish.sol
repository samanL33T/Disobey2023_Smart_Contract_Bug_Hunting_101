// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11.0;

contract TXPhish {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    function changeOwner(address newOwner) public {
        if (tx.origin == owner) {
            owner = newOwner;
        }
    }
}

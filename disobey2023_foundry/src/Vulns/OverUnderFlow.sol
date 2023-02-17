// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11.0;

contract OverUnderFlow {
    uint8 public totalSupply;

    constructor() {
        totalSupply = 255;
    }

    function increaseSupply(uint8 _value) public {
        unchecked{totalSupply += _value;}  // overflow
    }

    function decreaseSupply(uint8 _value) public {
        unchecked{totalSupply -= _value;}  // underflow
    }
    
}
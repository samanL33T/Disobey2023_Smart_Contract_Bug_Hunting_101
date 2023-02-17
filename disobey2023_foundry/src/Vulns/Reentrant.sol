// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract Reentrant {
    uint256 public balance;
    mapping (address => uint256) public deposits;

    function deposit() public payable {
        deposits[msg.sender] += msg.value;
        balance += msg.value;
    }

    function withdraw(uint256 amount) public {
        require(deposits[msg.sender] >= amount, "Not enough deposit");
        payable(msg.sender).transfer(amount);
        deposits[msg.sender] -= amount;

    }
}
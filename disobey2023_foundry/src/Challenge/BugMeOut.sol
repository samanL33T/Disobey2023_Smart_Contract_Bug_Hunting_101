// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BugMeOut {
    mapping(address => uint256) public balances;
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    modifier OnlyOwner(){
        require(msg.sender == owner,"You are not the Owner of this Contract");        
        _;
    }

    function deposit() public payable {
        require(msg.value > 0,"Enter amount to deposit");
        balances[msg.sender] += msg.value;
    }

    function withdrawFunds(uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient amount to withdraw");
        (bool sent,) = msg.sender.call{value: amount}("");
        require(sent, "Withdraw Failed");
        balances[msg.sender] -= amount;
    }

    function UpdateOwner(address newOwner) public {
        owner = newOwner;
    }

    function transferFunds(address payable recipient, uint256 amount) public {
        require(balances[msg.sender] >= amount, "Insufficient funds");
        balances[msg.sender] -= amount;
        (bool sent,) = recipient.call{value: amount}("");
        require(sent, "Failed to send Ether");
    }

    function moveFunds(address from, address to, uint256 amount) public OnlyOwner{
        require(balances[from] >= amount, "Insufficient funds");
        balances[from] -= amount;
        balances[to] += amount;
    }
}

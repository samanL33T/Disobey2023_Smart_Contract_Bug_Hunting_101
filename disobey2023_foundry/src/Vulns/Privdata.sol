// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

contract Privdata {
    struct User {
        address addr;
        uint256 secret;
    }

    mapping(address => User) private users;

    function addUser(uint256 _secret) public {
        users[msg.sender].addr = msg.sender;
        users[msg.sender].secret = _secret;
    }

    function getUserSecret(address _user) public view returns (uint256) {
        return users[_user].secret;
    }
}

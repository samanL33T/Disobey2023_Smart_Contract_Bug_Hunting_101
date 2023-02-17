// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11.0;
contract Disobey2023 {
    string public confname;
    uint public confdate;
    constructor(){
        confname = "Disobey 2023";
    }
    function setConfName(string memory CName) public returns(string memory){
        confname  = CName;                             
        return confname;
    }  
    function setConfYear(uint cDate) public returns(uint){
        require(cDate >= 2020 && cDate <= 2023);
        confdate  = cDate;                             
        return confdate;
    }   
}
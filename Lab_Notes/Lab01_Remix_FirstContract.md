# Lab 01 - Remix & Your First Smart Contract

## Learning Objectives
-------------------
- Getting familiar with Remix IDE
- Writing and deploying the first smart contract

## Remix IDE
------------
>URL: https://remix.ethereum.org/

### Interface contains:
- File explorer with Workspace showing some default folders - Contracts, scripts,tests etc.
- Terminal - For debugging details on contract execution
- Left Pane:
    - Search Option
    - Solidity Compiler Options
    - Deploy and Run Transaction - Options
    - Debugger
    - Plugins & Settings

### Solidity Compiler Options:
- Allows to select various compiler versions
- Provides an option to manually compile the contract/run the scripts
- Allows to publish the contract directly on IPFS/Swarm - File storage 
- Allows accessing ABI and bytecode of the contract.

### Deploy & Run Transaction Options:
Allows sending transactions to the current environment.

- You can choose between different environments or nodes to work on. For example:
    - In-browser sandboxed blockchain environment provided by Remix itself.
    - Injected Provider : i.e your Wallet connected to Test or Main net
    - Frameworks - local Ethereum test chains ran via various frameworks - Hardhat, Foundry etc.
    - External HTTP provider - Remote Ethereum node exposed over some http port.

- Additional things to note:
    - Account(s) : These are your/user wallet address(es) that will be used to deploy and interact with smart contracts.
    - Gas Limit : the maximum gas limit set for each transaction
    - Value : Wei/Ether - Required when a transaction needs some ether to be sent.
    - Contract - dropdown list of all the contracts inside 'contracts' folder. This can use used to select and deploy specific contracts.
    - 'At Address' - Can be used to load/interact with already deployed contract at certain address on the Ethereum blockchain
    -Deployed Contracts : shows the contracts we deployed/loaded along with their relevant getter/setter/callable  functions

### Debugger
Allows debugging specific transactions, based on their transaction hash.


## Your First smart Contract
-----------------------------

1. Go to `https://remix.ethereum.org/`
2. Under 'contracts' folder create a new file - `MyFirstContract.sol`
3. Use following code and save the contract:

```java
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7; // Solidity versioning identifier

// declaration of the contract , setting the contract name.
// declaring a state variable 'greeting' of type string
// state variables are permanently stored in the contract storage
// keyword 'public' allows the value to be accessed by anyone from outside the contract.
contract MyFirstContract{
    string public greeting; 
// initializing a constructor. This can only be called once during the contract deployment 
// and is used to initialize contract data/set initial values during deployment.
    constructor() { 
// default value of 'greeting' is set.
        greeting = "Hello Disobey 2023"; 
    }
// function to get the current value of 'greeting'
//'public' keyword means the function can be called by anyone
//'view' keyword means that the function does not modify the state of contract.
//returns a value of type 'string'
//'memory' keyword shows the data location of return variable.
// the getGreet() function can be completely skipped in this case, 
// as the public state variables get their own getter functions default. 
    function getGreet() public view returns(string memory){ 
                                                           
        return greeting;
    }
// function to update the current value of 'greeting'
// accepts one argument of type 'string' and 'memory' keyword shows the location of data.
//'public' keyword means the function can be called by anyone
// there's no 'view' keyword here, that means the function modifies the state of contract.
// function returns a value of type 'string' and 
//'memory' keyword shows the data location of return variable.
    function setGreet(string memory MyGreeting) public returns(string memory){
        greeting  = MyGreeting;                             
// updates the current value with user input.
        return greeting;
    }
      
}

```
4. Save the file and this will auto-compile the contract code. 
5. If it does not auto compile, g to 'Solidity Compiler' tab > Select the latest compiler version > Click 'Compile MyFirstContract.sol'
6. Go to 'Deploy & Run Transactions', select following options:
    - Environment: Remix VM
    - Contract - 'MyFirstContract'
7. Click 'Deploy' to Deploy the contract on Ethereum blockchain (Remix blockchain environment in this case)
8. You will notice a new contract under 'Deployed Contracts' with following function names that can be called by clicking:
    - `greeting` - Compiler creates default getter functions for all public state variables.
    - `getGreet` - Returns the current set greeting. 
    - `setGreet` - Allows to set the value of greeting to any string.
9. Play around with these functions to set and get greetings.

***Congratulations, you have written and deployed your first smart contract in Solidity***
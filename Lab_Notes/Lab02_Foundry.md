# Lab 02

## Learning Objectives
-----------------------
Getting familiar with Foundry
- Foundry tooling (forge, cast, anvil)
- Creating a foundry project
- Building a project 
- Writing and running a simple test
- Using existing foundry project

## Initial setup & Project Creation
----------------------------------
```bash
$ foundryup #This will update the current installaton of foundry to latest version
```

After the above step, following foundry utilities will be available:
- `forge` -  For building, testing and deploying the smart contracts
- `cast` - For making direct RPC calls to Ethereum blockchain. (Send transactions, read data on the chain etc.)
- `anvil` - For locally deploying a test Ethereum blockchain/ testnode
- `chisel` - Solidity REPL

Default project can be setup using below commands:

```bash
$ forge init disobey2023
OR
# Create a project from specific template
$ forge init --template <template location> <project name > 
```
This will create a project with default template and following directory structure:

```bash
$ tree . -d -L 1
.
├── lib         # for dependencies
├── script      # for deploying or build scripts
├── src         # for the smart contract source code
└── test        # for test scripts
```

The dependencies can be found in `lib` folder. Default project contains a `forge-std` library.
```bash
$ tree . -d -L 3
.
├── lib
│   └── forge-std
│       ├── lib
│       ├── src
│       └── test

```


## Building & Testing with foundry
----------------------------------

1. In the `src` folder, create a new file called `Disobey2023.sol`

```java
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;
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
```
The above contract allows anyone to set the `ConfName` and `ConfDate`. For `ConfDate`, only the dates between 2020 and 2023 are allowed.

2. Next, we write a test for the above contract. In the `test` folder, create a file called `Disobey2023.t.sol`

```java
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;

import "forge-std/Test.sol";
import "../src/Disobey2023.sol";

contract Disobey2023Test is Test {
    Disobey2023 public Dob2023;

    function setUp() public {               //setUp() is called before every test function call
        Dob2023 = new Disobey2023();        // Initializing the DisObey2023 contract
        Dob2023.setConfYear(2021);          // Setting the initial values for 'confdate'
    }

    function testsetConfYear(uint) public { //Function to be tested should have a prefix 'test'
        assertEq(Dob2023.confdate(), 2023); //assertEq() asserts that value of two arguments is equal
    }
    function testFailsetConfName(string memory) public { //Function with 'testFail' prefix will pass on test fail
        assertEq(Dob2023.confname(), "Disobey 2020"); //assertEq() asserts that value of two arguments is equal
    }
}
```
3. Test can be run using either of the following commands:
```bash
$ forge test  # will run all tests for all contracts
$ forge test --match-contract Disobey2023 # run tests for specific contract
$ forge test --match-test testFailsetConfName --match-contract Disobey2023 ## run specific test for specific contract
```

4. To build/compile the contract code, following command can be used:
```bash
$ forge build
```
The compiled contract ABIs can be found in the `out` folder:
```bash
$ tree .
.....
├── out
......
│   ├── Disobey2023.sol
│   │   └── Disobey2023.json
│   ├── Disobey2023.t.sol
│   │   └── Disobey2023Test.json
......
```

## Working with existing projects
----------------------------------
We will use an existing Foundry project for Ethernaut CTF solutions from `StErMi` as an example.
Following commands can be used to clone the project and install the dependencies:

```bash
$ git clone https://github.com/StErMi/foundry-ethernaut.git
$ cd foundry-ethernaut
$ forge install

OR
$ git submodule update --init --recursive # the dependencies are installed as git submodules
```

To test if everything works fine, any test can be run as follows:

```bash
$ forge test --match-contract Dex

#Successfull Output means the dependencies were installed properly:
Running 1 test for test/Dex.t.sol:TestDex
[PASS] testRunLevel() (gas: 2472678)
Test result: ok. 1 passed; 0 failed; finished in 2.71ms

Running 1 test for test/DexTwo.t.sol:TestDexTwo
[PASS] testRunLevel() (gas: 3819093)
Test result: ok. 1 passed; 0 failed; finished in 3.39ms
```

Any additional dependencies can also be installed directly from GitHub. For example:
```bash
$ forge install OpenZeppelin/openzeppelin-contracts
```

### remappings.txt & foundry.toml
The current remapping of library paths can be seen with following command:
```bash
$ forge remappings

# Output:
@openzeppelin/=lib/openzeppelin-contracts/
ds-test/=lib/forge-std/lib/ds-test/src/
forge-std/=lib/forge-std/src/
openzeppelin-contracts/=lib/openzeppelin-contracts/
```

When working with projects from frameworks like hardhat, it is possible to remap the paths to any other folders by adding the correct paths in `remappings.txt` file. For example:

```bash
$ cat remappings.txt

@openzeppelin/=node_modules/lib/openzeppelin-contracts/
ds-test/=node_modules/lib/forge-std/lib/ds-test/src/
forge-std/=node_modules/lib/forge-std/src/
openzeppelin-contracts/=node_modules/lib/openzeppelin-contracts/
```

`foundry.toml` file is a configuration file for foundry and can be used to configure various things like library path mappings (from remappings.txt), fuzz runs etc. 
For example, following `foundry.toml` file from the same `foundry-ethernaut` project from above shows the configuration done for fuzz-runs:

```bash
$ cat foundry.toml
[profile.default]
optimizer_runs = 200

[profile.ci]
fuzz-runs = 10_000
```

## Working with local and remote test nodes
1. Start a local Ethereum test node with `anvil`. 
This will generate some test addresses (EOAs) with 1000 Ether to play around.
On a separate terminal, run following command to start the local testnode:

```bash
$ anvil
........

Available Accounts
==================

(0) "0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266" (10000 ETH)
........

Private Keys
==================

(0) 0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
........
Listening on 127.0.0.1:8545  # HTTP RPC address for the local test node.
```
2. To use the Wallet address in a script or tests, set it's private key as an Environment variable:
```bash
$ export PRIVATE_KEY=0xac0974bec39a17e36ba4a6b4d238ff944bacb478cbed5efcae784d7bf4f2ff80
```  

3. We will deploy the same `Disobey2023.sol` contract created in the first foundry project on the local test node.
To deploy, we can write a deploy script and use foundry to deploy it for us.
Create a new file called `Disobey2023.s.sol` in `script` folder under the `disobey2023` foundry project created earlier.

```java
// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.11;
import "forge-std/Script.sol";
import { Disobey2023 } from "src/Disobey2023.sol";
contract Disobey2023Script is Script {
    function setUp() public {}

    function run() public {
        vm.broadcast();             //Foundry cheatcode  - boradcast, to deploy the contract.
        new Disobey2023();          //New instance of contract
    }
}

```

Alternatively, the contract can be deployed using `forge create` command:

```bash
forge create $LOCAL_NODE --private-key $PRIVATE_KEY src/Disobey2023.sol:Disobey2023
```

4. Run the following commands to execute the script and deploy the contract on local test node:
```bash
$ export LOCAL_NODE=http://localhost:8545 #Setting the environment variable for RPC URL
$ forge script script/Disobey2023.s.sol:Disobey2023Script --fork-url $LOCAL_NODE --private-key $PRIVATE_KEY --broadcast
```
Output of the above command shows the address where the contract is deployed:

```bash
[⠒] Compiling...
[⠑] Compiling 3 files with 0.8.17
[⠃] Solc 0.8.17 finished in 1.06s
Compiler run successful
Script ran successfully.
......
Contract Address: 0x5fbdb2315678afecb367f032d93f642f64180aa3 # The address of deployed contract
......
```

5. We can interact with the onchain contract using `cast` as follows:

```bash
$ export CONTRACT_ADD=0x5fbdb2315678afecb367f032d93f642f64180aa3
$ cast call $CONTRACT_ADD "confname()(string)" # calling default getter function for confname variable
$ cast send $CONTRACT_ADD "setConfName(string)" "Dis Obey 2023" --private-key $PRIVATE_KEY #Send a transaction to update confname variable
$ cast send $CONTRACT_ADD "setConfYear(uint)" 2023 --private-key $PRIVATE_KEY #Send a transaction to update confdate variable
$ cast call $CONTRACT_ADD "confdate()(uint)" # calling default getter function for confdate variable
```

6. Similarly, for remote test nodes or even mainnet, we can replace the environment variables for RPC URLs and private key with the values for remote test node or mainnet:

```bash
$ export LOCAL_NODE=<RPC_URL>
$ export PRIVATE_KEY= <Private Key from Your wallet>
```
